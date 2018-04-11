//
//  jifenListVC.m
//  PsychiatricConsulting
//
//  Created by apple on 15/5/14.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "jifenListVC.h"
#import "orderDetailVC.h"
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
#import "postOnWayVC.h"
#import "commentVC.h"
@interface jifenListVC ()

@end

@implementation jifenListVC
- (void)viewDidLoad {
    [super viewDidLoad];
    TOP_VIEW(@"订单列表")

    self.navigationController.navigationBar.hidden=YES;

    NSArray*title_a=@[@"我的订单",@"历史订单"];

    for (int i=0; i<2; i++) {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(_width*0.5*i, 64, _width*0.5, 50);

        [button setTitle:[title_a objectAtIndex:i] forState:UIControlStateNormal];
        if (i==0) {

                [button setTitleColor:APP_ClOUR forState:UIControlStateNormal];

        }else
        {

                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];


        }


        if (i>0) {
            UIView*shuxian=[[UIView alloc]initWithFrame:CGRectMake(0, 10, 1, 30)];
            shuxian.backgroundColor=RGB(234, 234, 234);
            [button addSubview:shuxian];


        }        button.titleLabel.font=[UIFont boldSystemFontOfSize:15];
        button.tag=i;
        [button addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];

    }


    UIView*hengxian=[[UIView alloc]initWithFrame:CGRectMake(0, 64+49, _width, 1)];
    hengxian.backgroundColor=RGB(234, 234, 234);
    [self.view addSubview:hengxian];
//

    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+50, _width, _height-64-50) ];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces=YES;
    _tableView.separatorColor=[UIColor whiteColor];
    [self.view addSubview:_tableView];
    [self getData:@""];
    _refesh=[SDRefreshHeaderView refreshView];
    __block jifenListVC*blockSelf=self;
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

        NSString*orderStateList;
        if (_lastBtn.tag==0) {
            orderStateList=@"0";
        }
        if (_lastBtn.tag==1) {
            orderStateList=@"1";
        }
                LOADVIEW

        NSString*url;
        int count;
        if ([more isEqualToString:@"more"]) {
            static int i=0;
            i++;
            count=12*i;
        }else
        {
            count=12;
        }
        //NSLog(@"%d===",count);
        url=[NSString stringWithFormat:@"%@&size=%d",ORDER_LIST_SORT_URL(USERID, orderStateList),count];
       // NSLog(@"%@",url);
        [requestData getData:url complete:^(NSDictionary *dic) {
            [_refesh endRefreshing];
            [_refeshDown endRefreshing];
            LOADREMOVE

            NSLog(@"%@",dic);

            _dataArray=[dic objectForKey:@"data"];

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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary*dic=[_dataArray objectAtIndex:indexPath.row];
    NSArray*proListA=[dic objectForKey:@"proList"];
    return  proListA.count*(_width*0.2+30)+40+40+50+20;

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    tableView.separatorColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    NSArray*title_a=@[@"未付款",@"已付款",@"已发货",@"已完成",@"已评论",@"已关闭"];

    NSDictionary*dic=[_dataArray objectAtIndex:indexPath.row];
    NSArray*proListA=[dic objectForKey:@"proList"];

    NSString*count=[dic objectForKey:@"count"];
    NSString*orderState=[dic objectForKey:@"orderState"];

    NSString*realPrice=[dic objectForKey:@"realPrice"];
    NSString*shopId=[dic objectForKey:@"shopId"];

    id shopLogo=[dic objectForKey:@"shopLogo"];
    if (shopLogo==[NSNull null]||shopLogo==nil) {
        shopLogo=@"";
    }else
    {

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



    float  hh=proListA.count*(_width*0.2+30)+40+40+50;

    UIView*bigView=[[UIView alloc]initWithFrame:CGRectMake(_width*0.02, 10, _width*0.96, hh)];
    bigView.layer.cornerRadius=5;
    bigView.layer.borderColor=RGB(234, 234,234).CGColor;
    bigView.layer.borderWidth=1;
    [cell.contentView addSubview:bigView];

#pragma mark店铺信息
    UIImageView*shopLogo_V=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.05, 10, 20, 20)];
    [shopLogo_V sd_setImageWithURL:[NSURL URLWithString:shopLogo] placeholderImage:[UIImage imageNamed:@"morentu.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

    }];
    [bigView addSubview:shopLogo_V];
    if ([shopId intValue]==0) {
        shopLogo_V.hidden=YES;
    }

    UIView*kuang=[[UIView alloc]initWithFrame:CGRectMake(_width*0.05-2, 10-2, 24, 24)];
    kuang.layer.borderColor=RGB(234, 234, 234).CGColor;
    kuang.layer.borderWidth=1;
    [bigView addSubview:kuang];


    UILabel*name_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.07+20, 0, _width*0.63-20, 40)];
    name_L.text=[NSString stringWithFormat:@"%@",shopName];
    name_L.numberOfLines=0;
    name_L.textAlignment=NSTextAlignmentLeft;
    name_L.textColor=[UIColor darkGrayColor];
    name_L.font=[UIFont boldSystemFontOfSize:14];
    [bigView addSubview:name_L];

    UILabel*state_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.7, 0, _width*0.23, 40)];
    state_L.text=[title_a objectAtIndex:[orderState intValue]];
    state_L.numberOfLines=0;
    state_L.textAlignment=NSTextAlignmentRight;
    state_L.textColor=APP_ClOUR;
    state_L.font=[UIFont boldSystemFontOfSize:14];
    [bigView addSubview:state_L];


    UIView*hengxian1=[[UIView alloc]initWithFrame:CGRectMake(0, 40, _width*0.96, 1)];
    hengxian1.backgroundColor=RGB(234, 234, 234);
    [bigView addSubview:hengxian1];

#pragma mark 商品信息
    for (int i=0; i<proListA.count; i++) {
        NSDictionary*proDic=[proListA objectAtIndex:i];
        NSString*number=[proDic objectForKey:@"number"];
        //NSLog(@"%@",proDic);
        NSString*productImage=[proDic objectForKey:@"productImage"];
        NSString*productName=[proDic objectForKey:@"productName"];
        NSString*productPrice=[proDic objectForKey:@"productPrice"];

        UIView*product_view=[[UIView alloc]initWithFrame:CGRectMake(0, 40+(_width*0.2+30)*i, _width*0.96, _width*0.2+30)];
        // product_view.backgroundColor=[UIColor grayColor];


        UIImageView*pro_iv=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.05, 15, _width*0.2, _width*0.2)];
        [pro_iv sd_setImageWithURL:[NSURL URLWithString:productImage] placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

        }];
        [product_view addSubview:pro_iv];


        UIView*kuang=[[UIView alloc]initWithFrame:CGRectMake(_width*0.05-2, 15-2, _width*0.2+4, _width*0.2+4)];
        kuang.backgroundColor=[UIColor clearColor];
        kuang.layer.borderWidth=1;
        kuang.layer.borderColor=RGB(234, 234, 234).CGColor;
        [product_view addSubview:kuang];

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
        p_name_L.font=[UIFont boldSystemFontOfSize:15];
        [product_view addSubview:p_name_L];

        UIView*hengxian1=[[UIView alloc]initWithFrame:CGRectMake(0, _width*0.2+30-1, _width*0.96, 1)];
        hengxian1.backgroundColor=RGB(234, 234, 234);
        [product_view addSubview:hengxian1];

        [bigView addSubview:product_view];
    }
#pragma mark 商品信息
    UILabel*product_L=[[UILabel alloc]initWithFrame:CGRectMake(0, hh-90, _width*0.92,40)];
    product_L.text=[NSString stringWithFormat:@"共计%@件  实付：%.2f",count,[realPrice doubleValue]];
    product_L.textAlignment=NSTextAlignmentRight;
    product_L.textColor=[UIColor darkGrayColor];
    product_L.font=[UIFont boldSystemFontOfSize:13];
    [bigView addSubview:product_L];


    UIView*hengxian2=[[UIView alloc]initWithFrame:CGRectMake(0, hh-50, _width*0.96, 1)];
    hengxian2.backgroundColor=RGB(234, 234, 234);
    [bigView addSubview:hengxian2];

    UIButton*jiesuanBtn=[UIButton  buttonWithType:UIButtonTypeCustom];
    jiesuanBtn.frame=CGRectMake(_width*0.69, hh-40, _width*0.25, 30);
    jiesuanBtn.backgroundColor=APP_ClOUR;
    [jiesuanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    jiesuanBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    jiesuanBtn.layer.cornerRadius=5;
    jiesuanBtn.tag=indexPath.row;
    [jiesuanBtn addTarget:self action:@selector(jiesuanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bigView addSubview:jiesuanBtn];

    UIButton*askBtn=[UIButton  buttonWithType:UIButtonTypeCustom];
    askBtn.frame=CGRectMake(_width*0.4, hh-40, _width*0.25, 30);
    askBtn.layer.borderColor=APP_ClOUR.CGColor;
    askBtn.layer.borderWidth=1;
    askBtn.layer.cornerRadius=5;
    askBtn.tag=indexPath.row;

    [askBtn addTarget:self action:@selector(askBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [askBtn setTitleColor:APP_ClOUR forState:UIControlStateNormal];
    askBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [bigView addSubview:askBtn];

    int state=[orderState intValue];

    if (state==0) {
        [jiesuanBtn setTitle:@"结算" forState:UIControlStateNormal];
        [askBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    }
    if (state==1||state==4||state==5) {
        [jiesuanBtn setTitle:@"查看订单" forState:UIControlStateNormal];
        askBtn.hidden=YES;

    }
    if (state==2) {
        [jiesuanBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        [askBtn setTitle:@"查看物流" forState:UIControlStateNormal];
       // askBtn.hidden=YES;
    }
    if (state==3) {
        [jiesuanBtn setTitle:@"去评论" forState:UIControlStateNormal];
        askBtn.hidden=YES;
        if ([shopId intValue]==0) {
            [jiesuanBtn setTitle:@"查看订单" forState:UIControlStateNormal];


        }

    }


    return cell;
}
-(void)askBtnClick:(UIButton*)button
{

    NSDictionary*dic=[_dataArray objectAtIndex:button.tag];
    NSString*orderNo=[dic objectForKey:@"orderNo"];

    NSString*orderState=[dic objectForKey:@"orderState"];
    int state=[orderState intValue];
    if (state==0) {
        NSDictionary*dic=[_dataArray objectAtIndex:button.tag];
        NSString*orderState=[dic objectForKey:@"orderState"];
        if ([orderState intValue]==0) {
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:nil message:@"是否确定删除？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag=button.tag;
            [alert show];
        }
    }
    if (state==2) {
        [requestData getData:ASK_POST_URL(orderNo) complete:^(NSDictionary *dic) {
            NSLog(@"--%@",dic);

          postOnWayVC*vc=[[postOnWayVC alloc]init];
          vc.dic=dic;
          [self.navigationController pushViewController:vc animated:YES];

        }];
    }



}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        NSDictionary*dic=[_dataArray objectAtIndex:alertView.tag];
        NSString*orderNo=[dic objectForKey:@"orderNo"];
        [requestData getData:ORDER_DELETE_URL(orderNo) complete:^(NSDictionary *dic) {
            if ([[dic objectForKey:@"flag"] intValue]==1) {
                [self getData:@""];

            }else
            {

            }
            MISSINGVIEW
            missing_v.tishi=[NSString stringWithFormat:@"%@",[dic objectForKey:@"info"]];

        }];
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
        MISSINGVIEW
        missing_v.tishi=@"暂未开通该项服务";
//        [self zhifubao:shopName with:shopName with:orderNo with:realPrice];
    }
    if (state==1||state==3||state==5) {
        NSDictionary*dic=[_dataArray objectAtIndex:button.tag];
        NSString*orderNo=[dic objectForKey:@"orderNo"];
        PUSH(orderDetailVC)
        vc.orderNo=orderNo;
    }
    if (state==2) {
//        [requestData getData:ORDER_RECEIVE_URL(orderNo) complete:^(NSDictionary *dic) {
//            MISSINGVIEW
//            missing_v.tishi=[dic objectForKey:@"info"];
//            [self getData:@""];
//
//        }];
    }

    if (state==3) {
        if ([shopId intValue]==0) {
            NSDictionary*dic=[_dataArray objectAtIndex:button.tag];
            NSString*orderNo=[dic objectForKey:@"orderNo"];
            PUSH(orderDetailVC)
            vc.orderNo=orderNo;
        }else
        {
            [requestData getData:ORDER_DETAIL_URL(orderNo) complete:^(NSDictionary *dic) {
                NSLog(@"%@",dic);
                if ([[dic objectForKey:@"flag"] intValue]==1) {
                 commentVC*vc=[[commentVC alloc]init];
                 vc.dic=dic;
                 [self.navigationController pushViewController:vc animated:YES];
                }else
                {

                }
                MISSINGVIEW
                missing_v.tishi=[NSString stringWithFormat:@"%@",[dic objectForKey:@"info"]];

            }];

        }

    }

}
-(void)zhifubao:(NSString*)productName with:(NSString*)desp  with:(NSString *)oederNo  with:(NSString*)price
{

    NSString *partner = @"2088911385877333";
    NSString *seller = @"1750825779@qq.com";
    NSString *privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAJ+7C/4CxQXb6/QmoRAkIeDtQd0rBKf74gKECjex4fOb5F6YjDswBE0pFMUhboLbhjNIVTE9DhtKrL2xhhk59LgBvzMcYqTz2Q4xctFj+wwkqPYJpAheFThN/uPzTT0IUoDFhUdMugq6E0wm7i4NP/IeRI4YtSy5Li08M75AFy3vAgMBAAECgYAllmCGD6TJci0eMRDpuXb3dR1wrDTWSuGucd/tp0BikSa2U/N74hrBBY/Lq8hTptD3tGfHxHRTW8k2glXqDcdWPnTsAoLOvBNgkyL0GGQGoo64it85QH043vldeYM9xZmEZtsgGw2EFCk73EyA95e8dP6+Iuyi/2Ha/KQOvD/XMQJBAM0ALNz7FMqBy7bMaa+wHGglmpmXRxnZtVzsuvkctcAeN3Qs3ZfThDdiBsHaeR3YoPFVMTemAXGjO28+SLDjbLMCQQDHd8VaN03ICCKIZwHTkIFWxJNaJGQMLyOGCErb917/T3GEFO+YuHWND+OH7iMnw61CISScn2Ni0YUqCEsoo8/VAkBw/Ky9ayGNb7Zw3P9PFtjBSiCIkMleZRDB07RFwt4lskHMJUJJAQp5X+zrgVeJ7LDf8p1612MqV9ZVPNXhsKdjAkBCFqrq0zwQNLHMY+S1BkH0T7lKupfzeYLZm9HBw9pT2SyRSKaCAUvhawxGM16uhCTZrkWFJ0I0sZrfbFQKqQvpAkEAld9drXgLvP3EDuDY1osBrkYmjWs2c1xeuGOpqtlsAJDCAXU05naR3KA8Tf5RHVPFUC3d675JGHNmLjG9DizZig==";
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = oederNo; //订单ID（由商家自行制定）
    order.productName =productName; //商品标题
    order.productDescription = desp; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",[price doubleValue]]; //商品价格
    //回调URL
    order.notifyURL=[NSString stringWithFormat:@"%@/order/notify.action",BASE_URL];

    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";


    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdkdemo";

    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);

    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];


    NSLog(@"--%@",signedString);

    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];


        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            if ([[resultDic objectForKey:@"resultStatus"] intValue]==4000) {
                MISSINGVIEW
                missing_v.tishi=@"支付宝支付失败";

            }
        }];
        
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
        [_lastBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
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
