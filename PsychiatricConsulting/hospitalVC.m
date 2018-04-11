//
//  hospitalVC.m
//  PsychiatricConsulting
//
//  Created by apple on 15-5-6.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "hospitalVC.h"
#import "productVC.h"
#import "logInVC.h"
#import "chargeListCell.h"
@interface hospitalVC ()

@end

@implementation hospitalVC

- (void)viewDidLoad {
    [super viewDidLoad];
   TOP_VIEW(@"商家详情")

    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64)];
    _scrollView.delegate=self;
    _scrollView.bounces=YES;
    [self.view addSubview:_scrollView];


    _shopbg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _width, _width*0.55)];
    _shopbg.image=[UIImage imageNamed:@"chang"];
    [_scrollView addSubview:_shopbg];

    UIView*touming_t=[[UIView alloc]initWithFrame:CGRectMake(0, _width*0.405, _width, _width*0.25)];
    touming_t.backgroundColor=[UIColor colorWithWhite:0.5 alpha:0.3];
    [_scrollView addSubview:touming_t];



    UIButton*collectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    collectBtn.frame=CGRectMake(_width*0.8, _width*0.45, _width*0.2, _width*0.1);
    [collectBtn setImage:[UIImage imageNamed:@"collect7"] forState:UIControlStateNormal];
    [collectBtn setImageEdgeInsets:UIEdgeInsetsMake((_width*0.1-15)/2, _width*0.02, (_width*0.1-15)/2, _width*0.18-15)];

    [collectBtn setTitle:@"关注" forState:UIControlStateNormal];
     [collectBtn setTitleEdgeInsets:UIEdgeInsetsMake(1, 5, 1, 5)];
    [collectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    collectBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [collectBtn addTarget:self action:@selector(collectShopBtn) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:collectBtn];



    UIView*kuang=[[UIView alloc]init];
    kuang.bounds=CGRectMake(0, 0, _width*0.25, _width*0.25);
    kuang.center=CGPointMake(_width*0.2, _width*0.53);
    kuang.backgroundColor=[UIColor whiteColor];
    kuang.layer.borderColor=RGB(234, 234, 234).CGColor;
    kuang.layer.borderWidth=1;
    [_scrollView addSubview:kuang];


    _shop_logo=[[UIImageView alloc]initWithFrame:CGRectMake(2, 2, _width*0.25-4, _width*0.25-4)];
    _shop_logo.image=[UIImage imageNamed:@"fang"];
    [kuang addSubview:_shop_logo];



    _shopName_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.36, _width*0.45, _width*0.62, _width*0.1)];
    _shopName_L.text=@"";
    _shopName_L.textColor=RGB(244, 244, 244);
    _shopName_L.font=[UIFont boldSystemFontOfSize:15];
    _shopName_L.textAlignment=NSTextAlignmentLeft;
    [_scrollView addSubview:_shopName_L];

    _shopPeoNum_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.36, _width*0.56, _width*0.19, _width*0.065)];
    _shopPeoNum_L.text=@"人气";
    _shopPeoNum_L.textColor=[UIColor darkGrayColor];
    _shopPeoNum_L.textAlignment=NSTextAlignmentLeft;
    _shopPeoNum_L.font=[UIFont systemFontOfSize:13];
    [_scrollView addSubview:_shopPeoNum_L];




    UILabel*dengji=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.55, _width*0.56, _width*0.1, _width*0.065)];
    dengji.text=@"等级:";
    dengji.textColor=[UIColor darkGrayColor];
    dengji.textAlignment=NSTextAlignmentRight;
    dengji.font=[UIFont systemFontOfSize:13];
    [_scrollView addSubview:dengji];


    _shopGrade=[UIButton buttonWithType:UIButtonTypeCustom];
    _shopGrade.frame=CGRectMake(_width*0.65, _width*0.56, _width*0.17, 18);

    [_shopGrade setTitle:@"新星VIP" forState:UIControlStateNormal];
    _shopGrade.backgroundColor=APP_ClOUR;
    [_shopGrade setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _shopGrade.titleLabel.font=[UIFont systemFontOfSize:12];
    _shopGrade.layer.cornerRadius=5;
    [_scrollView addSubview:_shopGrade];

    [self getData];

}
-(void)collectShopBtn
{
    [requestData getData:ADD_COLLECTION_URL(USERID, self.shopId, @"1") complete:^(NSDictionary *dic) {
        MISSINGVIEW
        missing_v.tishi=[dic objectForKey:@"info"];

    }];

}

-(void)getData
{
    LOADVIEW
    [requestData getData:SHOP_URL(self.shopId) complete:^(NSDictionary *dic) {
        LOADREMOVE
       // NSLog(@"%@",dic);
        _dataDic=dic;
        NSDictionary*shopdic=[dic objectForKey:@"data"];
        _phoneNumber=[shopdic objectForKey:@"telePhone"];
        _isSincerity=[shopdic objectForKey:@"isSincerity"];

        //人气

        id clicks=[dic objectForKey:@"clicks"];

        if (clicks==[NSNull null]||clicks==nil||clicks==NULL) {
            clicks=@"0";
        }
        _shopPeoNum_L.text=[NSString stringWithFormat:@"人气:%@",clicks];




        id shopadress=[shopdic objectForKey:@"shopAddress"];
        if (shopadress==[NSNull null]) {
            _shopAddress=@"";
        }else
        {
            _shopAddress=shopadress;
        }



        id shopadv=[shopdic objectForKey:@"shopAdv"];
        if (shopadv==[NSNull null]) {
            shopadv=nil;
        }

        [_shopbg sd_setImageWithURL:[NSURL URLWithString:shopadv] placeholderImage:[UIImage imageNamed:@"chang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

        }];

        id shoplogo=[shopdic objectForKey:@"shopLogo"];
        if (shoplogo==[NSNull null]) {
            shoplogo=nil;
        }
        [_shop_logo sd_setImageWithURL:[NSURL URLWithString:shoplogo] placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

        }];

        _shopDesc=[shopdic objectForKey:@"desc"];

        _shopName=[shopdic objectForKey:@"shopName"];
        _shopName_L.text=_shopName;
        [self lowView:_width*0.65];

    }];

}

-(void)lowView:(float)adH
{
    NSArray*nameA=@[@"商品列表",@"活动",@"商家详情",];
    for (int i=0; i<3; i++) {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(_width/3*i, adH, _width/3, 50);
        [button setTitle:[nameA objectAtIndex:i] forState:UIControlStateNormal];
        if (i==0) {
            [button setTitleColor:APP_ClOUR forState:UIControlStateNormal];
            _lastBtn=button;
            _currentBTn=button;
        }else
        {
            [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        }

        button.tag=i;
        button.titleLabel.font=[UIFont boldSystemFontOfSize:15];
        [button addTarget:self action:@selector(threeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];
    }
    _moveView=[[UIView alloc]initWithFrame:CGRectMake(0, adH+45, _width/3, 4)];
    _moveView.backgroundColor=APP_ClOUR;
    [_scrollView addSubview:_moveView];


    UIView*grayLine1=[[UIView alloc]initWithFrame:CGRectMake(0, adH+49, _width, 1)];
    grayLine1.backgroundColor=APP_ClOUR;
    grayLine1.alpha=0.5;
    [_scrollView addSubview:grayLine1];



    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, adH+50, _width, 10000)];

    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.scrollEnabled=NO;

    [_scrollView addSubview:_tableView];
    [self getLowList];
    
}
-(void)phoneBtnClick
{

    NSLog(@"正在拨打电话");
    if (USERID==nil) {
            ALLOC(logInVC)
            [self presentViewController:vc animated:NO completion:^{
    
            }];
    

    }else

    {
        if (_phoneNumber==nil) {
            ALERT(@"未开通该项服务")

        }else
        {
             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",_phoneNumber]]];

        }


    }
    

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
-(void)threeBtnClick:(UIButton*)button
{
    _currentBTn=button;
    if (button==_lastBtn) {

    }else
    {
        [button setTitleColor:APP_ClOUR forState:UIControlStateNormal];
        [_lastBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _lastBtn=button;
    }


    [UIView animateWithDuration:0.3 animations:^{
        _moveView.frame=CGRectMake(_width/3*(float)_currentBTn.tag, _moveView.frame.origin.y, _width/3, 4);

    } completion:^(BOOL finished) {

    }];
    [self getLowList];
}
-(void)getLowList
{

    UIImageView*imagev=(UIImageView*)[_tableView viewWithTag:7777];
    UILabel*tishila=(UILabel*)[_tableView viewWithTag:77777];
    [imagev removeFromSuperview];
    [tishila removeFromSuperview];
    if (_currentBTn.tag==2) {
        [_tableView reloadData];
         _tableView.separatorColor=[UIColor grayColor];

        CGSize size=[self boundWithSize:CGSizeMake(_width*0.6, 0) WithString:_shopDesc WithFont:[UIFont italicSystemFontOfSize:15]];

        float HH;
        if (size.height+20<60) {
            HH= 60;
        }else
        {
            HH= size.height+20;
        }
        _scrollView.contentSize=CGSizeMake(_width, _width*0.65+50+180+HH);
        if (_width*0.65+50+180+HH<_height) {
             _scrollView.contentSize=CGSizeMake(_width, _height+1);
        }

    }
    if (_currentBTn.tag==0) {
         _tableView.separatorColor=[UIColor grayColor];
        LOADVIEW
        [requestData getData:LBS_SHOP_PRODUCT_URL(self.shopId) complete:^(NSDictionary *dic) {
            LOADREMOVE
             NSLog(@"%@",dic);
            _dataArray=[dic objectForKey:@"data"];
            [_tableView reloadData];
            _scrollView.contentSize=CGSizeMake(_width, _width*0.8+50+_width*0.3*_dataArray.count+20+_descH);

            if (_dataArray.count==0||_dataArray==nil) {
                UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, 30, 50,50)];
                tanhao.image=[UIImage imageNamed:@"tanhao"];
                [_tableView addSubview:tanhao];
                tanhao.tag=7777;

                UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, 90, _width, 20)];
                tishi.text=@"没有商品哦";
                tishi.textColor=[UIColor grayColor];
                tishi.textAlignment=NSTextAlignmentCenter;
                tishi.font=[UIFont systemFontOfSize:14];
                [_tableView addSubview:tishi];
                tishi.tag=77777;
            }

        }];

    }
    if (_currentBTn.tag==1) {
         _tableView.separatorColor=[UIColor whiteColor];
        NSString*url;
        if (USERID ==nil) {
            url=[NSString stringWithFormat:@"%@&shopId=%d&type=1",ASK_COUPONS_URL,[self.shopId intValue]];

        }else
        {
            url=[NSString stringWithFormat:@"%@&shopId=%d&type=1&userId=%@",ASK_COUPONS_URL,[self.shopId intValue],USERID];

        }

        LOADVIEW
        NSLog(@"%@",url);

        [requestData getData:url complete:^(NSDictionary *dic) {
             NSLog(@"%@",dic);
            LOADREMOVE
            _dataArray=[dic objectForKey:@"data"];
            [_tableView reloadData];

            float  tabH = 0.0;

            for (int i=0; i<_dataArray.count; i++) {
                NSDictionary*coupDic=[_dataArray objectAtIndex:i];
                id  couponsDesc=[coupDic objectForKey:@"couponsDesc"];
                CGSize size;
                if (couponsDesc==[NSNull null]) {
                    size=CGSizeMake(0, 0);
                }else
                {
                    size=[self boundWithSize:CGSizeMake(_width*0.9, 0) WithString:couponsDesc WithFont:[UIFont systemFontOfSize:14]];

                }
                tabH=tabH+125+size.height+10;

            }

            if (tabH+_width*0.8+70<=_height) {
                _scrollView.contentSize=CGSizeMake(_width,tabH+1+_width*0.8+70);
            }else
            {
                _scrollView.contentSize=CGSizeMake(_width, tabH+_width*0.8+70);

            }
            if (_dataArray.count==0||_dataArray==nil) {
                UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, 30, 50,50)];
                tanhao.image=[UIImage imageNamed:@"tanhao"];
                [_tableView addSubview:tanhao];
                tanhao.tag=7777;

                UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, 90, _width, 20)];
                tishi.text=@"没有优惠活动哦";
                tishi.textColor=[UIColor grayColor];
                tishi.textAlignment=NSTextAlignmentCenter;
                tishi.font=[UIFont systemFontOfSize:14];
                [_tableView addSubview:tishi];
                tishi.tag=77777;
            }
        }];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (_currentBTn.tag==2) {
        return 4;
    }else
    {
        return _dataArray.count;

    }


}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_currentBTn.tag==2) {

        if (indexPath.row==1) {

            CGSize size=[self boundWithSize:CGSizeMake(_width*0.6, 0) WithString:_shopDesc WithFont:[UIFont italicSystemFontOfSize:15]];
            if (size.height+20<60) {
                return 60;
            }else
            {
                return size.height+20;
            }
        }else
        {
            return 60;
        }

    }else if(_currentBTn.tag==1)
    {
        NSDictionary*dic=[_dataArray objectAtIndex:indexPath.section];
        id  couponsDesc=[dic objectForKey:@"couponsDesc"];
        CGSize size;
        if (couponsDesc==[NSNull null]) {
            size=CGSizeMake(0, 0);
        }else
        {
            size=[self boundWithSize:CGSizeMake(_width*0.9, 0) WithString:couponsDesc WithFont:[UIFont systemFontOfSize:14]];

        }
        return 125+size.height+10;

    }else
    {
        return _width*0.32;
    }

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];




    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    if (_currentBTn.tag==2) {

        cell.textLabel.textColor=[UIColor darkGrayColor];
        cell.textLabel.font=[UIFont systemFontOfSize:16];

        UILabel*xiang_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.4, 0, _width*0.6, 60)];

        xiang_L.textAlignment=NSTextAlignmentLeft;
        xiang_L.textColor=[UIColor grayColor];
        xiang_L.font=[UIFont italicSystemFontOfSize:15];
        xiang_L.numberOfLines=0;
        [cell.contentView addSubview:xiang_L];


        if (indexPath.row==0) {
            cell.textLabel.text=@"店名";

            xiang_L.text=_shopName;

        }
        if (indexPath.row==1) {
            cell.textLabel.text=@"商铺介绍";
            xiang_L.text=_shopDesc;

            CGSize size=[self boundWithSize:CGSizeMake(_width*0.6, 0) WithString:_shopDesc WithFont:[UIFont italicSystemFontOfSize:15]];
            if (size.height+20<60) {
                xiang_L.frame=CGRectMake(_width*0.4, 0, _width*0.6, 60);
            }else
            {
                xiang_L.frame=CGRectMake(_width*0.4, 0, _width*0.6, size.height+20);
            }
        }
        if (indexPath.row==2) {
            cell.textLabel.text=@"位置";
            cell.imageView.image=[UIImage imageNamed:@"dingwei"];

            xiang_L.text=_shopAddress;
        }
        if (indexPath.row==3) {
            cell.textLabel.text=@"电话";
            cell.imageView.image=[UIImage imageNamed:@"dianhua"];
            xiang_L.text=_phoneNumber;
        }


    }
    if (_currentBTn.tag==0) {
        NSDictionary*dic=[_dataArray objectAtIndex:indexPath.row];

        NSString*pro_image=[dic objectForKey:@"productImage"];
        NSString*pro_name=[dic objectForKey:@"productName"];
        NSString*pro_price=[dic objectForKey:@"ratePrice"];
        //NSString*categoryName=[dic objectForKey:@"categoryName"];
       // NSString*productSubName=[dic objectForKey:@"productSubName"];


        cell.selectionStyle=UITableViewCellSelectionStyleNone;

        UIImageView*doct=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.02, _width*0.025, _width*0.35, _width*0.27)];
        [doct sd_setImageWithURL:[NSURL URLWithString:pro_image] placeholderImage:[UIImage imageNamed:@"chang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

        }];

        doct.clipsToBounds=YES;
        doct.layer.cornerRadius=5;
        [cell.contentView addSubview:doct];


        UILabel*name_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.4, _width*0.03, _width*0.68, _width*0.15)];
        name_L.text=pro_name;
        name_L.numberOfLines=0;
        name_L.textAlignment=NSTextAlignmentLeft;
        name_L.textColor=[UIColor darkGrayColor];
        name_L.font=[UIFont boldSystemFontOfSize:17];
        [cell.contentView addSubview:name_L];


        UILabel*price_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.4, _width*0.18, _width*0.55, _width*0.09)];
         price_L.text=[NSString stringWithFormat:@"￥%.2f",[pro_price doubleValue]];
        price_L.numberOfLines=1;
        price_L.textAlignment=NSTextAlignmentLeft;
        price_L.textColor=[UIColor redColor];
        price_L.font=[UIFont systemFontOfSize:15];
        [cell.contentView addSubview:price_L];
    }

    chargeListCell*cell_1=[[chargeListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell_1"];
    cell_1.selectionStyle=UITableViewCellSelectionStyleNone;
    if (_currentBTn.tag==1) {

        NSDictionary*dic=[_dataArray objectAtIndex:indexPath.section];

        cell_1.shopName.text=@"已发布优惠劵";
        cell_1.shopName.frame=CGRectMake(_width*0.05, 0, _width*0.6, 50);

        cell_1.chargeName.text=[dic objectForKey:@"couponsTitle"];

        cell_1.receiveBtn.tag=[[dic objectForKey:@"couponsId"] integerValue];
        if (USERID!=nil) {
            cell_1.receiveBtn.hidden=NO;
            [cell_1.receiveBtn addTarget:self action:@selector(receiveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            id  isget=[dic objectForKey:@"isGet"];
            if (isget==[NSNull null]) {

            }else
            {
                if ([isget intValue]==1) {
                    [cell_1.receiveBtn setTitle:@"已领取" forState:UIControlStateNormal];
                    [cell_1.receiveBtn setBackgroundColor:[UIColor grayColor]];
                    cell_1.receiveBtn.userInteractionEnabled=NO;
                }

            }


        }else
        {
            cell_1.receiveBtn.hidden=YES;
        }

        NSString*startStr=[[dic objectForKey:@"startTime"] substringToIndex:10];
        NSString*endStr=[[dic objectForKey:@"endTime"] substringToIndex:10];
        cell_1.endTime.text=[NSString stringWithFormat:@"使用日期：%@至%@",startStr,endStr];

        cell_1.chargePrice.text=[NSString stringWithFormat:@"满%@元立减%@元",[dic objectForKey:@"setTotal"],[dic objectForKey:@"denomination"]];


        id  couponsDesc=[dic objectForKey:@"couponsDesc"];
        
        if (couponsDesc==[NSNull null]) {
            
        }else
        {
            
            CGSize size=[self boundWithSize:CGSizeMake(_width*0.9, 0) WithString:couponsDesc WithFont:[UIFont systemFontOfSize:14]];
            cell_1.couponsDesc.frame=CGRectMake(_width*0.03, 125, _width*0.94, size.height);
            cell_1.couponsDesc.text=couponsDesc;
            cell_1.couponsDesc.numberOfLines=0;
            
        }


    }
    if (_currentBTn.tag==1) {
        return cell_1;
    }else
    {
        return cell;
    }


}
-(void)receiveBtnClick:(UIButton*)btn
{
    NSLog(@"-+的顶顶顶顶顶++");


    if (USERID!=nil) {

        [requestData getData:RECEIVE_COUPONS_URL(USERID, (int)btn.tag) complete:^(NSDictionary *dic) {
            NSLog(@"-++++++%@",dic);
            if ([[dic objectForKey:@"flag"] intValue]==1) {
                MISSINGVIEW
                missing_v.tishi=[NSString stringWithFormat:@"%@",[dic objectForKey:@"info"]];
                                ALERT([dic objectForKey:@"info"]);
                [btn setTitle:@"已领取" forState:UIControlStateNormal];
//                [btn setBackgroundColor:[UIColor grayColor]];
            }else
            {
                MISSINGVIEW
                missing_v.tishi=[NSString stringWithFormat:@"%@",[dic objectForKey:@"info"]];
                                 ALERT([dic objectForKey:@"info"]);

            }

        }];
    }else
    {
        ALLOC(logInVC)
        [self presentViewController:vc animated:YES completion:^{
            
        }] ;
        
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_currentBTn.tag==2) {

        if (indexPath.row==3) {
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_phoneNumber];
             UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.view addSubview:callWebview];
        }

    }
    if (_currentBTn.tag==0) {
        NSDictionary*dic=[_dataArray objectAtIndex:indexPath.row];
        NSString*pro_id=[dic objectForKey:@"productId"];
        PUSH(productVC)
        vc.productId=pro_id;
    }


    
}
-(void)backClick
{
    
    self.tabBarController.tabBar.hidden=YES;

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
