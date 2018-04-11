//
//  orderDetailVC.m
//  logRegister
//
//  Created by apple on 15-1-20.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "orderDetailVC.h"
#import "define.h"
#import "productVC.h"
#import "orderbackVC.h"
#import "commentVC.h"
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
#import "scoreProductVC.h"
#import "WXApi.h"
#import "payRequsestHandler.h"
#import "myButton.h"
#import "postOnWayVC.h"
@interface orderDetailVC ()
{
    NSString*orderNow;
}
@end

@implementation orderDetailVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getdata];
    if([WXApi isWXAppInstalled]) // 判断 用户是否安装微信
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:ORDER_PAY_NOTIFICATION object:nil];//监听一个通知
    }

}
//移除通知
- (void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)getOrderPayResult:(NSNotification *)notification{
    if ([notification.object isEqualToString:@"success"])
    {
//        [HUD hide:YES];
        NSString *url = [NSString stringWithFormat:@"%@/order/notify.action?out_trade_no=%@",BASE_URL,orderNow];

        [requestData getData:url complete:^(NSDictionary *dic) {

            NSLog(@"++out_trade_no++++%@",dic);
            [self getdata];
        }];

        NSString *otherStr = @"查看订单";
        if (self.navigationController.viewControllers.count >4) {
            otherStr =@"继续浏览";
        }
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"恭喜" message:@"您已成功支付啦!" delegate:self cancelButtonTitle:@"返回首页" otherButtonTitles:otherStr, nil];
        alert.tag = 222;
        [alert show];
//        [self alert:@"恭喜" msg:@"您已成功支付啦!"];
//        payStatusStr           = @"YES";
//        _successPayView.hidden = NO;
//        _toPayView.hidden      = YES;
//        [self creatPaySuccess];

    }
    else
    {
//        [HUD hide:YES];
//        [self alert:@"提示" msg:@"支付失败"];

        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"支付失败!" delegate:self cancelButtonTitle:@"取消支付" otherButtonTitles:@"继续支付", nil];
        alert.tag = 333;
        [alert show];

    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN
    TOP_VIEW(@"订单详情")
    _orderStateArray=@[@"未付款",@"已付款",@"卖家已发货",@"交易成功",@"已评论 ",@"订单关闭"];

    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64)];
    [self.view addSubview:_scrollView];

//    NSLog(@"%@",self.orderNo);
//    NSLog(@"%@",ORDER_DETAIL_URL(self.orderNo));

}

-(void)getdata{
    for (id obj in _scrollView.subviews) {
        [obj removeFromSuperview];
    }
    LOADVIEW
    NSLog(@"------%@",ORDER_DETAIL_URL(self.orderNo));

    [requestData getData:ORDER_DETAIL_URL(self.orderNo) complete:^(NSDictionary *dic) {
        LOADREMOVE

        [self getData:dic];
    }];
}
-(void)getData:(NSDictionary*)dic
{
    _dataDic=dic;

    GRAY_TIAO(grayline1, grayview1, grayline2, 0)
//订单状态
    NSDictionary*orderDic=[dic objectForKey:@"order"];
    shopid=[[orderDic objectForKey:@"shopId"] intValue];
     orderS=[[orderDic objectForKey:@"orderState"] intValue];
//     orderS=4;
     orderPayMent=[[orderDic objectForKey:@"orderPayMent"] intValue];


    UILabel*orderState=[[UILabel alloc]init];
    orderState.frame=CGRectMake(_width*0.05, 15, _width*0.9, 60);
    orderState.text=[_orderStateArray objectAtIndex:orderS];
    if (shopid==0) {

        if ( orderS==1) {
            orderState.text = @"积分兑换";
        }

        if ( orderS==3) {
            orderState.text = @"兑换成功";
        }


    }
    orderState.textAlignment=NSTextAlignmentRight;
    orderState.textColor=[UIColor orangeColor];
    orderState.font=[UIFont systemFontOfSize:18];
    [_scrollView addSubview:orderState];

    UILabel*orderRealPrice=[[UILabel alloc]init];
    orderRealPrice.frame=CGRectMake(_width*0.05, 15, 145, 60);
    orderRealPrice.text=@"订单状态";
    orderRealPrice.textAlignment=NSTextAlignmentLeft;
    orderRealPrice.textColor=[UIColor blackColor];
    orderRealPrice.font=[UIFont systemFontOfSize:18];
    [_scrollView addSubview:orderRealPrice];



    CGFloat payHH =0.0;
    if (orderPayMent ==3||orderPayMent ==4) {
        
        orderState.hidden = YES;
        orderRealPrice.hidden = YES;

     }else{
        payHH= 75;
    }

    GRAY_TIAO(grayline3, grayview2, grayline4, payHH)

//收货人信息
    float  tabH;
//    if (shopid==0) {

        UILabel*_linkName_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, 15+payHH, _width*0.9, 30)];
        _linkName_L.text=[NSString stringWithFormat:@"收货人：%@",[orderDic objectForKey:@"orderName"]];
        _linkName_L.font=[UIFont systemFontOfSize:14];
        [_scrollView addSubview:_linkName_L];

        UILabel*_phone_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.7, 15+payHH, _width*0.3, 30)];
        _phone_L.text=[NSString stringWithFormat:@"%@",[orderDic objectForKey:@"orderTel"]];
        _phone_L.font=[UIFont systemFontOfSize:14];
        [_scrollView addSubview:_phone_L];

        UILabel*_address_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, 115-75+payHH, _width*0.9, 35)];
        _address_L.text=[NSString stringWithFormat:@"收货地址：%@",[orderDic objectForKey:@"orderAddress"] ];
    _address_L.numberOfLines=2;
        _address_L.font=[UIFont systemFontOfSize:13];
        [_scrollView addSubview:_address_L];


        tabH=150-75+payHH;
        GRAY_TIAO(grayline5, grayview3, grayline6, 150-75+payHH)
//    }else
//    {
//        tabH=90;
//    }


//物流信息





    if (orderS>=2&&orderS<3) {
        UILabel*postId_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, 165-75+payHH, _width*0.9, 30)];
        if ((NSNull*)[orderDic objectForKey:@"expressNo"]!=[NSNull null]) {
            postId_L.text=[NSString stringWithFormat:@"快递单号：%@",[orderDic objectForKey:@"expressNo"] ];

        }else{
            postId_L.text=@"快递单号：";

        }
        postId_L.font=[UIFont systemFontOfSize:14];
        [_scrollView addSubview:postId_L];

        UILabel*postCompany=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, 195-75+payHH, _width*0.55, 30)];
        if ((NSNull*)[orderDic objectForKey:@"expressTypeName"]!=[NSNull null]) {
            postCompany.text=[NSString stringWithFormat:@"物流公司：%@",[orderDic objectForKey:@"expressTypeName"]];

        }else{
            postCompany.text=@"物流公司：";
            
        }

        postCompany.font=[UIFont systemFontOfSize:14];
        [_scrollView addSubview:postCompany];

        UILabel*postTime=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.55, 195-75+payHH, _width*0.4, 30)];
        postTime.text=[orderDic objectForKey:@"orderDate"];
        postTime.font=[UIFont systemFontOfSize:12];
        postTime.textAlignment=NSTextAlignmentRight;
        [_scrollView addSubview:postTime];

        GRAY_TIAO(grayline7, grayview4, grayline8, 225-75+payHH)

        tabH=240-75+payHH;

        UIButton *scanbutton =[[UIButton alloc]initWithFrame:CGRectMake(0, 165-75+payHH, _width, 60)];
        [scanbutton addTarget:self action:@selector(scanPost) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:scanbutton];

        UIImageView *indictorImg= [[UIImageView alloc]initWithFrame:CGRectMake(_width-20, 20.5+165-75+payHH, 7.5, 15)];
        indictorImg.image = [UIImage  imageNamed:@"rightArrow"];
        [_scrollView addSubview:indictorImg];
    }
    else
    {
        tabH=165-75+payHH;

    }



//商品信息
    if (shopid==0) {

        UILabel*jifen_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, tabH, _width*0.6, 50)];
        jifen_L.text=@"积分商品";
        jifen_L.textAlignment=NSTextAlignmentLeft;
        jifen_L.font=[UIFont boldSystemFontOfSize:15];
        [_scrollView addSubview:jifen_L];

    }else
    {
//    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame=CGRectMake(_width*0.05, tabH, _width*0.4, 50);
//    button.tag=[[orderDic objectForKey:@"shopId"] intValue];
//    [button addTarget:self action:@selector(shopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [_scrollView addSubview:button];
//
//
//
//    UIImageView*shopIv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 7.5, 35, 35)];
//    [shopIv sd_setImageWithURL:[NSURL URLWithString:[orderDic objectForKey:@"shopLogo"]] placeholderImage:[UIImage imageNamed:@"morentu.jpg"]];
//    shopIv.layer.borderColor=RGB(234, 234, 234).CGColor;
//    shopIv.layer.borderWidth=1;
//    [button addSubview:shopIv];
//
//
//    UILabel*shopName_L=[[UILabel alloc]initWithFrame:CGRectMake(55, 0, _width*0.6, 50)];
//    shopName_L.text=[orderDic objectForKey:@"shopName"];
//    shopName_L.textAlignment=NSTextAlignmentLeft;
//    shopName_L.font=[UIFont boldSystemFontOfSize:15];
//    [button addSubview:shopName_L];


    }
//    UIView*grayView4=[[UIView alloc]initWithFrame:CGRectMake(0, tabH+49, _width, 1)];
//    grayView4.backgroundColor=RGB(234, 234, 234);
//    [_scrollView addSubview:grayView4];

    _goodsArray=[dic objectForKey:@"goods"];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, tabH, _width, (_width*0.22+30)*_goodsArray.count)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.scrollEnabled=NO;
    _tableView.rowHeight=_width*0.22+30;
    [_scrollView addSubview:_tableView];



    float h1=(_width*0.22+30)*_goodsArray.count+tabH;
    //运费 付款


    UILabel*postCost_L=[[UILabel alloc]init];
    postCost_L.frame=CGRectMake(_width*0.05, h1, 80, 50);
    postCost_L.text=@"运费：免邮";
    postCost_L.textAlignment=NSTextAlignmentLeft;
    postCost_L.textColor=[UIColor grayColor];
    postCost_L.font=[UIFont systemFontOfSize:14];
    [_scrollView addSubview:postCost_L];



    UILabel*RealPrice_La=[[UILabel alloc]init];
    RealPrice_La.frame=CGRectMake(_width*0.05, h1, _width*0.9, 50);

    NSString*string_p;
    if (shopid==0) {
        string_p=[NSString stringWithFormat:@"实付款：￥%.2f",[[orderDic objectForKey:@"realPrice"] doubleValue]];
    }else
    {
        string_p=[NSString stringWithFormat:@"实付款：￥%.2f",[[orderDic objectForKey:@"realPrice"] doubleValue]];
    }
    RealPrice_La.textColor=[UIColor orangeColor];
    NSMutableAttributedString*atts=[[NSMutableAttributedString alloc]initWithString:string_p];
    [atts addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, 4)];
    RealPrice_La.attributedText=atts;

    RealPrice_La.textAlignment=NSTextAlignmentRight;

    RealPrice_La.font=[UIFont systemFontOfSize:14];
    [_scrollView addSubview:RealPrice_La];


//    _changeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    _changeBtn.frame=CGRectMake(_width*0.75, h1+10, _width*0.2, 30);
//    _changeBtn.tag=orderS;
//    [_changeBtn addTarget:self action:@selector(gotoPay:) forControlEvents:UIControlEventTouchUpInside];
//    _changeBtn.titleLabel.font=[UIFont systemFontOfSize:15];
//    _changeBtn.backgroundColor=APP_ClOUR;
//    [_changeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    _changeBtn.layer.cornerRadius=5;
//    [_scrollView addSubview:_changeBtn];
//    [_scrollView bringSubviewToFront:_changeBtn];


        UIButton*sureGet=[UIButton buttonWithType:UIButtonTypeCustom];
        sureGet.frame=CGRectMake(_width*0.55, h1+60, _width*0.35, 40);
        [sureGet setTitle:@"确认收货" forState:UIControlStateNormal];
        [sureGet setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [sureGet setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    sureGet.tag = orderS;
        sureGet.layer.borderColor=RGB(234, 234, 234).CGColor ;
        sureGet.layer.borderWidth=1;
        sureGet.layer.cornerRadius=4;
        sureGet.titleLabel.font=[UIFont systemFontOfSize:15];


        [_scrollView addSubview:sureGet];


//    UIButton *sureGet=[UIButton buttonWithType:UIButtonTypeCustom];
//    sureGet.frame=CGRectMake(_width*0.5, h1+10, _width*0.2, 30);
//    [sureGet addTarget:self action:@selector(sureGetClick) forControlEvents:UIControlEventTouchUpInside];
//    sureGet.titleLabel.font=[UIFont systemFontOfSize:15];
//    sureGet.backgroundColor=APP_ClOUR;
//    [sureGet setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//    sureGet.layer.cornerRadius=5;
//    [sureGet setTitle:@"确认收货" forState:UIControlStateNormal];
//
//    [_scrollView addSubview:sureGet];


    if (orderS==0) {
        if (orderPayMent==3||orderPayMent==4) {
            sureGet.hidden =YES;
//            _changeBtn.hidden=YES;
//            sureGet.frame = _changeBtn.frame;

        }else{
//            sureGet.hidden =YES;
            [sureGet setTitle:@"去付款" forState:UIControlStateNormal];
     [sureGet addTarget:self action:@selector(gotoPay:) forControlEvents:UIControlEventTouchUpInside];

        }

    }else if (orderS==1)
    {
        sureGet.hidden =YES;
//        _changeBtn.hidden=YES;

    }
    else if (orderS==2)
    {
            sureGet.hidden =NO;
        [sureGet addTarget:self action:@selector(sureGetClick) forControlEvents:UIControlEventTouchUpInside];

//            _changeBtn.hidden=YES;
//            sureGet.frame = _changeBtn.frame;



    }
    else if (orderS==3)
    {
//        sureGet.hidden =YES;
//        _changeBtn.hidden=NO;
            [sureGet setTitle:@"去评论" forState:UIControlStateNormal];
        [sureGet addTarget:self action:@selector(gotoPay:) forControlEvents:UIControlEventTouchUpInside];

        if (shopid==0) {
            sureGet.hidden=YES;

        }

    }else
    {
//        _changeBtn.hidden=YES;
        sureGet.hidden = YES;

    }
//    if (shopid==0) {
//        _changeBtn.hidden=YES;
//        sureGet.hidden = YES;
//    }


    GRAY_LINE(grayline9, h1+50)

    //联系方式

    UIButton*contact_B=[UIButton buttonWithType:UIButtonTypeCustom];
    contact_B.frame=CGRectMake(_width*0.1, h1+60, _width*0.35, 40);
    [contact_B setTitle:@"联系卖家" forState:UIControlStateNormal];
    [contact_B setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [contact_B setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    contact_B.layer.borderColor=RGB(234, 234, 234).CGColor ;
    contact_B.layer.borderWidth=1;
    contact_B.layer.cornerRadius=4;
    contact_B.titleLabel.font=[UIFont systemFontOfSize:15];
    [contact_B addTarget:self action:@selector(contactBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [contact_B setTitleEdgeInsets:UIEdgeInsetsMake(5, 35, 5, 10)];
    UIImageView*contactIv=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
//    contactIv.image=[UIImage imageNamed:@"contact"];
    contactIv.image=[UIImage imageNamed:@"phone"];

    [contact_B addSubview:contactIv];

    [_scrollView addSubview:contact_B];


//    UIButton*phone_B=[UIButton buttonWithType:UIButtonTypeCustom];
//    phone_B.frame=CGRectMake(_width*0.55, h1+60, _width*0.35, 40);
//    [phone_B setTitle:@"拨打电话" forState:UIControlStateNormal];
//    [phone_B setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//    [phone_B setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//    phone_B.layer.borderColor=RGB(234, 234, 234).CGColor ;
//    phone_B.layer.borderWidth=1;
//    phone_B.layer.cornerRadius=4;
//    phone_B.titleLabel.font=[UIFont systemFontOfSize:13];
//    [phone_B addTarget:self action:@selector(phoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [phone_B setTitleEdgeInsets:UIEdgeInsetsMake(5, 35, 5, 10)];
//
//    UIImageView*phone_Iv=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
//    phone_Iv.image=[UIImage imageNamed:@"phone"];
//    [phone_B addSubview:phone_Iv];
//
//    [_scrollView addSubview:phone_B];
    if (shopid==0) {
        contact_B.hidden=YES;
//        phone_B.hidden=YES;
        h1=h1-50;
    }

    GRAY_TIAO(gray1, grayview5, gray2, h1+50+60)

    UILabel*orderNo_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05,h1+135, _width*0.9, 25)];

    orderNo_L.text=[NSString stringWithFormat:@"订 单 号 ：%@",[orderDic objectForKey:@"orderNo"]];
    orderNo_L.textAlignment=NSTextAlignmentLeft;
    orderNo_L.textColor=[UIColor grayColor];
    orderNo_L.font=[UIFont systemFontOfSize:14];
    [_scrollView addSubview:orderNo_L];

    UILabel*finishTime_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05,h1+160, _width*0.9, 25)];
    finishTime_L.text=[NSString stringWithFormat:@"下单时间：%@",[orderDic objectForKey:@"orderDate"]];
    finishTime_L.textAlignment=NSTextAlignmentLeft;
    finishTime_L.textColor=[UIColor grayColor];
    finishTime_L.font=[UIFont systemFontOfSize:14];
    [_scrollView addSubview:finishTime_L];

    UILabel*remark_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05,h1+185, _width*0.9, 25)];
    NSString*remarkStr=[orderDic objectForKey:@"remark"];

    remark_L.text=[NSString stringWithFormat:@"备注：%@",[orderDic objectForKey:@"remark"]];
    remark_L.textAlignment=NSTextAlignmentLeft;
    remark_L.textColor=[UIColor grayColor];
    remark_L.font=[UIFont systemFontOfSize:14];
    [_scrollView addSubview:remark_L];

    UILabel*payMent_L=[[UILabel alloc]init];
    payMent_L.textAlignment=NSTextAlignmentLeft;
    payMent_L.textColor=[UIColor grayColor];
    payMent_L.font=[UIFont systemFontOfSize:14];
    NSArray*orderParmentA=@[@"支付宝",@"微信支付",@"货到付款",@"上门自提",];

        if (shopid==0) {
        payMent_L.text=[NSString stringWithFormat:@"支付方式：%@",@"积分兑换"];
    }else{
        payMent_L.text=[NSString stringWithFormat:@"支付方式：%@",[orderParmentA objectAtIndex:orderPayMent-1]];

    }
    [_scrollView addSubview:payMent_L];

    if (remarkStr.length==0) {
        [remark_L removeFromSuperview];
        
         payMent_L.frame=CGRectMake(_width*0.05,h1+185, _width*0.9, 25);


        _scrollView.contentSize=CGSizeMake(_width, h1+240);



    }else
    {
         payMent_L.frame=CGRectMake(_width*0.05,h1+210, _width*0.9, 25);

        _scrollView.contentSize=CGSizeMake(_width, h1+275);


    }



}

-(void)contactBtnClick
{
//    NAV_PUSH(communicateVC)
//PUSH(com)
//    vc.manageId=[[_dataDic objectForKey:@"order"] objectForKey:@"manageId"];
    NSString*phone=[[_dataDic objectForKey:@"order"] objectForKey:@"telePhone"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]]];

}
-(void)phoneBtnClick
{
//    NSLog(@"phone");
    NSString*phone=[[_dataDic objectForKey:@"order"] objectForKey:@"telePhone"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]]];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _goodsArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSDictionary*dic=[_goodsArray objectAtIndex:indexPath.row];
    NSString*productId=[dic objectForKey:@"productId"];
     NSString*number=[dic objectForKey:@"number"];
     NSString*productImage=[dic objectForKey:@"productImage"];
     NSString*productName=[dic objectForKey:@"productName"];
     NSString*productPrice=[dic objectForKey:@"productPrice"];
    NSString* isBack=[dic objectForKey:@"isBack"];


    UIImageView*_productIv=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.05, 15, _width*0.22, _width*0.22)];
//    [_productIv sd_setImageWithURL:[NSURL URLWithString:productImage] placeholderImage:[UIImage imageNamed:@"fang"]];
    [_productIv sd_setImageWithURL:[NSURL URLWithString:productImage] placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            float  W=(_width*0.22)*image.size.width/image.size.height;

            _productIv.frame = CGRectMake((_width*0.22-W)/2+_width*0.05, 15, W, _width*0.22);
            


        }
            }];
    _productIv.backgroundColor = [UIColor redColor];
    [cell.contentView addSubview:_productIv];
    UILabel*_productName=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.29, 15, _width*0.65, 20)];
    _productName.textAlignment=NSTextAlignmentLeft;
    _productName.textColor=[UIColor darkGrayColor];
    _productName.font=[UIFont systemFontOfSize:15];

    _productName.numberOfLines=1;
    if (productName.length>11) {
        _productName.numberOfLines=2;
        _productName.frame=CGRectMake(_width*0.29, 15, _width*0.6, 40);
    }
    _productName.text=productName;
    [cell.contentView addSubview:_productName];

    UILabel*_price=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.29, _width*0.22, _width*0.27, 20)];
    _price.textAlignment=NSTextAlignmentLeft;
    _price.textColor=[UIColor blackColor];
    _price.font=[UIFont systemFontOfSize:13];
    _price.text=[NSString stringWithFormat:@"￥%.2f",[productPrice doubleValue]];
    _price.numberOfLines=1;
    [cell.contentView addSubview:_price];

//   CGFloat ww= [self boundWithSize:CGSizeMake(_width*0.27, 20) WithString:_price.text WithFont:_price.font].width;

    UILabel*_number_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.29, 15, _width*0.71-10, 20)];
    _number_L.textAlignment=NSTextAlignmentRight;
    _number_L.textColor=[UIColor grayColor];
    _number_L.font=[UIFont systemFontOfSize:15];
    _number_L.text=[NSString stringWithFormat:@"x%@",number];
    _number_L.numberOfLines=1;
    [cell.contentView addSubview:_number_L];

    myButton *ordBackBtn = [myButton buttonWithType:UIButtonTypeRoundedRect];
    ordBackBtn.frame =CGRectMake(_width*0.75, _width*0.22-15, _width*0.2, 30);


    ordBackBtn.backgroundColor = APP_ClOUR;
    ordBackBtn.layer.cornerRadius = 5;
    ordBackBtn.tag = [productId integerValue];
    CGFloat pricelab = [number integerValue]*[productPrice floatValue];

    ordBackBtn.nameString = [NSString stringWithFormat:@"%f",pricelab];
//    [ordBackBtn setTitle:@"退货" forState:UIControlStateNormal];
    [ordBackBtn addTarget:self action:@selector(ordBackClick:)forControlEvents:UIControlEventTouchUpInside];
    [ordBackBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    ordBackBtn.hidden = YES;
    [ordBackBtn setTitle:@"退款" forState:UIControlStateNormal];
    NSLog(@"isBack===%@",isBack);
    if (orderS==2) {

        if (shopid!=0) {
            if (orderPayMent==2||orderPayMent==1) {
                ordBackBtn.hidden = NO;
            }

            if ([isBack isKindOfClass:[NSNull class]]) {

            }else if ([isBack integerValue]==0){
                [ordBackBtn setTitle:@"申请中" forState:UIControlStateNormal];
                ordBackBtn.userInteractionEnabled =NO;
            }else if ([isBack integerValue]==1){
                [ordBackBtn setTitle:@"申请成功" forState:UIControlStateNormal];
                ordBackBtn.userInteractionEnabled =NO;
            }else if ([isBack integerValue]==2){
                [ordBackBtn setTitle:@"申请拒绝" forState:UIControlStateNormal];
                ordBackBtn.userInteractionEnabled =NO;
            }

        }
    }
    [cell.contentView addSubview:ordBackBtn];


    return cell;


}
-(void)ordBackClick:(myButton*)button{
    PUSH(orderbackVC)
    vc.orderNo=[_dataDic[@"order"] objectForKey:@"orderNo"];
    vc.orderState =[_dataDic[@"order"] objectForKey:@"orderState"];
    vc.realPrice = button.nameString;
    vc.productId = [NSString stringWithFormat:@"%ld",button.tag];
    NSLog(@"+++++++++++%ld",button.tag);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary*dic=[_goodsArray objectAtIndex:indexPath.row];
    NSString*productId=[dic objectForKey:@"productId"];
    int shopId=[[[_dataDic objectForKey:@"order"] objectForKey:@"shopId"] intValue];
    if (shopId==0) {
        PUSH(scoreProductVC)
        vc.productId=productId;

    }else
    {

        productVC*vc=[[productVC alloc]init];
        vc.productId=productId;
        [self.navigationController pushViewController:vc animated:YES];

    }
 

}
-(void)gotoPay:(UIButton*)button
{
    if (button.tag==3)
    {
        commentVC*vc=[[commentVC alloc]init];
        vc.dic=_dataDic;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (button.tag==0)
    {
//        MISSINGVIEW
//        missing_v.tishi=@"暂未开通该项服务";

        NSDictionary*dic=[_dataDic objectForKey:@"order"];

        NSString*orderNo=[dic objectForKey:@"orderNo"];
        NSString*realPrice=[dic objectForKey:@"realPrice"];
        NSString* shopName=[dic objectForKey:@"shopName"];
//        NSString*orderState=[_dataDic objectForKey:@"orderState"];
        if ([[dic objectForKey:@"orderPayMent"] integerValue]==1) {
            [self zhifubao:shopName with:shopName with:orderNo with:realPrice];
        }else
        if ([[dic objectForKey:@"orderPayMent"] integerValue]==2) {

//                    MISSINGVIEW
//                    missing_v.tishi=@"微信支付暂未开通";

            [self WeiXinPay];//选择微信支付；

        }

    }

    if (button.tag == 2 ||button.tag == 1) {

    }

}
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
    price =@"0.01";
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
         {
                if ([[resultDic objectForKey:@"resultStatus"] intValue]==9000) {
                    NSString *otherStr = @"查看订单";
                    if (self.navigationController.viewControllers.count >4) {
                        otherStr =@"继续浏览";
                    }
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"恭喜" message:@"您已成功支付啦!" delegate:self cancelButtonTitle:@"返回首页" otherButtonTitles:otherStr, nil];
                    alert.tag = 222;
                    [alert show];

                }   else {

                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"支付失败!" delegate:self cancelButtonTitle:@"取消支付" otherButtonTitles:@"继续支付", nil];
                    alert.tag = 444;
                    [alert show];
                    
                    
                }

                   [self getdata];
            }
        }];
        
    }
    
    
}

-(void)shopBtnClick:(UIButton*)button
{
//    PUSH(shopVC)
//    vc.shopId=[NSString stringWithFormat:@"%ld",(long)button.tag];



}
-(void)sureGetClick{
    NSLog(@"确认收货");
    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:nil message:@"你要确定收货吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];






}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==222) {

        if (buttonIndex==0) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            if (self.navigationController.viewControllers.count >4) {
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
                
            }
        }
    }else if(alertView.tag==333){
        if (buttonIndex==0) {

        }else{
            [self WeiXinPay];
        }

    }else if(alertView.tag==444){
        if (buttonIndex==0) {

        }else{

            NSDictionary*dic=[_dataDic objectForKey:@"order"];

            NSString*orderNo=[dic objectForKey:@"orderNo"];
            NSString*realPrice=[dic objectForKey:@"realPrice"];
            NSString* shopName=[dic objectForKey:@"shopName"];
            [self zhifubao:shopName with:shopName with:orderNo with:realPrice];
        }
        
    }else
    {


        if (buttonIndex==1) {

            NSLog(@"%@",ORDER_RECEIVE_URL(_orderNo));
            [requestData getData:ORDER_RECEIVE_URL(_orderNo) complete:^(NSDictionary *dic) {
                NSLog(@"%@",dic);
                if ([[dic objectForKey:@"flag"] intValue]==1) {
                    //                ALERT([dic objectForKey:@"info"])

                }else
                {
                    ALERT([dic objectForKey:@"info"])
                }
                
                [self getdata];
                
            }];
        }else{
            
        }
    }

}
-(void)backClick
{
    NSLog(@"====%@",self.navigationController.viewControllers);

    if (self.navigationController.viewControllers.count >4) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:3] animated:YES];

    }else{
        POP

    }


}



#pragma mark - 微信支付
- (void)WeiXinPay{

    NSLog(@"--------微信支付---------------");

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

        NSDictionary*goodsDic=[[_dataDic objectForKey:@"goods"]objectAtIndex:0];



        NSDictionary*dic=[_dataDic objectForKey:@"order"];

        orderNow=[dic objectForKey:@"orderNo"];
//        NSString*realPrice= [NSString stringWithFormat:@"%ld",[[dic objectForKey:@"realPrice"] integerValue]*100];
        NSString* shopName=[goodsDic objectForKey:@"productName"];

        //订单标题，展示给用户
        NSString *order_name    = shopName;
        //订单金额,单位（分）
        NSString *order_price   = @"1";//1分钱测试

        NSLog(@"+++_dataDic==%@===",_dataDic);
        //================================
        //预付单参数订单设置
        //================================
        srand( (unsigned)time(0) );
        NSString *noncestr  = [NSString stringWithFormat:@"%d", rand()];
        //    NSString *orderno   = [NSString stringWithFormat:@"%ld",time(0)];
        NSString *orderno   =orderNow;
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



        //获取prepayId（预支付交易会话标识）
        NSString *prePayid;
        prePayid  = [req sendPrepay:packageParams];
        NSLog(@"prePayid===%@=====%@",prePayid,packageParams);

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

-(CGSize)boundWithSize:(CGSize)size  WithString:(NSString*)str  WithFont:(UIFont*)font
{
    NSDictionary *attribute = @{NSFontAttributeName: font};

    CGSize retSize = [str boundingRectWithSize:size
                                       options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil].size;

    return retSize;
}

-(void)scanPost{
    NSString *URL= [NSString stringWithFormat:@"%@/order/getExpress.action?orderNo=%@",BASE_URL,self.orderNo];
    NSLog(@"====%@===",URL);
    [requestData getData:URL complete:^(NSDictionary *dic) {
        if ([dic[@"flag"]integerValue]==1) {
            PUSH(postOnWayVC)
            vc.dic = dic;

        }else{
//            [self alert:@"提示" msg:@"您未安装微信!"];

        }

    }];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
