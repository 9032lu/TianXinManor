//
//  orderlistVC.m
//  ShengMengShangmao
//
//  Created by apple on 15-3-27.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "orderlistVC.h"
#import "orderDetailVC.h"
#import "commentVC.h"
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
#import "postOnWayVC.h"
#import "commentVC.h"
@interface orderlistVC ()

@end

@implementation orderlistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    TOP_VIEW(@"我的订单")

    NSLog(@"self.order ===%@",self.orders);
    self.navigationController.navigationBar.hidden=YES;

    NSArray*title_a=@[@"全部",@"待付款",@"待发货",@"待收货",@"待评论"];

    for (int i=0; i<5; i++) {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(_width*0.2*i, 64, _width*0.2, 50);
       // [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                if (i==0) {
            if ([self.orders isEqualToString:@"0"]) {
                _lastBtn=button;
                [button setTitleColor:APP_ClOUR forState:UIControlStateNormal];
            }else
            {
                 [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

            }
        }else
        {
            if (i==[self.orders intValue]) {
                _lastBtn=button;
                [button setTitleColor:APP_ClOUR forState:UIControlStateNormal];
            }else
            {
                 [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

            }

        }


        if (i>0) {
            UIView*shuxian=[[UIView alloc]initWithFrame:CGRectMake(0, 10, 1, 30)];
            shuxian.backgroundColor=RGB(234, 234, 234);
            [button addSubview:shuxian];


        }

        [button setTitle:[title_a objectAtIndex:i] forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont boldSystemFontOfSize:15];
        button.tag=i;
        [button addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        daipinglunBtn = button;
        [self.view addSubview:button];

    }


    UIView*hengxian=[[UIView alloc]initWithFrame:CGRectMake(0, 64+49, _width, 1)];
    hengxian.backgroundColor=RGB(234, 234, 234);
    [self.view addSubview:hengxian];


    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+50, _width, _height-64-50) ];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces=YES;
    _tableView.separatorColor=[UIColor whiteColor];
    [self.view addSubview:_tableView];

    _refesh=[SDRefreshHeaderView refreshView];
    __block orderlistVC*blockSelf=self;
    [_refesh addToScrollView:_tableView];

    _refesh.beginRefreshingOperation=^{
        [blockSelf getData:@""];


    };
    _refesh.isEffectedByNavigationController=NO;
    _refeshDown=[SDRefreshFooterView refreshView];
    [_refeshDown addToScrollView:_tableView];
    _refeshDown.beginRefreshingOperation=^{
        [blockSelf getData:@"more"];
        
        
    };
    
}
-(void)getData:(NSString*)more
{
    UIImageView*iv=(UIImageView*)[_tableView viewWithTag:22222];
    UILabel*la=(UILabel*)[_tableView viewWithTag:222222];
    [iv removeFromSuperview];
    [la removeFromSuperview];
    if (_lastBtn.tag==0) {
        LOADVIEW
        NSString*baseUrl=ORDER_LIST_URL(USERID);
        NSString*url;
        int  size=12;
        if ([more isEqualToString:@"more"]) {

            static int i=1;
            i++;
            url=[NSString stringWithFormat:@"%@&size=%d",baseUrl,size*i];
        }else
        {
            url=baseUrl;

        }
        NSLog(@"ORDER_LIST_URL==%@",url);

        [requestData getData:url complete:^(NSDictionary *dic) {
            [_refesh endRefreshing];
            [_refeshDown endRefreshing];
            LOADREMOVE
            NSArray *baseArray = [dic objectForKey:@"data"];
            NSMutableArray *arrr = [[NSMutableArray alloc]init];
            for (NSDictionary *dict in baseArray) {

                if ([dict[@"orderState"] doubleValue]<5) {
                    [arrr addObject:dict];
                }
            }

            _dataArray =[NSArray arrayWithArray:arrr];
            [_tableView reloadData];
            NSArray*nullA=@[];
            if (_dataArray.count==0||_dataArray==nullA||_dataArray==nil) {
                UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, (_height-260)/2, 50,50)];
                tanhao.image=[UIImage imageNamed:@"tanhao"];

                [_tableView addSubview:tanhao];

                UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (_height-260)/2+60, _width, 20)];
                tishi.text=@"没有相关订单";
                tishi.textColor=[UIColor grayColor];
                tishi.textAlignment=NSTextAlignmentCenter;
                tishi.font=[UIFont systemFontOfSize:14];
                [_tableView addSubview:tishi];

                tanhao.tag=22222;
                tishi.tag=222222;
            }
            
        }];
    }else
    {
        NSString*orstate;
        if (_lastBtn.tag==1) {
            orstate=@"0";
        }
        if (_lastBtn.tag==2) {
            orstate=@"1";
        }
        if (_lastBtn.tag==3) {
            orstate=@"2";
        }
        if (_lastBtn.tag==4) {
            orstate=@"3";
        }
        LOADVIEW
        NSString*baseUrl=ORDER_LIST_SORT_URL(USERID, orstate);
        NSString*url;
        int  size=12;
        if ([more isEqualToString:@"more"]) {

            static int i=1;
            i++;
            url=[NSString stringWithFormat:@"%@&size=%d",baseUrl,size*i];
        }else
        {
            url=baseUrl;
        }
         NSLog(@"%@",url);

        [requestData getData:url complete:^(NSDictionary *dic) {
            [_refesh endRefreshing];
            [_refeshDown endRefreshing];
            LOADREMOVE

           // NSLog(@"%@",dic);

            if ([orstate integerValue]!=3) {
                _dataArray =[dic objectForKey:@"data"];
            }else{
                NSArray *baseArray = [dic objectForKey:@"data"];
                NSMutableArray *arrr = [[NSMutableArray alloc]init];
                for (NSDictionary *dict in baseArray) {

                    if ([dict[@"shopId"] doubleValue]!=0) {
                        [arrr addObject:dict];
                    }
                }
                
                _dataArray =[NSArray arrayWithArray:arrr];
            }


            [_tableView reloadData];
            NSArray*nullA=@[];
            if (_dataArray.count==0||_dataArray==nullA||_dataArray==nil) {
                UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, (_height-260)/2, 50,50)];
                tanhao.image=[UIImage imageNamed:@"tanhao"];

                [_tableView addSubview:tanhao];

                UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (_height-260)/2+60, _width, 20)];
                tishi.text=@"没有相关订单";
                tishi.textColor=[UIColor grayColor];
                tishi.textAlignment=NSTextAlignmentCenter;
                tishi.font=[UIFont systemFontOfSize:14];
                [_tableView addSubview:tishi];

                tanhao.tag=22222;
                tishi.tag=222222;
            }


        }];

    }



}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary*dic=[_dataArray objectAtIndex:indexPath.row];
    NSArray*proListA=[dic objectForKey:@"proList"];
    return  proListA.count*(_width*0.2+30)+40+50+20;

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    tableView.separatorColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSArray*title_as=@[@"未付款",@"已付款",@"卖家已发货",@"交易成功",@"已评论",@"已关闭",@"退货/退款中",@" 同意退货/退款",@"拒绝退货/退款"];

    NSDictionary*dic=[_dataArray objectAtIndex:indexPath.row];
    NSArray*proListA=[dic objectForKey:@"proList"];

    NSString*count=[dic objectForKey:@"count"];
    NSString*orderState=[dic objectForKey:@"orderState"];
    NSString*orderPayment=[dic objectForKey:@"orderPayment"];

    NSString*realPrice=[dic objectForKey:@"realPrice"];
    NSString*shopId=[dic objectForKey:@"shopId"];

    id shopLogo=[dic objectForKey:@"shopLogo"];
    if (shopLogo==[NSNull null]) {
        shopLogo=@"";
    }
    id shopName=[dic objectForKey:@"shopName"];
    if (shopName==[NSNull null]) {
        shopName=@"";
        if ([shopId intValue]==0) {
            shopName=@"积分商品";
        }
    }else
    {
        if ([shopId intValue]==0) {
            shopName=@"积分商品";
        }
    }
    //NSString*count=[dic objectForKey:@"count"];



    float  hh=proListA.count*(_width*0.2+30)+40+50;

    UIView*bigView=[[UIView alloc]initWithFrame:CGRectMake(_width*0.02, 10, _width*0.96, hh)];
    bigView.layer.cornerRadius=5;
    bigView.layer.borderColor=RGB(234, 234,234).CGColor;
    bigView.layer.borderWidth=1;
    [cell.contentView addSubview:bigView];

#pragma mark店铺信息
//    UIImageView*shopLogo_V=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.05, 10, 20, 20)];
//    [shopLogo_V sd_setImageWithURL:[NSURL URLWithString:shopLogo] placeholderImage:[UIImage imageNamed:@"news"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//
//    }];
//    [bigView addSubview:shopLogo_V];


//    UILabel*name_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.08+20, 0, _width*0.3, 40)];
//    name_L.text=[NSString stringWithFormat:@"%@",shopName];
//    name_L.numberOfLines=0;
//    name_L.textAlignment=NSTextAlignmentLeft;
//    name_L.textColor=[UIColor darkGrayColor];
//    name_L.font=[UIFont boldSystemFontOfSize:14];
//    [bigView addSubview:name_L];

    UILabel*state_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.6, hh-120, _width*0.33, 40)];

    state_L.text=[title_as objectAtIndex:[orderState intValue]];

    state_L.numberOfLines=0;
    state_L.textAlignment=NSTextAlignmentRight;
    state_L.textColor=[UIColor orangeColor];
    state_L.font=[UIFont boldSystemFontOfSize:14];
    [bigView addSubview:state_L];
    NSLog(@"++++++++++%@++++++++%@",shopId,orderState);
    if ([shopId integerValue]==0) {

        if ( [orderState intValue]==1) {
            state_L.text = @"积分兑换";
        }

        if ( [orderState intValue]==3) {
            state_L.text = @"兑换成功";
        }
    }
    if ([orderState integerValue]==0) {
        if ([orderPayment integerValue]==3) {
            state_L.text = @"货到付款";

        }
        if ([orderPayment integerValue]==4) {
            state_L.text = @"上门自提";

        }
    }

//    UIView*hengxian1=[[UIView alloc]initWithFrame:CGRectMake(0, 40, _width*0.96, 1)];
//    hengxian1.backgroundColor=RGB(234, 234, 234);
//    [bigView addSubview:hengxian1];

#pragma mark 商品信息
    for (int i=0; i<proListA.count; i++) {
        NSDictionary*proDic=[proListA objectAtIndex:i];
        NSString*number=[proDic objectForKey:@"number"];
        //NSLog(@"%@",proDic);
        NSString*productImage=[proDic objectForKey:@"productImage"];
        NSString*productName=[proDic objectForKey:@"productName"];
        NSString*productPrice=[proDic objectForKey:@"productPrice"];

        UIView*product_view=[[UIView alloc]initWithFrame:CGRectMake(0, (_width*0.2+30)*i, _width*0.96, _width*0.2+30)];
       // product_view.backgroundColor=[UIColor grayColor];


        UIImageView*pro_iv=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.05+5, 15, _width*0.2, _width*0.2)];
        [pro_iv sd_setImageWithURL:[NSURL URLWithString:productImage] placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            float  W=(_width*0.2)*image.size.width/image.size.height;
//
//            pro_iv.frame = CGRectMake((_width*0.2-W)/2+5, 15, W, _width*0.2);

        }];
        [product_view addSubview:pro_iv];

        UILabel*price_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.76, 15, _width*0.18,_width*0.075)];
        price_L.text=[NSString stringWithFormat:@"￥%.2f",[productPrice doubleValue]];
        price_L.textAlignment=NSTextAlignmentRight;
        price_L.textColor=[UIColor darkGrayColor];
        price_L.font=[UIFont boldSystemFontOfSize:12];
        [product_view addSubview:price_L];


        UILabel*number_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.76, 15+_width*0.075, _width*0.18,_width*0.075)];
        number_L.text=[NSString stringWithFormat:@"x%@",number];
        number_L.textAlignment=NSTextAlignmentRight;
        number_L.textColor=[UIColor darkGrayColor];
        number_L.font=[UIFont boldSystemFontOfSize:12];
        [product_view addSubview:number_L];


        UILabel*p_name_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.29, 15, _width*0.47,_width*0.15)];
        p_name_L.text=[NSString stringWithFormat:@"%@",productName];
        p_name_L.numberOfLines=0;
        p_name_L.textAlignment=NSTextAlignmentLeft;
        p_name_L.textColor=[UIColor darkGrayColor];
        p_name_L.font=[UIFont boldSystemFontOfSize:16];
        [product_view addSubview:p_name_L];

        UIView*hengxian1=[[UIView alloc]initWithFrame:CGRectMake(0, _width*0.2+30-1, _width*0.96, 1)];
        hengxian1.backgroundColor=RGB(234, 234, 234);
        [product_view addSubview:hengxian1];

        [bigView addSubview:product_view];
    }
#pragma mark 商品信息
    UILabel*product_L=[[UILabel alloc]initWithFrame:CGRectMake(0, hh-90, _width*0.92,40)];
    product_L.text=[NSString stringWithFormat:@"共%@件商品  运费：%@  实付：%.2f",count,@"免邮",[realPrice doubleValue]];


    product_L.textAlignment=NSTextAlignmentRight;
    product_L.textColor=[UIColor darkGrayColor];
    product_L.font=[UIFont boldSystemFontOfSize:14];
    [bigView addSubview:product_L];


    UIView*hengxian2=[[UIView alloc]initWithFrame:CGRectMake(0, hh-50, _width*0.96, 1)];
    hengxian2.backgroundColor=RGB(234, 234, 234);
    [bigView addSubview:hengxian2];

    UIButton*jiesuanBtn=[UIButton  buttonWithType:UIButtonTypeCustom];
    jiesuanBtn.frame=CGRectMake(_width*0.74, hh-40, _width*0.2, 30);
    jiesuanBtn.backgroundColor=APP_ClOUR;
    [jiesuanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    jiesuanBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    jiesuanBtn.layer.cornerRadius=5;
    jiesuanBtn.tag=indexPath.row;
    [jiesuanBtn addTarget:self action:@selector(jiesuanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bigView addSubview:jiesuanBtn];

    UIButton*askBtn=[UIButton  buttonWithType:UIButtonTypeCustom];
    askBtn.frame=CGRectMake(_width*0.52, hh-40, _width*0.2, 30);
    askBtn.layer.borderColor=RGB(234, 234, 234).CGColor;
    askBtn.layer.borderWidth=1;
    askBtn.layer.cornerRadius=5;
    askBtn.tag=indexPath.row;

    [askBtn addTarget:self action:@selector(askBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [askBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    askBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [bigView addSubview:askBtn];

    int state=[orderState intValue];

    if (state==0) {
        [jiesuanBtn setTitle:@"查看订单" forState:UIControlStateNormal];
        [askBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    }
    if (state==1||state==4||state==5) {
        [jiesuanBtn setTitle:@"查看订单" forState:UIControlStateNormal];
        askBtn.hidden=YES;

    }
    if (state==2) {
        [jiesuanBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        [askBtn setTitle:@"查看物流" forState:UIControlStateNormal];

    }
    if (state==3) {
        if (([shopId intValue]==0)) {
            [jiesuanBtn setTitle:@"查看订单" forState:UIControlStateNormal];
        }else{
            [jiesuanBtn setTitle:@"去评论" forState:UIControlStateNormal];

        }
        askBtn.hidden=YES;

    }


    return cell;
}
-(void)askBtnClick:(UIButton*)button
{

    NSDictionary*dic=[_dataArray objectAtIndex:button.tag];
    NSString*orderState=[dic objectForKey:@"orderState"];
    if ([orderState intValue]==0) {
        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:nil message:@"你确定要删除这个订单？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag=button.tag;
        [alert show];
    }

    if([orderState intValue]==2){

        NSString*orderNo=[dic objectForKey:@"orderNo"];

        NSString *URL= [NSString stringWithFormat:@"%@/order/getExpress.action?orderNo=%@",BASE_URL,orderNo];
        NSLog(@"====%@===",URL);
        [requestData getData:URL complete:^(NSDictionary *dic) {
            if ([dic[@"flag"]integerValue]==1) {
                PUSH(postOnWayVC)
                vc.dic = dic;

            }else{
                
            }
            
        }];
        
        
    }




}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        NSDictionary*dic=[_dataArray objectAtIndex:alertView.tag];
        NSString*orderNo=[dic objectForKey:@"orderNo"];
        NSString*orderState=[dic objectForKey:@"orderState"];

        NSLog(@"%@",ORDER_DELETE_URL(orderNo));


        if([orderState intValue]==0){
            [requestData getData:ORDER_DELETE_URL(orderNo) complete:^(NSDictionary *dic) {
                if ([[dic objectForKey:@"flag"] intValue]==1) {

                    [self getData:@""];
                }else
                {
                    ALERT([dic objectForKey:@"info"])
                }

            }];
        }


        if([orderState intValue]==2){
            [requestData getData:ORDER_RECEIVE_URL(orderNo) complete:^(NSDictionary *dic) {
                if ([[dic objectForKey:@"flag"] intValue]==1) {

                    [self selectBtnClick:daipinglunBtn];
                    [self getData:@""];
                }else
                {
                    ALERT([dic objectForKey:@"info"])
                }
                
            }];
        }



    }else{

    }
}
-(void)jiesuanBtnClick:(UIButton*)button
{
    NSDictionary*dic=[_dataArray objectAtIndex:button.tag];

    NSString*orderNo=[dic objectForKey:@"orderNo"];
    //    NSString*realPrice=[dic objectForKey:@"realPrice"];
    NSString*shopId=[dic objectForKey:@"shopId"];
    //    NSString* shopName=[dic objectForKey:@"shopName"];
    NSString*orderState=[dic objectForKey:@"orderState"];
    int state=[orderState intValue];

    if (state==0) {
//        MISSINGVIEW
//        missing_v.tishi=@"暂未开通该项服务";
//                [self zhifubao:shopName with:shopName with:orderNo with:realPrice];
        NSDictionary*dic=[_dataArray objectAtIndex:button.tag];
        NSString*orderNo=[dic objectForKey:@"orderNo"];
        PUSH(orderDetailVC)
        vc.orderNo=orderNo;


    }
    if (state==1||state==4||state==5) {
        NSDictionary*dic=[_dataArray objectAtIndex:button.tag];
        NSString*orderNo=[dic objectForKey:@"orderNo"];
        PUSH(orderDetailVC)
        vc.orderNo=orderNo;
    }
    if (state==2) {

        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:nil message:@"你要确定收货吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = button.tag;
        [alert show];

        

    }

    if (state==3) {
        if ([shopId intValue]==0) {
            NSDictionary*dic=[_dataArray objectAtIndex:button.tag];
            NSString*orderNo=[dic objectForKey:@"orderNo"];
            PUSH(orderDetailVC)
            vc.orderNo=orderNo;
        }
        else
        {
            [requestData getData:ORDER_DETAIL_URL(orderNo) complete:^(NSDictionary *dic) {
                NSLog(@"%@",dic);
                if ([[dic objectForKey:@"flag"] intValue]==1) {
                    commentVC*vc=[[commentVC alloc]init];
                    vc.dic=dic;
                    [self.navigationController pushViewController:vc animated:YES];
                }else
                {
                    MISSINGVIEW
                    missing_v.tishi=[NSString stringWithFormat:@"%@",[dic objectForKey:@"info"]];
                }

                
            }];
            
        }

    }
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary*dic=[_dataArray objectAtIndex:indexPath.row];
    NSString*orderNo=[dic objectForKey:@"orderNo"];
    PUSH(orderDetailVC)
    vc.orderNo=orderNo;

}
-(void)selectBtnClick:(UIButton*)button
{
    UIImageView*iv=(UIImageView*)[_tableView viewWithTag:22222];
    UILabel*la=(UILabel*)[_tableView viewWithTag:222222];
    [iv removeFromSuperview];
    [la removeFromSuperview];
    if (_lastBtn==button) {

    }else
    {
        [button setTitleColor:APP_ClOUR forState:UIControlStateNormal];
        [_lastBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

    }
    _lastBtn=button;
    [self getData:@""];

}
-(void)backClick
{
    POP


}
-(void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    [self getData:@""];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
