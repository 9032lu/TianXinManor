//
//  chargeListVC.m
//  logRegister
//
//  Created by apple on 15-1-27.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "chargeListVC.h"

#import "UIImageView+WebCache.h"
#import "chargeListCell.h"
#import "danLi.h"
#import "logInVC.h"
@interface chargeListVC ()

@end

@implementation chargeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN
     TOP_VIEW(@"个人优惠劵")
   
//    use_dataArray=[[NSMutableArray alloc]init];
//    notuse_dataArray=[[NSMutableArray alloc]init];

//    danLi *myapp=[[danLi alloc]init];

    NSArray*title_a=@[@"可用优惠券",@"历史优惠券"];
    if ([self.whoPush isEqualToString:@"user"]) {
        for (int i=0; i<2; i++) {
            UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=CGRectMake(_width*0.5*i, 64, _width*0.5, 50);

            [button setTitle:[title_a objectAtIndex:i] forState:UIControlStateNormal];
            if (i==0) {
                _lastBtn=button;
                [button setTitleColor:APP_ClOUR forState:UIControlStateNormal];
                //
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

    }
//    [self selectBtnClick:(UIButton*)[self .view viewWithTag:0]];

    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64) style:UITableViewStyleGrouped];
    if ([self.whoPush isEqualToString:@"user"]) {
        _tableView.frame = CGRectMake(0, 64+50, _width, _height-64-50);
    }
    _tableView.bounces=YES;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    desc_H=0;

    _refesh=[SDRefreshHeaderView refreshView];
    __block chargeListVC*blockSelf=self;
    [_refesh addToScrollView:_tableView];

    _refesh.beginRefreshingOperation=^{
        [blockSelf getdata];


    };
    _refesh.isEffectedByNavigationController=NO;


    _refeshDown=[SDRefreshFooterView refreshView];
    [_refeshDown addToScrollView:_tableView];

    _refeshDown.beginRefreshingOperation=^{
        [blockSelf getdata];
        
        
    };


}
-(void)getdata
{


    UIImageView*iv=(UIImageView*)[_tableView viewWithTag:22222];
    UILabel*la=(UILabel*)[_tableView viewWithTag:222222];
    [iv removeFromSuperview];
    [la removeFromSuperview];
    LOADVIEW

    _dataArray=[[NSMutableArray alloc]init];

    if ([self.whoPush isEqualToString:@"user" ]) {

        [requestData getData:ASK_USER_COUPONS_URL(USERID) complete:^(NSDictionary *dic) {
            LOADREMOVE
            NSLog(@"%@",ASK_USER_COUPONS_URL(USERID));
            [_refesh endRefreshing];
            [_refeshDown endRefreshing];
            _basedataArray=[dic objectForKeyedSubscript:@"data"];



            for (NSDictionary *dic  in _basedataArray){
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

                NSDate *enddateString = [dateFormatter dateFromString:dic[@"endTime"]];

                NSDate *nowdate = [NSDate date];

                CGFloat different1 = [enddateString timeIntervalSinceDate:nowdate];
                    NSInteger isUse =[dic[@"isUse"] integerValue];
                if (isuser==YES) {
                    if (different1 >0 && isUse==0) {
                        [_dataArray addObject:dic];
                    }

                }else{
                    if (different1 < 0 || isUse==1) {
                        [_dataArray addObject:dic];
                    }

                }


            }
            [_tableView reloadData];

            if (_dataArray.count==0) {
                UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, (_height-260)/2, 50,50)];
                tanhao.image=[UIImage imageNamed:@"tanhao"];
                [_tableView addSubview:tanhao];

                UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (_height-260)/2+60, _width, 20)];
                tishi.text=@"你还没有优惠劵，赶快去领取吧..";
                tishi.textColor=[UIColor grayColor];
                tishi.textAlignment=NSTextAlignmentCenter;
                tishi.font=[UIFont systemFontOfSize:14];
                [_tableView addSubview:tishi];

                tanhao.tag=22222;
                tishi.tag=222222;
            }
        }];

    }else if ([self.whoPush isEqualToString:@"shouye" ])
    {


        NSString*url;
        if (USERID==nil) {
            url=ASK_COUPONS_URL;
        }else
        {
            url=[NSString stringWithFormat:@"%@&userId=%@",ASK_COUPONS_URL,USERID];

        }
        [requestData getData:url complete:^(NSDictionary *dic) {
            NSLog(@"%@",url);
            LOADREMOVE
            [_refesh endRefreshing];
            [_refeshDown endRefreshing];

            _dataArray=[dic objectForKeyedSubscript:@"data"];
            [_tableView reloadData];

            if (_dataArray.count==0) {
                UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, (_height-260)/2, 50,50)];
                tanhao.image=[UIImage imageNamed:@"tanhao"];
                [_tableView addSubview:tanhao];

                UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (_height-260)/2+60, _width, 20)];
                tishi.text=@"还没有优惠券可领取..";
                tishi.textColor=[UIColor grayColor];
                tishi.textAlignment=NSTextAlignmentCenter;
                tishi.font=[UIFont systemFontOfSize:14];
                [_tableView addSubview:tishi];

                tanhao.tag=22222;
                tishi.tag=222222;
            }
        }];
        TOP_VIEW(@"优惠劵列表")
    }else
    {
        NSLog(@"%@",ASK_RELEAT_COUPONS_URL(USERID,[self.shopId intValue], [self.totalPrice doubleValue]));
        [_refesh endRefreshing];
        [_refeshDown endRefreshing];

        [requestData getData:ASK_RELEAT_COUPONS_URL(USERID,[self.shopId intValue], [self.totalPrice doubleValue]) complete:^(NSDictionary *dic) {
            LOADREMOVE
            //NSLog(@"%@",dic);
            BOOL flag=(BOOL)[dic objectForKey:@"flag"];
            if (flag) {
                _dataArray=[dic objectForKey:@"data"];
                [_tableView reloadData];

                if (_dataArray.count==0) {
                    UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, (_height-260)/2, 50,50)];
                    tanhao.image=[UIImage imageNamed:@"tanhao"];
                    [_tableView addSubview:tanhao];

                    UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (_height-260)/2+60, _width, 20)];
                    tishi.text=@"没有可用优惠劵..";
                    tishi.textColor=[UIColor grayColor];
                    tishi.textAlignment=NSTextAlignmentCenter;
                    tishi.font=[UIFont systemFontOfSize:14];
                    [_tableView addSubview:tishi];
                    tanhao.tag=22222;
                    tishi.tag=222222;
                }

            }else
            {
                
            }
            
        }];
        TOP_VIEW(@"选择优惠劵")
        
        
    }
    


    [_tableView reloadData];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

        NSLog(@"进来");

//    danLi*myapp=[[danLi alloc]init];
//    myapp.couponsDic=[_dataArray objectAtIndex:indexPath.section];
//    NSLog(@"%@",myapp.couponsDic);

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
  if([self.whoPush isEqualToString:@"order"])
    {

        NSLog(@"---isuser-----%d===%@",isuser,[_dataArray objectAtIndex:indexPath.section]);
        if (isuser) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"coup" object:nil userInfo:@{@"coup":[_dataArray objectAtIndex:indexPath.section]}];
            
            POP
        }else{
            MISSINGVIEW
            missing_v.tishi = @"该优惠券已失效！！";
        }


    }else{

    }



//    [_tableView reloadData];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    chargeListCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[chargeListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }

    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    NSDictionary*dic=[_dataArray objectAtIndex:indexPath.section];
    cell.shopLogo.hidden = YES;
    cell.shopName.hidden= YES;
    cell.kuang.hidden= YES;
   // NSLog(@"%@",dic);
//    id shopId=[dic objectForKey:@"shopId"];


//    if (shopId==[NSNull null]||[shopId intValue]==0) {
//            cell.shopLogo.image=[UIImage imageNamed:@"1024.png"] ;
//           // cell.shopName.frame=CGRectMake(_width*0.05, 0, _width*0.6, 50);
//            cell.shopName.text=@"重庆餐饮";
//            cell.chargeName.text=[dic objectForKey:@"couponsTitle"];
//
//    }else
//    {
//        id shopNmae=[dic objectForKey:@"shopName"];
//        if (shopNmae==[NSNull null]) {
//            shopNmae=@"";
//        }else
//        {
//            shopNmae=[NSString stringWithFormat:@"%@",shopNmae];
//        }
//        //NSLog(@"%@--%@",[dic objectForKey:@"shopName"],[dic objectForKey:@"couponsTitle"]);
//        id  shopLogo=[dic objectForKey:@"shopLogo"];
//
//        cell.shopName.text=shopNmae;
//        if (shopLogo==[NSNull null]) {
//
//        }else
//        {
//            [cell.shopLogo sd_setImageWithURL:[NSURL URLWithString:shopLogo] placeholderImage:[UIImage imageNamed:@"fang"] completed:nil];
//        }
//
//        cell.chargeName.text=[dic objectForKey:@"couponsTitle"];
//
//
//
//    }
    UIImageView *backImg= [[UIImageView alloc]initWithFrame:CGRectMake(_width*0.03, _width*0.05, _width*0.94, _width*0.25)];

    id  image=[dic objectForKey:@"couponsPath"];
    if (image==[NSNull null]||image==nil) {
        image=@"";
    }
    [backImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",image]] placeholderImage:[UIImage imageNamed:@"未标题-1(6)"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image ==nil) {
            backImg.image= [UIImage imageNamed:@"未标题-1(6)"];
        }


    }];
    backImg.userInteractionEnabled = YES;
    [cell.contentView addSubview:backImg];

    UILabel *imgLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 10, 20, 15)];
    imgLab.text = @"￥";
    imgLab.textColor = [UIColor whiteColor];
    imgLab.font =[UIFont boldSystemFontOfSize:17];
    [backImg addSubview:imgLab];

    UILabel *priceLab = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.055,0, _width*0.3, _width*0.25)];
    priceLab.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"denomination"]];
    priceLab.textColor = [UIColor whiteColor];
    priceLab.font =[UIFont boldSystemFontOfSize:50];
    [backImg addSubview:priceLab];

    cell.chargeName.textColor = [UIColor whiteColor];
    cell.chargeName.font =[UIFont boldSystemFontOfSize:16];
//    _chargeName=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.03, 50, _width*0.9, 25)];
//    cell.chargeName.bounds = CGRectMake(0, 0, _width*0.5, 25);
//    cell.chargeName.center = CGPointMake(_width*0.5, 62);
    cell.chargeName.textAlignment = NSTextAlignmentCenter;
    cell.chargeName.text=[dic objectForKey:@"couponsTitle"];
//    CGSize size0=[self boundWithSize:CGSizeMake(_width*0.9, 0) WithString:cell.chargeName.text WithFont:[UIFont boldSystemFontOfSize:16]];

    cell.chargeName.frame = CGRectMake(_width*0.3, 5,_width*0.43, 20);
    [backImg addSubview:cell.chargeName];


    cell.chargePrice.text=[NSString stringWithFormat:@"购满%@元使用",[dic objectForKey:@"setTotal"]];
    cell.chargePrice.textColor = [UIColor orangeColor];
    cell.chargePrice.font =[UIFont systemFontOfSize:15];
        CGSize size1=[self boundWithSize:CGSizeMake(_width*0.9, 0) WithString:cell.chargePrice.text WithFont:[UIFont systemFontOfSize:15]];

    cell.chargePrice.bounds=CGRectMake(0, 0, size1.width, 15);
    cell.chargePrice.center= CGPointMake(_width/2, _width*0.125);
    cell.chargePrice.backgroundColor = [UIColor whiteColor];
    [backImg addSubview:cell.chargePrice];



    NSString*startStr=[[dic objectForKey:@"startTime"] substringWithRange:NSMakeRange(5,5)];
    NSString*endStr=[[dic objectForKey:@"endTime"] substringWithRange:NSMakeRange(5,5)];
    cell.endTime.text=[NSString stringWithFormat:@"使用日期：%@至%@",startStr,endStr];
    cell.endTime.textColor = [UIColor whiteColor];
    cell.endTime.font = [UIFont systemFontOfSize:12];
    cell.endTime.textAlignment = NSTextAlignmentCenter;
    cell.endTime.center =CGPointMake(_width*0.5, _width*0.2);
    [backImg addSubview:cell.endTime];


    cell.receiveBtn.backgroundColor =[UIColor clearColor];
    cell.receiveBtn.frame = CGRectMake(_width*0.78, 0, _width*0.15, _width*0.25);
    cell.receiveBtn.titleLabel.numberOfLines = 2;
    cell.receiveBtn.titleLabel.font=[UIFont boldSystemFontOfSize:17];
    cell.receiveBtn.tag=[[dic objectForKey:@"couponsId"] integerValue];

    [backImg addSubview:cell.receiveBtn];

    if ([self.whoPush isEqualToString:@"shouye"]) {
        cell.receiveBtn.hidden=NO;
//        NSLog(@"-------");
        [cell.receiveBtn addTarget:self action:@selector(receiveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        id  isget=[dic objectForKey:@"isGet"];
        if (isget==[NSNull null]) {

        }else
        {
            if ([isget intValue]==1) {
                [cell.receiveBtn setTitle:@"已领取" forState:UIControlStateNormal];
                cell.receiveBtn.titleLabel.font=[UIFont boldSystemFontOfSize:15];

                [cell.receiveBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            }else{
                [cell.receiveBtn setTitle:@"立即领取" forState:UIControlStateNormal];
                cell.receiveBtn.titleLabel.font=[UIFont boldSystemFontOfSize:17];


            }
        }


    }else  if ([self.whoPush isEqualToString:@"user" ]){
        cell.receiveBtn.userInteractionEnabled=NO;

//        NSLog(@"++++++++%ld==%@===%d",(long)_lastBtn.tag,dic[@"isUse"],isuser);
        if (isuser) {

                [cell.receiveBtn setTitle:@"立即使用" forState:UIControlStateNormal];
            cell.receiveBtn.titleLabel.font=[UIFont boldSystemFontOfSize:17];


        }else{
            if (_lastBtn.tag==1) {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

                NSDate *enddateString = [dateFormatter dateFromString:dic[@"endTime"]];

                NSDate *nowdate = [NSDate date];

                CGFloat different1 = [enddateString timeIntervalSinceDate:nowdate];
                NSInteger isUse =[dic[@"isUse"] integerValue];
                if (isUse ==1) {
                    [cell.receiveBtn setTitle:@"已使用" forState:UIControlStateNormal];
                    cell.receiveBtn.titleLabel.font=[UIFont boldSystemFontOfSize:15];

                    [cell.receiveBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];

                }else if (different1<0) {
                    [cell.receiveBtn setTitle:@"已过期" forState:UIControlStateNormal];
                    cell.receiveBtn.titleLabel.font=[UIFont boldSystemFontOfSize:15];

                    [cell.receiveBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];

                }

            }            }


        }


//        }

//    {
//        cell.receiveBtn.hidden=YES;
//    }
//


//
   //
//    cell.chargePrice.text=[NSString stringWithFormat:@"满%@元立减%@元",[dic objectForKey:@"setTotal"],[dic objectForKey:@"denomination"]];
//    if ([self.whoPush isEqualToString:@"user"]) {
//
//    }

//    id  couponsDesc=[dic objectForKey:@"couponsDesc"];
//
//    if (couponsDesc==[NSNull null]) {
//
//    }else
//    {
//
//        CGSize size=[self boundWithSize:CGSizeMake(_width*0.9, 0) WithString:couponsDesc WithFont:[UIFont systemFontOfSize:14]];
//        cell.couponsDesc.frame=CGRectMake(_width*0.03, 125, _width*0.94, size.height);
//        cell.couponsDesc.text=couponsDesc;
//        cell.couponsDesc.numberOfLines=0;
//
//    }



    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

//    NSDictionary*dic=[_dataArray objectAtIndex:indexPath.section];
//    id  couponsDesc=[dic objectForKey:@"couponsDesc"];
//    CGSize size;
//    if (couponsDesc==[NSNull null]) {
//        size=CGSizeMake(0, 0);
//
//
//    }else
//    {
//
//        size=[self boundWithSize:CGSizeMake(_width*0.9, 0) WithString:couponsDesc WithFont:[UIFont systemFontOfSize:14]];
//
//        
//    }
//    return 125+size.height+10;

    return _width*0.35;


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
-(void)receiveBtnClick:(UIButton*)btn
{
    if (USERID!=nil) {

        [requestData getData:RECEIVE_COUPONS_URL(USERID, (int)btn.tag) complete:^(NSDictionary *dic) {
//            NSLog(@"%@",dic);
            if ([[dic objectForKey:@"flag"] intValue]==1) {
                MISSINGVIEW
                missing_v.tishi=[NSString stringWithFormat:@"%@",[dic objectForKey:@"info"]];
//                ALERT([dic objectForKey:@"info"]);
                [btn setTitle:@"已领取" forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];

//                [btn setBackgroundColor:[UIColor grayColor]];
            }else
            {
                MISSINGVIEW
                missing_v.tishi=[NSString stringWithFormat:@"%@",[dic objectForKey:@"info"]];
//                 ALERT([dic objectForKey:@"info"]);

            }

        }];
    }else
    {
        ALLOC(logInVC)
        [self presentViewController:vc animated:YES completion:^{

        }] ;
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 15;
    }else
    {
        return 7.5;

    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 7.5;
}
 
-(void)backClick
{
    if ([self.whoPush isEqualToString:@"shouye"]) {
        self.tabBarController.tabBar.hidden=YES;
    }else if ([self.whoPush isEqualToString:@"user"])
    {
        self.tabBarController.tabBar.hidden=YES;

    }
    POP
}

-(void)selectBtnClick:(UIButton*)button
{

    UIImageView*iv=(UIImageView*)[_tableView viewWithTag:22222];
    UILabel*la=(UILabel*)[_tableView viewWithTag:222222];
    [iv removeFromSuperview];
    [la removeFromSuperview];

    [_dataArray removeAllObjects];
    if (_lastBtn==button) {

    }else
    {
        [button setTitleColor:APP_ClOUR forState:UIControlStateNormal];
        [_lastBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

           }

    for (NSDictionary *dic  in _basedataArray) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

        NSDate *enddateString = [dateFormatter dateFromString:dic[@"endTime"]];

        NSDate *nowdate = [NSDate date];

        CGFloat different1 = [enddateString timeIntervalSinceDate:nowdate];
        NSInteger isUse =[dic[@"isUse"]integerValue];
        NSLog(@"-------%f",different1);

        if (button.tag ==0) {
            isuser = YES;

            if (different1 >0 &&isUse ==0) {
                [_dataArray addObject:dic];
            }

        }else if(button.tag ==1){
            isuser = NO;

            if (different1 <0||isUse==1) {
                [_dataArray addObject:dic];
            }

        }

    }
       if (_dataArray.count==0) {
        UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, (_height-260)/2, 50,50)];
        tanhao.image=[UIImage imageNamed:@"tanhao"];
        [_tableView addSubview:tanhao];

        UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (_height-260)/2+60, _width, 20)];
        if (button.tag ==1) {
            tishi.text=@"没有过期或未使用的优惠券！";

        }else
        tishi.text=@"你还没有优惠劵，赶快去领取吧..";
        tishi.textColor=[UIColor grayColor];
        tishi.textAlignment=NSTextAlignmentCenter;
        tishi.font=[UIFont systemFontOfSize:14];
        [_tableView addSubview:tishi];

        tanhao.tag=22222;
        tishi.tag=222222;
    }

    _lastBtn=button;
    [_tableView reloadData];
    

}


-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=YES;
    [super viewWillAppear:animated];
     [self getdata];
    isuser = YES;

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
