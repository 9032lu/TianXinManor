//
//  sureOrderVC.m
//  ShengMengShangmao
//
//  Created by apple on 15-3-31.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "sureOrderVC.h"
#import "addAdressVC.h"
#import "myAdressVC.h"
#import "remarkVC.h"
#import "orderDetailVC.h"
#import "chargeListVC.h"
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
#import "orderlistVC.h"
@interface sureOrderVC ()

@end

@implementation sureOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    TOP_VIEW(@"确认订单")
    NSLog(@"??%@",self.InfoArray);
    _currentPayMent=@"1";

    self.navigationController.navigationBar.hidden=YES;

    [self getAddressData];


    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64) ];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces=YES;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];

    NSArray*proA=[self.InfoArray objectForKey:@"good"];
    _totalprice=0;
    _countArray=[[NSMutableArray alloc]init];
    for (int i=0; i<proA.count; i++) {
        NSDictionary*prodic=[proA objectAtIndex:i];
        double ratePric=0.0;
        if ([self.whoPush isEqualToString:@"jifen"]) {
            ratePric=[[prodic objectForKey:@"userScore"] integerValue];

        }else{
            ratePric=[[prodic objectForKey:@"ratePrice"] doubleValue];

        }
        double  count=[[prodic objectForKey:@"count"] doubleValue];

        NSString*productCount=[prodic objectForKey:@"count"];
        [_countArray addObject:productCount];

        _totalprice=_totalprice+ratePric*count;

    }

    // NSLog(@"========%f",_totalprice);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray*proA=[self.InfoArray objectForKey:@"good"];
     NSDictionary*shopDic=[self.InfoArray objectForKey:@"shop"];
    if (indexPath.row==1) {
         return  proA.count*(_width*0.2+30)+50+20;
    }else  if(indexPath.row==2||indexPath.row==3)
    {
         if ([[shopDic objectForKey:@"shopId"] intValue]==0) {
             return 1;
         }else
         {
             return 60;

         }

    }else
    {
        if (indexPath.row==0) {
            if ([[shopDic objectForKey:@"shopId"] intValue]==0) {
                return 110;
            }else
            {
                return 110;
            }
        }else
        {
            return 60;
        }

    }

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    tableView.separatorColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSArray*proA=[self.InfoArray objectForKey:@"good"];
    NSDictionary*shopDic=[self.InfoArray objectForKey:@"shop"];

    float  hh;
    if (indexPath.row==1) {
        hh= proA.count*(_width*0.2+30)+50;
    }else
    {if (indexPath.row==0) {
        hh=100;

    }else
        hh = 50;
    }

    UIView*bigView=[[UIView alloc]initWithFrame:CGRectMake(_width*0.02, 5, _width*0.96, hh)];
    bigView.layer.cornerRadius=5;
    bigView.layer.borderColor=RGB(234, 234,234).CGColor;
    bigView.layer.borderWidth=1;
    [cell.contentView addSubview:bigView];


    if (indexPath.row==0) {
//        if ([[shopDic objectForKey:@"shopId"] intValue]==0) {
//            cell.hidden=YES;
//
//        }else
//        {
            if ([_currentAddress objectForKey:@"address"]==nil) {
                cell.textLabel.text=@"还没有收货地址，去添加..";
                cell.textLabel.textAlignment=NSTextAlignmentCenter;
                cell.textLabel.font=[UIFont systemFontOfSize:14];

            }else
            {

                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

                UILabel*_linkName_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.1, 5, _width*0.4, 25)];
                _linkName_L.text=[NSString stringWithFormat:@"收货人：%@",[_currentAddress objectForKey:@"linkName"]];
                _linkName_L.font=[UIFont systemFontOfSize:14];
                [cell.contentView addSubview:_linkName_L];

                UILabel*_phone_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.5, 5, _width*0.47, 25)];
                _phone_L.text=[_currentAddress objectForKey:@"phone"];
                _phone_L.textAlignment=NSTextAlignmentCenter;
                _phone_L.font=[UIFont systemFontOfSize:14];
                [cell.contentView addSubview:_phone_L];

                UILabel*_address_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.1, 30, _width*0.8,50)];
                _address_L.text=[NSString stringWithFormat:@"收货地址：%@",[_currentAddress objectForKey:@"address"]];
                _address_L.numberOfLines=2;
                _address_L.textAlignment=NSTextAlignmentLeft;
                _address_L.font=[UIFont systemFontOfSize:14];
                [cell.contentView addSubview:_address_L];

                UILabel*lab=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.11, 75, _width*0.92,30)];
                lab.text=@"（收货不便时可选择代收服务）";
                lab.numberOfLines=1;
                lab.textColor = [UIColor darkGrayColor];
                lab.textAlignment=NSTextAlignmentLeft;
                lab.font=[UIFont systemFontOfSize:12];
                [cell.contentView addSubview:lab];

            }
//        }
    }
#pragma mark店铺信息

    if (indexPath.row==1) {
//        UIImageView*shopLogo=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.05, 10, 20, 20)];
//        id slo=[shopDic objectForKey:@"shopLogo"];
//        if (slo==[NSNull null]) {
//            slo=nil;
//        }
//        [shopLogo sd_setImageWithURL:[NSURL URLWithString:slo] placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//
//        }];
//        [bigView addSubview:shopLogo];
//
//
//
//        UILabel*name_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.08+20, 0, _width*0.85, 40)];
//
//        name_L.numberOfLines=0;
//        name_L.textAlignment=NSTextAlignmentLeft;
//        name_L.textColor=[UIColor darkGrayColor];
//        name_L.font=[UIFont boldSystemFontOfSize:14];
//        [bigView addSubview:name_L];
//        if ([[shopDic objectForKey:@"shopId"] intValue]==0) {
//            shopLogo.hidden=YES;
//             name_L.text=@"积分商品";
//        }else
//        {
//             name_L.text=[shopDic objectForKey:@"shopName"];
//        }
//
////        UILabel*state_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.6, 0, _width*0.33, 40)];
////        state_L.text=@"卖家已发货";
////        state_L.numberOfLines=0;
////        state_L.textAlignment=NSTextAlignmentRight;
////        state_L.textColor=RGB(119, 82, 32);
////        state_L.font=[UIFont boldSystemFontOfSize:14];
////        [bigView addSubview:state_L];
//
//
//        UIView*hengxian1=[[UIView alloc]initWithFrame:CGRectMake(0, 40, _width*0.96, 1)];
//        hengxian1.backgroundColor=RGB(234, 234, 234);
//        [bigView addSubview:hengxian1];

#pragma mark 商品信息
         NSArray*proA=[self.InfoArray objectForKey:@"good"];


        for (int i=0; i<proA.count; i++) {
            
            NSDictionary*prodic=[proA objectAtIndex:i];


            UIView*product_view=[[UIView alloc]initWithFrame:CGRectMake(0, (_width*0.2+30)*i, _width*0.96, _width*0.2+30)];
            // product_view.backgroundColor=[UIColor grayColor];


            UIImageView*pro_iv=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.05, 15, _width*0.2, _width*0.2)];
            [pro_iv sd_setImageWithURL:[NSURL URLWithString:[prodic objectForKey:@"imagePath"]] placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                float  W=(_width*0.2)*image.size.width/image.size.height;

                pro_iv.frame = CGRectMake((_width*0.2-W)/2, 15, W, _width*0.2);


            }];
            [product_view addSubview:pro_iv];

            UILabel*price_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.63, 15, _width*0.3,_width*0.1)];
            if ([self.whoPush isEqualToString:@"jifen"]) {
                price_L.text=[NSString stringWithFormat:@"¥ %ld积分",(long)[[prodic objectForKey:@"userScore"] integerValue]];

            }else{
                price_L.text=[NSString stringWithFormat:@"¥ %.2f",[[prodic objectForKey:@"ratePrice"] doubleValue]];

            }
            price_L.textAlignment=NSTextAlignmentRight;
            price_L.textColor=[UIColor orangeColor];
            price_L.font=[UIFont systemFontOfSize:12];
            [product_view addSubview:price_L];


//            UILabel*number_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.76, 15+_width*0.075, _width*0.18,_width*0.075)];
//            number_L.text=@"x 8";
//            number_L.textAlignment=NSTextAlignmentRight;
//            number_L.textColor=[UIColor darkGrayColor];
//            number_L.font=[UIFont boldSystemFontOfSize:12];
//            [product_view addSubview:number_L];


            UILabel*p_name_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.29, 15, _width*0.47,_width*0.1)];
            p_name_L.text=[prodic objectForKey:@"productName"];
            p_name_L.numberOfLines=1;
            p_name_L.textAlignment=NSTextAlignmentLeft;
            p_name_L.textColor=[UIColor darkGrayColor];
            p_name_L.font=[UIFont boldSystemFontOfSize:14];
            [product_view addSubview:p_name_L];

            UIView*hengxian1=[[UIView alloc]initWithFrame:CGRectMake(0, _width*0.2+30-1, _width*0.96, 1)];
            hengxian1.backgroundColor=RGB(234, 234, 234);
            [product_view addSubview:hengxian1];

            [bigView addSubview:product_view];

            UIView*plusAndMinView=[[UIView alloc]initWithFrame:CGRectMake(_width*0.32, 15+_width*0.1, _width*0.3, 30)];
            plusAndMinView.layer.cornerRadius=5;
            plusAndMinView.layer.borderColor=[UIColor darkGrayColor].CGColor;
            plusAndMinView.layer.borderWidth=1;
            plusAndMinView.tag=i+50;
            [product_view addSubview:plusAndMinView];
            for (int j=0; j<2; j++) {
                UIView*shuxian=[[UIView alloc]initWithFrame:CGRectMake(_width*0.1*(j+1), 0, 1, 30)];
                shuxian.backgroundColor=[UIColor darkGrayColor];
                [plusAndMinView addSubview:shuxian];
            }

            for (int k=0; k<3; k++) {
                UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
                button.frame=CGRectMake(_width*0.1*k,0 , _width*0.1, 30);
                button.tag=k+20;
                [button addTarget:self action:@selector(PlusAndMinBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                if (k==0) {
                    [button setTitle:@"-" forState:UIControlStateNormal];
                }
                if (k==1) {
                    [button setTitle:[NSString stringWithFormat:@"%@",[prodic objectForKey:@"count"]] forState:UIControlStateNormal];
                }
                if (k==2) {
                    [button setTitle:@"+" forState:UIControlStateNormal];
                }
                button.titleLabel.font=[UIFont systemFontOfSize:15];
                [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                [plusAndMinView addSubview:button];
            }

        }
#pragma mark 商品信息
        _totalLabel=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, hh-50, _width*0.92,50)];
        if ([self.whoPush isEqualToString:@"jifen"]) {
            _totalLabel.text=[NSString stringWithFormat:@"共计：%g积分",_totalprice];

        }else{
            _totalLabel.text=[NSString stringWithFormat:@"共计：%.2f",_totalprice];

        }
        _totalLabel.textAlignment=NSTextAlignmentLeft;
        _totalLabel.textColor=[UIColor darkGrayColor];
        _totalLabel.font=[UIFont boldSystemFontOfSize:14];
        [bigView addSubview:_totalLabel];

//
//        UIView*hengxian2=[[UIView alloc]initWithFrame:CGRectMake(0, hh-50, _width*0.96, 1)];
//        hengxian2.backgroundColor=RGB(234, 234, 234);
//        [bigView addSubview:hengxian2];
    }

    if (indexPath.row==2) {

        cell.textLabel.text=@"支付宝支付";
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        if ([[shopDic objectForKey:@"shopId"] intValue]==0) {
            cell.hidden=YES;
            //cell.textLabel.text=@"积分兑换";
        }
    }
    if (indexPath.row==3) {
        cell.textLabel.text=@"获取优惠劵";

        if (_currentCoup!=nil) {
            cell.textLabel.text=[NSString stringWithFormat:@"%@",[_currentCoup objectForKey:@"couponsTitle"]];
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        if ([[shopDic objectForKey:@"shopId"] intValue]==0) {
            cell.hidden=YES;
        }
    }
    if (indexPath.row==4) {
        NSString*remark=_currentRemark;
        if (remark.length==0||remark==nil) {
           cell.textLabel.text=@"备注";
        }else
        {
            cell.textLabel.text=[NSString stringWithFormat:@"备注：%@",remark];
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font=[UIFont systemFontOfSize:14];

    }
    if (indexPath.row==5) {
//        if ([[shopDic objectForKey:@"shopId"] intValue]==0) {
            cell.textLabel.text=@"确定";
            cell.textLabel.textColor = [UIColor whiteColor];

//        }else
//        {
//            cell.textLabel.text=@"去付款";
//            cell.textLabel.textColor = [UIColor whiteColor];
//        }
        bigView.backgroundColor=APP_ClOUR;
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        cell.textLabel.font=[UIFont systemFontOfSize:15];
    }
    return cell;
}
-(void)PlusAndMinBtnClick:(UIButton*)button
{
    if (button.tag==21) {

    }else
    {

        UIView*view=[button superview];
        double ratePrice = 0.0;
        NSArray*proA=[self.InfoArray objectForKey:@"good"];
        NSDictionary*prodic=[proA objectAtIndex:view.tag-50];
        if ([self.whoPush isEqualToString:@"jifen"]) {
            ratePrice=[[prodic objectForKey:@"userScore"] doubleValue];

        }else{
            ratePrice=[[prodic objectForKey:@"ratePrice"] doubleValue];

        }
        //double count=[[prodic objectForKey:@"count"] doubleValue];


        UIButton*numBtn=(UIButton*)[view viewWithTag:21];
//        NSLog(@"%@",[numBtn class]);

        NSString*minS=[NSString stringWithFormat:@"%d",[numBtn.titleLabel.text intValue]-1];
        NSString*plustr=[NSString stringWithFormat:@"%d",[numBtn.titleLabel.text intValue]+1];
        if (button.tag==20) {
            if ([numBtn.titleLabel.text intValue]==1) {

                return;
            }
            _totalprice=_totalprice-ratePrice*1;
            [numBtn setTitle:minS forState:UIControlStateNormal];

            [_countArray replaceObjectAtIndex:view.tag-50 withObject:minS];
        }else
        {
            //int qulity=[[[_dataDic objectForKey:@"product"] objectForKey:@"productQuantity"] intValue];
//            if ([plustr intValue]>qulity) {
//                ALERT(@"库存不足")
//                return;
//            }
             _totalprice=_totalprice+ratePrice*1;
            [numBtn setTitle:plustr forState:UIControlStateNormal];
            [_countArray replaceObjectAtIndex:view.tag-50 withObject:plustr];

        }
//         NSLog(@"========%@",_countArray);

        if ([self.whoPush isEqualToString:@"jifen"]) {
            _totalLabel.text=[NSString stringWithFormat:@"共计：%g积分",_totalprice];

        }else
         _totalLabel.text=[NSString stringWithFormat:@"共计：%.2f",_totalprice];
        //_count=numBtn.titleLabel.text;


    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        PUSH(myAdressVC)
        vc.whoPush=@"dingdan";

    }
    if (indexPath.row==2) {
        NSDictionary*shopDic=[self.InfoArray objectForKey:@"shop"];
        NSString*shopId=[shopDic objectForKey:@"shopId"];
        _paymentA =[[NSMutableArray alloc]initWithObjects:@{@"payId":@"1",@"payName":@"支付宝支付"},@{@"payId":@"2",@"payName":@"微信支付"}, nil];

        [requestData getData:PAY_TYPE_URL(shopId) complete:^(NSDictionary *dic) {
            NSLog(@"%@",PAY_TYPE_URL(shopId));
            NSArray *arrrr=[dic objectForKey:@"data"];

            for (int i =0; i <arrrr.count; i ++) {
                [_paymentA addObject:arrrr[i]];
            }
            NSLog(@"=======%@",_paymentA);

            if (_paymentA.count!=0) {
                UIActionSheet*actionSheet=[[UIActionSheet alloc]initWithTitle:@"支付方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil, nil];

                for (int i=0; i<_paymentA.count; i++) {

                    NSString*payName=[[_paymentA objectAtIndex:i] objectForKey:@"payName"];


                    [actionSheet addButtonWithTitle:payName];
                }
                
                [actionSheet showInView:self.view];
            }


        }];

//
    }

    if (indexPath.row==4) {
        PUSH(remarkVC)
    }
    if (indexPath.row==5 ) {
//        if (_currentAddress==nil) {
//            ALERT(@"请输入收货地址")
//            return;
//        }
        [self submit];
    }
    if (indexPath.row==3) {
        NSDictionary*shopDic=[self.InfoArray objectForKey:@"shop"];
        NSString*shopid=[shopDic objectForKey:@"shopId"];
        PUSH(chargeListVC)
        vc.whoPush=@"order";
        vc.shopId=shopid;
        vc.totalPrice=[NSString stringWithFormat:@"%f",_totalprice];

    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{


    if (buttonIndex==0) {

    }else
    {
        NSIndexPath*path=[NSIndexPath indexPathForRow:2 inSection:0];
        UITableViewCell*cell=[_tableView cellForRowAtIndexPath:path];
        cell.textLabel.text=[[_paymentA objectAtIndex:buttonIndex-1] objectForKey:@"payName"];

        _currentPayMent=[[_paymentA objectAtIndex:buttonIndex-1] objectForKey:@"payId"];

    }



}
-(void)submit
{

    NSString*linkname=[_currentAddress objectForKey:@"linkName"];
    NSString*phone=[_currentAddress objectForKey:@"phone"];
    NSString*address=[_currentAddress objectForKey:@"address"];
   // if ([self.whoPush isEqualToString:@"jifen"]) {
        if (_currentAddress==nil||linkname.length==0) {
            MISSINGVIEW
            missing_v.tishi=@"请选择收货地址";
            return;
        }
//    }//

    AFHTTPRequestOperationManager*manger=[AFHTTPRequestOperationManager manager];

    NSString*str=[NSString stringWithFormat:@"%@/order/addOrder.action?" ,BASE_URL];



    NSString*shopId=[[self.InfoArray objectForKey:@"shop"] objectForKey:@"shopId"];


    NSMutableArray*goodArray=[NSMutableArray arrayWithArray:[self.InfoArray objectForKey:@"good"]];





    NSMutableArray*Arrays=[[NSMutableArray alloc]init];
    for (int i=0; i<goodArray.count; i++) {
        NSDictionary* dic2=[goodArray objectAtIndex:i];
        id skuid=[dic2 objectForKey:@"skuId"];
        if (skuid==[NSNull null]||skuid==nil) {
            skuid=@"0";
        }else
        {
            skuid=[dic2 objectForKey:@"skuId"];
        }
        NSString*productId=[dic2 objectForKey:@"productId"];
        NSString*ratePrice=[dic2 objectForKey:@"ratePrice"];


    //    NSIndexPath*indePath=[NSIndexPath indexPathForRow:0 inSection:1];
        //UITableViewCell*cell=(UITableViewCell*)[_tableView cellForRowAtIndexPath:indePath];

        //NSLog(@"----%@",count);
        NSDictionary*dic1=@{@"productId":productId,@"skuId":skuid,@"count":[_countArray objectAtIndex:i],@"productPrice":ratePrice};


       [Arrays addObject:dic1];

    }



    NSMutableDictionary*dic=[[NSMutableDictionary alloc]init];
    [dic setObject:USERID forKey:@"userId"];
    if (linkname==nil) {
        [dic setObject:@"" forKey:@"orderName"];
    }else
    {
        [dic setObject:linkname forKey:@"orderName"];
    }
    if (phone==nil) {
        [dic setObject:@"" forKey:@"orderTel"];
    }else
    {
        [dic setObject:phone forKey:@"orderTel"];
    }
    if (address==nil) {
        [dic setObject:@"" forKey:@"orderAddress"];
    }else
    {
        [dic setObject:address forKey:@"orderAddress"];
    }



    [dic setObject:shopId forKey:@"shopId"];
    if (_currentRemark==nil) {
        _currentRemark=@"";
    }
    [dic setObject:_currentRemark forKey:@"remark"];
    [dic setObject:Arrays forKey:@"goods"];


    if ([shopId intValue]==0) {
        [dic setObject:@"1" forKey:@"isExchange"];
        if ([_currentCoup objectForKey:@"isUseCoupons"]==0) {
            [dic setObject:@"0" forKey:@"couponsId"];
            [dic setObject:@"0" forKey:@"isUseCoupons"];
            [dic setObject:@"" forKey:@"couponsCode"];
            [dic setObject:@"0.00" forKey:@"couponsMoney"];
            [dic setObject:@"0" forKey:@"orderPayment"];
        }else
        {
            [dic setObject:@"0" forKey:@"couponsId"];
            [dic setObject:@"1" forKey:@"isUseCoupons"];
            [dic setObject:[_currentCoup objectForKey:@"couponsCode"] forKey:@"couponsCode"];
            [dic setObject:[_currentCoup objectForKey:@"couponsMoney"] forKey:@"couponsMoney"];
            [dic setObject:@"0" forKey:@"orderPayment"];
        }
    }else
    {
        [dic setObject:@"0" forKey:@"isExchange"];
        if ([_currentCoup objectForKey:@"couponsId"]==nil) {
            [dic setObject:@"0" forKey:@"couponsId"];
            [dic setObject:@"0" forKey:@"isUseCoupons"];
            [dic setObject:@"" forKey:@"couponsCode"];
            [dic setObject:@"0.00" forKey:@"couponsMoney"];
            [dic setObject:_currentPayMent forKey:@"orderPayment"];

        }else
        {
            [dic setObject:@"1" forKey:@"isUseCoupons"];

            [dic setObject:[_currentCoup objectForKey:@"denomination"] forKey:@"couponsMoney"];
            [dic setObject:[_currentCoup objectForKey:@"couponsId"] forKey:@"couponsId"];
            [dic setObject:_currentPayMent forKey:@"orderPayment"];

        }

    }


    NSDictionary*postDic=@{@"data":[self DataTOjsonString:dic],@"paySource":@"ios"};


    manger.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];

//
//
    NSLog(@"%@ *********  %@",str,postDic);
//
    [manger POST:str parameters:postDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"--------------%@",responseObject);
        if ([[responseObject objectForKey:@"flag"] intValue]==1) {

//            if ([shopId intValue]==0) {
                PUSH(orderDetailVC)
                vc.orderNo=[responseObject objectForKey:@"orderNo"];

                if ([_currentCoup objectForKey:@"couponsId"]==nil) {
                }else
                {
                    _totalprice=_totalprice-[[_currentCoup objectForKey:@"denomination"] doubleValue];

                }
//            }else
//            {
//
//                PUSH(orderlistVC)
//#pragma mark支付
//                NSArray *dicc=[self.InfoArray objectForKey:@"good"];
//                //
//                NSLog(@"%@-",dicc);
//
//                NSString*orderNo=[responseObject objectForKey:@"orderNo"];
//                NSString*realPrice=[NSString stringWithFormat:@"%f",_totalprice];
//                NSString* shopName=[dicc[0] objectForKey:@"productName"];
//                //           NSString*orderState=[_dataDic objectForKey:@"orderState"];
//                NSLog(@"%@--%@--%@",orderNo,realPrice,shopName);
//
//
////                MISSINGVIEW
////                missing_v.tishi=@"暂未开通该项服务";
//                NSLog(@"----%@==%@==%@",shopName,shopName,orderNo);
//                if ([[dic objectForKey:@"orderPayment"] integerValue]==1) {
//                    [self zhifubao:shopName with:shopName with:orderNo with:realPrice];
//                }else
//                if ([[dic objectForKey:@"orderPayment"] integerValue]==2) {
//
////                    MISSINGVIEW
////                    missing_v.tishi=@"微信支付暂未开通";
//                    [self WeiXinPayWithshopName:shopName OrderNo:orderNo RealPrice:realPrice];
//
//                }


//            }

        }else
        {
            //ALERT([responseObject objectForKey:@"info"])
            MISSINGVIEW
            missing_v.tishi=[responseObject objectForKey:@"info"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"-----%@",error);
    }];

}
//支付宝支付
-(void)zhifubao:(NSString*)productName with:(NSString*)desp  with:(NSString *)oederNo  with:(NSString*)price
{
    NSString *partner = @"2088021639942277";
    NSString *seller = @"tianxin201508@sina.com";
    NSString *privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAK0JZfIKkVkHXChPdgoNME1sTDAAax5xL86Fm7DOaOKD/kknsM4ptOK2VTyiECxVFZD2HoMiSoHM222ReULxUu68wxPF8mCHs0kEPAmHppQlntcL8LlPeBNrZaWzZIxDF5Zs3RViC11kRF1GBfjGJgjSMS5Dz9RR+dIvUCq1Pr8LAgMBAAECgYBjhT1CCXvxRX9mm9UbENzQGtJy5Tq2xoilckjKVt0SMrJE5vQUjv4/SnkZp2g/5yvBNRz1dPp/TxCBIyMoMl3siIVCtWu5DqPYsu0TrHzvH6wuYVjm5eym+72MAoJVGMAPWwLCAK23urgLmwIHTmg/g7SS8IQiH619c+U6XJaHuQJBAON14EToZsPGN54y1jMCjer1iaU+LvkTbC6nQjQOvKvXKkBjqfQOatwjrs2fc4Q+56LUU4F1IeeaYTGRYc+Eef8CQQDCv2i4Ix9Ciaz9z9VpNymhVhw9Oa4hh5A0M/K2vxeHMC0SSp4soiH0jxJiAP7yyE114yLI4XCuCNNmhe35fgL1AkAG4QO9UcH53b7E3Ai6VjNwjahyBOVqxvmYl5pa9K8kC0fN1rXHGcCFk9avhUj7EOP0erNj0OULmhGibCEnI3yFAkBvd20xz/CJfhHE6Jtm8IrkbEwXgxc228ffCUjH7pJB74IssQbd1yMGPomwDI/gWGN1sT7sqZR8GFMfoFK4dbatAkEAiP6eosDZ/tSJjM3EkegZBniBt6dcCOaXv1Vs5j/hMFu1WFHqKJXKz51Dw+jW6l4xhwX3uReSZdCgehWpL2jRmA==";

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

-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted  error:&error];
    if (! jsonData) {
        // NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
-(void)selectBtnClick:(UIButton*)button
{
    if (_lastBtn==button) {

    }else
    {
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_lastBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    }
    _lastBtn=button;

}
-(void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jiazai:) name:@"payway" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jiazai1:) name:@"remark" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jiazai2:) name:@"myaddress" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jiazai3:) name:@"coup" object:nil];

    NSLog(@"******");
//    if([WXApi isWXAppInstalled]) // 判断 用户是否安装微信
//    {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:ORDER_PAY_NOTIFICATION object:nil];//监听一个通知
//    }

}
//移除通知
//- (void)viewWillDisappear:(BOOL)animated{
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
//}

- (void)getOrderPayResult:(NSNotification *)notification{
    if ([notification.object isEqualToString:@"success"])
    {
        //        [HUD hide:YES];
        [self alert:@"恭喜" msg:@"您已成功支付啦!"];
        //        payStatusStr           = @"YES";
        //        _successPayView.hidden = NO;
        //        _toPayView.hidden      = YES;
        //        [self creatPaySuccess];

    }
    else
    {
        //        [HUD hide:YES];
        [self alert:@"提示" msg:@"支付失败"];
        
    }
}
-(void)jiazai3:(NSNotification*)noti
{


    _currentCoup=[noti.userInfo objectForKey:@"coup"];
    NSLog(@"----_currentCoup----%@",_currentCoup);
    NSIndexPath*path=[NSIndexPath indexPathForRow:3 inSection:0];
    [_tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:NO];

}
-(void)jiazai2:(NSNotification*)noti
{
    NSLog(@"--tttt%@",[noti.userInfo objectForKey:@"mya"]);
    _currentAddress=[noti.userInfo objectForKey:@"mya"];
    //    NSIndexPath*path=[NSIndexPath indexPathForRow:0 inSection:0];
    //    [_tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:NO];
    [_tableView reloadData];

}
-(void)getAddressData
{
    //NSLog(@"%@",ASK_DEFAULT_ADRESS_URL(USERID));
    [requestData getData:ASK_DEFAULT_ADRESS_URL(USERID) complete:^(NSDictionary *dic) {
        NSLog(@"%@",dic);
        _defaultAddressDic=[dic objectForKey:@"data"];
        if (_currentAddress==nil) {
            _currentAddress=_defaultAddressDic;
        }

        [_tableView reloadData];
    }];

}
-(void)jiazai1:(NSNotification*)noti
{
    _currentRemark=[noti.userInfo objectForKey:@"remark"];
    NSIndexPath*path=[NSIndexPath indexPathForRow:4 inSection:0];
    [_tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:NO];

}
-(void)jiazai:(NSNotification*)noti
{
    _currentPayWay=[noti.userInfo objectForKey:@"payway"];
    NSIndexPath*path=[NSIndexPath indexPathForRow:0 inSection:3];
    [_tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:NO];
    
}

-(void)backClick
{
    POP
    self.tabBarController.tabBar.hidden=YES;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 微信支付
- (void)WeiXinPayWithshopName:(NSString *)shopName OrderNo:(NSString*)orderNo  RealPrice:(NSString*)realPrice{


    if([WXApi isWXAppInstalled]) // 判断 用户是否安装微信
    {
        //{{{
        //本实例只是演示签名过程， 请将该过程在商户服务器上实现

        //创建支付签名对象
        payRequsestHandler *req =[payRequsestHandler alloc];
        //初始化支付签名对象
        [req init:APP_ID mch_id:MCH_ID];
        //设置密钥
        [req setKey:PARTNER_ID];

//        NSDictionary*goodsDic=[[_dataDic objectForKey:@"goods"]objectAtIndex:0];
//
//
//        NSDictionary*dic=[_dataDic objectForKey:@"order"];
//
//        NSString*orderNo=[dic objectForKey:@"orderNo"];

        NSString*Price= [NSString stringWithFormat:@"%ld",[realPrice integerValue]*100];
//        NSString* shopName=[goodsDic objectForKey:@"productName"];

        //订单标题，展示给用户
        NSString *order_name    = shopName;
        //订单金额,单位（分）
        NSString *order_price   = Price;//1分钱测试


        //================================
        //预付单参数订单设置
        //================================
        srand( (unsigned)time(0) );
        NSString *noncestr  = [NSString stringWithFormat:@"%d", rand()];
        //    NSString *orderno   = [NSString stringWithFormat:@"%ld",time(0)];
        NSString *orderno   =orderNo;
        NSMutableDictionary *packageParams = [NSMutableDictionary dictionary];

        [packageParams setObject: APP_ID             forKey:@"appid"];       //开放平台appid
        [packageParams setObject: MCH_ID             forKey:@"mch_id"];      //商户号
        [packageParams setObject: @"APP-001"        forKey:@"device_info"]; //支付设备号或门店号
        [packageParams setObject: noncestr          forKey:@"nonce_str"];   //随机串
        [packageParams setObject: @"APP"            forKey:@"trade_type"];  //支付类型，固定为APP
        [packageParams setObject: order_name        forKey:@"body"];        //订单描述，展示给用户
        [packageParams setObject: [NSString stringWithFormat:@"%@/order/notify.action",BASE_URL]  forKey:@"notify_url"];  //支付结果异步通知
        [packageParams setObject: orderno           forKey:@"out_trade_no"];//商户订单号
        [packageParams setObject: @"196.168.1.1"    forKey:@"spbill_create_ip"];//发器支付的机器ip
        [packageParams setObject: order_price       forKey:@"total_fee"];       //订单金额，单位为分


        //        payRequsestHandler *req =[payRequsestHandler alloc];

        //获取prepayId（预支付交易会话标识）
        NSString *prePayid;

        prePayid  = [req sendPrepay:packageParams];

        if ( prePayid != nil) {
            //获取到prepayid后进行第二次签名

            NSString    *package, *time_stamp, *nonce_str;
            //设置支付参数
            time_t now;
            time(&now);
            time_stamp  = [NSString stringWithFormat:@"%ld", now];
            nonce_str	= [WXUtil md5:time_stamp];
            //重新按提交格式组包，微信客户端暂只支持package=Sign=WXPay格式，须考虑升级后支持携带package具体参数的情况
            //package       = [NSString stringWithFormat:@"Sign=%@",package];
            package         = @"Sign=WXPay";
            //第二次签名参数列表
            NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
            [signParams setObject: APP_ID        forKey:@"appid"];
            [signParams setObject: nonce_str    forKey:@"noncestr"];
            [signParams setObject: package      forKey:@"package"];
            [signParams setObject: MCH_ID        forKey:@"partnerid"];
            [signParams setObject: time_stamp   forKey:@"timestamp"];
            [signParams setObject: prePayid     forKey:@"prepayid"];
            //[signParams setObject: @"MD5"       forKey:@"signType"];
            //生成签名
            NSString *sign  = [req createMd5Sign:signParams];

            //添加签名
            [signParams setObject: sign  forKey:@"sign"];


            //}}}


            //获取到实际调起微信支付的参数后，在app端调起支付
            NSMutableDictionary *dict = signParams;
            //            [self sendPay_demo];

            if(dict == nil){
                //错误提示
                NSString *debug = [req getDebugifo];

                [self alert:@"提示信息" msg:debug];

                NSLog(@"%@\n\n",debug);
            }else{
                NSLog(@"%@\n\n",[req getDebugifo]);
                //[self alert:@"确认" msg:@"下单成功，点击OK后调起支付！"];

                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];

                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                req.openID              = [dict objectForKey:@"appid"];
                req.partnerId           = [dict objectForKey:@"partnerid"];
                req.prepayId            = [dict objectForKey:@"prepayid"];
                req.nonceStr            = [dict objectForKey:@"noncestr"];
                req.timeStamp           = stamp.intValue;
                req.package             = [dict objectForKey:@"package"];
                req.sign                = [dict objectForKey:@"sign"];

                [WXApi sendReq:req];
            }
        }
        
    }else {
        [self alert:@"提示" msg:@"您未安装微信!"];
        
    }
}

//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alter show];
}



@end
