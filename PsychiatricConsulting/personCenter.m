//
//  personCenter.m
//  ShengMengShangmao
//
//  Created by apple on 15-3-26.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "personCenter.h"

#import "logInVC.h"
#import "sheZhiVC.h"
#import "myAdressVC.h"
#import "chargeListVC.h"
#import "productCollectVC.h"
#import "setUserInfoVC.h"
#import "adviceVC.h"
#import "scoreVC.h"
#import "myOrderVC.h"
#import "newsVC.h"
#import "orderlistVC.h"
#import "jifenListVC.h"
#import "shopCarVC.h"
#import "setAboutVC.h"
#import "myButton.h"
#import "pubStoryVC.h"
#import "homePage.h"
#import "webViewVC.h"
#import "setScoreVC.h"
#import "PostSale.h"
@interface personCenter ()

@end

@implementation personCenter

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    TOP_VIEW(@"个人中心")
    backBtn.hidden=NO;

    NSLog(@"-个人中心-%@",self.navigationController.viewControllers);
//    NSDate *nowDate = [NSDate date];
//    NSLog(@"date===%@",nowDate);

//    waitArray =[NSArray arrayWithObjects:@"待付款",@"待发货",@"待收货",@"待评价", nil];

//    NSDate *today = [NSDate date];
//    NSString *weekday = [NSString stringWithFormat:@"%@     签到",[requestData weekdayStringFromDate:today]];
//
//
//    waitArray =[NSArray arrayWithObjects:weekday,@"发布话题", nil];


    
    self.navigationController.navigationBar.hidden=YES;
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64)];
    _scrollView.bounces=YES;
    _scrollView.delegate=self;
    _scrollView.scrollEnabled=YES;
    [self.view addSubview:_scrollView];

    _bg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _width, 125)];
    _bg.image=[UIImage imageNamed:@"buyer_center_top_bg"];
    [_scrollView addSubview:_bg];

    _userHead=[UIButton buttonWithType:UIButtonTypeCustom];
    _userHead.frame=CGRectMake((_width-65)/2, 5, 65, 65);

    _userHead.layer.cornerRadius=32.5;
    _userHead.clipsToBounds=YES;



    _userHead.backgroundColor=[UIColor grayColor];
    _userHead.layer.borderColor=[UIColor whiteColor].CGColor;
    _userHead.layer.borderWidth=3;
    [_userHead sd_setBackgroundImageWithURL:nil forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"userFace"]];

    [_userHead addTarget:self action:@selector(userHead) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_userHead];

    _userName=[[UILabel alloc]initWithFrame:CGRectMake(0,70, _width, 25)];

    _userName.textAlignment=NSTextAlignmentCenter;
    _userName.textColor=[UIColor whiteColor];
    _userName.font=[UIFont boldSystemFontOfSize:14];
    [_scrollView addSubview:_userName];



    _userScore=[[UILabel alloc]initWithFrame:CGRectMake(_width*(0.35-0.12), 95, _width*0.45, 25)];
    _userScore.textAlignment=NSTextAlignmentLeft;
    _userScore.text=[NSString stringWithFormat:@"积分:%@",@"0"];
    _userScore.textColor=[UIColor whiteColor];
    _userScore.font=[UIFont systemFontOfSize:13];
    [_scrollView addSubview:_userScore];

    _dengji=[[UILabel alloc]initWithFrame:CGRectMake(_width*(0.57-0.12)-5, 95, _width*0.45, 25)];
    _dengji.textAlignment=NSTextAlignmentLeft;
    _dengji.text=[NSString stringWithFormat:@"%@",@"0"];
    _dengji.textColor=[UIColor yellowColor];
    _dengji.font=[UIFont systemFontOfSize:13];
    [_scrollView addSubview:_dengji];



    _userRank=[[UILabel alloc]initWithFrame:CGRectMake(_width*(0.6-0.095)+32, 97.5, _width*0.17, 20)];
    _userRank.textAlignment=NSTextAlignmentCenter;
    _userRank.text=[NSString stringWithFormat:@"年龄:%@",@23];
    _userRank.textColor=[UIColor whiteColor];
//    _userRank.backgroundColor=APP_ClOUR;
//    _userRank.layer.cornerRadius=3;
//    _userRank.clipsToBounds=YES;
    _userRank.font=[UIFont systemFontOfSize:13];
    [_scrollView addSubview:_userRank];

    UIView*hengxian=[[UIView alloc]initWithFrame:CGRectMake(0, 125, _width, 1)];
    hengxian.backgroundColor=RGB(234, 234, 234);
    [_scrollView addSubview:hengxian];


    for (int i=0; i<3; i++) {
        UIButton*_url_btn=[UIButton buttonWithType:UIButtonTypeCustom];
        _url_btn.frame=CGRectMake(_width/3*i, 125, _width/3, 70);

        [_url_btn setTitleColor:RGB(100, 100, 100) forState:UIControlStateNormal];
        [_url_btn addTarget:self action:@selector(manageWeb:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake((_width/3-30)/2, 8, 30, 30)];
        [_url_btn addSubview:imageview];
        UILabel*label_n=[[UILabel alloc]initWithFrame:CGRectMake(0, 45, _width/3, 20)];
        label_n.textAlignment=NSTextAlignmentCenter;
        label_n.textColor=[UIColor blackColor];
        label_n.font=[UIFont systemFontOfSize:14];
        [_url_btn addSubview:label_n];

        if (i==0) {
           label_n.text=@"积分乐园";
            imageview.image=[UIImage imageNamed:@"d4"];

        }
        if (i==1) {
            label_n.text=@"我的关注";
            imageview.image=[UIImage imageNamed:@"d2"];


        }
        if (i==2) {
            label_n.text=@"优 惠 劵";
            imageview.image=[UIImage imageNamed:@"d3"];

        }

        _url_btn.tag=i;

        if (i==0||i==1) {
            UIView*shuxian=[[UIView alloc]initWithFrame:CGRectMake(_width/3*(i+1),135, 1, 50)];
            shuxian.backgroundColor=RGB(234, 234, 234);
            [_scrollView addSubview:shuxian];
        }
     //   [_url_btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
//        _url_btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
        _url_btn.titleLabel.font=[UIFont boldSystemFontOfSize:14];

        [_scrollView addSubview:_url_btn];
    }
    




    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 195, _width, _height-64) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [_tableView setSeparatorInset:UIEdgeInsetsZero];
    _tableView.rowHeight=45;
    _tableView.scrollEnabled=NO;
    //_tableView.separatorColor=[UIColor clearColor];
    [_scrollView addSubview:_tableView];
    _scrollView.contentSize=CGSizeMake(_width, 623);


//    _downwardView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64+50, _width, 1)];
//    _downwardView.scrollEnabled=YES;
//    _downwardView.backgroundColor=RGB(247, 247, 247);
//    _downwardView.bounces=NO;


    [self getcount];


}
-(void)manageWeb:(UIButton*)button
{
    if (USERID==nil) {
        ALLOC(logInVC)
        [self presentViewController:vc animated:NO completion:^{

        }];
    }else
    {
        if (button.tag==0) {

            PUSH(scoreVC)

        }
        if (button.tag==2) {
            PUSH(chargeListVC)
            vc.whoPush=@"user";
        }
        if (button.tag==1) {
            PUSH(productCollectVC)
        }
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0 &&indexPath.row==0) {
        if (USERID==nil) {
            return 0.1;
        }else

        return 30;
    }else if (indexPath.section==0 &&indexPath.row==1) {
        if (USERID==nil) {
            return 0.1;
        }else
        return 40;
    }else if(indexPath.section==1&&indexPath.row==1){
        return 55;
    }else
    {

        return 45;
    }


}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==3) {
        return 3;
    }else
    {
        return 2;

    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        if (USERID ==nil) {
            return 0.1;
        }else
        return 15;
    }else
    {
        return 0.1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 0.1;
    }else{
        return 10;

    }
}
-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);

    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];

    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return scaledImage;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }

//    cell.imageView.bounds = CGRectMake(0, 0 , 30, 30);
//    cell.imageView.center =CGPointMake(20, cell.center.y);

    if (indexPath.section==0) {
        if (USERID !=nil) {
            if (indexPath.row==1) {
                [cell.contentView addSubview:selectImg];
                for (int i = 0; i <2; i ++) {
                    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(_width/2*i, 0, _width/2 , 40)];
                    if (i==0) {
                        UIView *backVW = [[UIView alloc]initWithFrame:CGRectMake(2, 0, _width*0.5-5, 40)];
                        backVW.backgroundColor =RGB(133,199,242);
//                        backVW.layer.cornerRadius = 5;
                        [cell.contentView addSubview:backVW];

                        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(_width*0.17, 5, _width*0.1, 30)];
                        image.image = [UIImage imageNamed:@"rili"];
                        [cell.contentView addSubview:image];
                        UILabel *lable = [[UILabel alloc]initWithFrame:image.frame];
                        NSDate *today = [NSDate date];
                        NSString *weekday = [NSString stringWithFormat:@"%@",[requestData weekdayStringFromDate:today]];
                        lable.font =[UIFont systemFontOfSize:14];
                        lable.textColor = [UIColor blackColor];
                        lable.text =weekday;
                        lable.textAlignment = NSTextAlignmentCenter;
                        [cell.contentView addSubview:lable];
                        
                        selectImg = [[UIButton alloc]initWithFrame:CGRectMake(_width*0.275, 5, _width*0.09, 30)];
                        selectImg.titleLabel.font = [UIFont systemFontOfSize:14];
                        [selectImg setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                        [cell.contentView addSubview:selectImg];

                    }
                    if (i==1) {
                        [button setTitle:@"发布话题" forState:UIControlStateNormal];

                        UIView *backVW = [[UIView alloc]init];
                        backVW.frame = CGRectMake(_width*0.5-2, 0, _width*0.5, 40);
//                    backVW.bounds = CGRectMake(0, 0, _width*0.24, 40);
//                        backVW.center = CGPointMake(_width*3/4, 20);
                        backVW.backgroundColor =RGB(133,199,242);
//                        backVW.layer.cornerRadius = 5;
                        [cell.contentView addSubview:backVW];


                    }else{

//                        NSLog(@"*********%@",SignedOrNot);
                        if ([SignedOrNot[@"info"]isEqualToString:@"已签到"]) {
//                            NSLog(@"/////////////////////////////");
                            [selectImg setImage:[UIImage imageNamed:@"duihao"] forState:UIControlStateNormal];
                            selectImg.titleLabel.hidden = YES;

                        }else{
//                            NSLog(@"/++++++++++++++++++++++++");

                            [selectImg setTitle:@"签到" forState:UIControlStateNormal];
                        }
//
                        [cell.contentView addSubview:selectImg];


                    }
                    button.titleLabel.font =[UIFont systemFontOfSize:16];
                    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
                    button.tag =i;
                    [button addTarget:self action:@selector(xialaBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:button];

                    if (i==0||i==1||i==2) {
                        UIView*shuxian=[[UIView alloc]initWithFrame:CGRectMake(_width/2*(i+1),5, 1, 30)];
                        shuxian.backgroundColor=RGB(234, 234, 234);
                        [cell.contentView addSubview:shuxian];
                    }
                }
                
                
            }
            if (indexPath.row==0) {
                cell.textLabel.text =@"今日任务";
                
            }
        }



    }else if(indexPath.section==1)
    {
        if (indexPath.row==0) {
            cell.imageView.image=[UIImage imageNamed:@"d7"];
            cell.textLabel.text=@"我的订单";
            cell.textLabel.font=[UIFont systemFontOfSize:14];
            cell.imageView.image=[self OriginImage:cell.imageView.image scaleToSize:CGSizeMake(20, 23.5)];

            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

               }
        if (indexPath.row ==1) {
            for (int i = 0; i <4; i++) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                button.frame = CGRectMake(i *_width/4, 0, _width/4, 50);
                button.tag = i;
                [button addTarget:self action:@selector(OrderSelect:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:button];


                UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake((_width/4-30)/2, 3, 30, 30)];
                [button addSubview:imageV];

                UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 33, _width/4, 17)];
                lable.font =[UIFont systemFontOfSize:10];
                lable.textColor = [UIColor darkGrayColor];
                lable.textAlignment = NSTextAlignmentCenter;
                [button addSubview:lable];


                UIButton*_redNumber=[UIButton buttonWithType:UIButtonTypeCustom];
                _redNumber.frame=CGRectMake((_width/4-30)/2+20, 0, 16, 16);
                [_redNumber setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                _redNumber.titleLabel.font=[UIFont systemFontOfSize:12];
                _redNumber.layer.cornerRadius=8;
                _redNumber.backgroundColor=[UIColor redColor];
                [button addSubview:_redNumber];

                if (i==0) {
                    lable.text=@"待付款";
                    imageV.image = [UIImage imageNamed:@"daifukuan"];
                    if ([fukuan integerValue]==0) {
                        _redNumber.hidden=YES;

                    }else
                    {
                        _redNumber.hidden=NO;

                        [_redNumber setTitle:fukuan forState:UIControlStateNormal];
                    }


                }
                if (i==1) {
                    lable.text=@"待收货";
                    imageV.image = [UIImage imageNamed:@"daishouhuo"];
                    if ([fahuo integerValue]==0) {
                        _redNumber.hidden=YES;

                    }else
                    {
                        _redNumber.hidden=NO;
                        [_redNumber setTitle:fahuo forState:UIControlStateNormal];
                    }

                }
                if (i==2) {
                    lable.text=@"待评论";
                    imageV.image = [UIImage imageNamed:@"daipingjia"];
                    if ([pinglun integerValue]==0) {
                        _redNumber.hidden=YES;

                    }else
                    {
                        _redNumber.hidden=NO;

                        [_redNumber setTitle:pinglun forState:UIControlStateNormal];
                    }

                }
                if (i==3) {
                    lable.text=@"退货/售后";
                    imageV.image = [UIImage imageNamed:@"tuihuoliebiao"];
//                    if ([pinglun integerValue]==0) {
//                        _redNumber.hidden=YES;
//
//                    }else
//                    {
                        _redNumber.hidden=YES;
//
//                        [_redNumber setTitle:pinglun forState:UIControlStateNormal];
//                    }

                }


                if (i==0||i==1||i==2) {
                    UIView*shuxian=[[UIView alloc]initWithFrame:CGRectMake(_width/4*(i+1),5, 1, 40)];
                    shuxian.backgroundColor=RGB(234, 234, 234);
                    [cell.contentView addSubview:shuxian];

                }

            }


        }



    }else if(indexPath.section ==2){
        if (indexPath.row==0) {

            cell.imageView.image=[UIImage imageNamed:@"d6"];
            cell.textLabel.text=@"我的预约";
        }
        if (indexPath.row==1) {

            cell.imageView.image=[UIImage imageNamed:@"d10"];
            cell.textLabel.text=@"购物车";
            
            
        }
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        cell.imageView.image=[self OriginImage:cell.imageView.image scaleToSize:CGSizeMake(20, 23.5)];

        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;


    }


    else if (indexPath.section==3){


        if (indexPath.row ==0) {
           cell.imageView.image=[UIImage imageNamed:@"d5"];
          cell.textLabel.text=@"积分明细";


        }
        if (indexPath.row==1) {
            cell.imageView.image=[UIImage imageNamed:@"d8"];
            cell.textLabel.text=@"收货地址";

        }else if (indexPath.row==2){
            cell.imageView.image=[UIImage imageNamed:@"d9"];
            cell.textLabel.text=@"设置";
        }

        cell.textLabel.font=[UIFont systemFontOfSize:14];
        cell.imageView.image=[self OriginImage:cell.imageView.image scaleToSize:CGSizeMake(20, 23.5)];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"section ==%ld==row ==%ld",(long)indexPath.section,(long)indexPath.row);
    if (USERID==nil) {
//        PUSH(logInVC)
        ALLOC(logInVC)
        [self presentViewController:vc animated:NO completion:^{

        }];
    }else
    {
        if (indexPath.section==1) {
            if (indexPath.row==0) {
                PUSH(orderlistVC)
                vc.orders=@"0";
            }

        }

        if (indexPath.section==2) {
            if (indexPath.row==0) {
            PUSH(myOrderVC)//我的预约
            }
            if (indexPath.row==1) {
                PUSH(shopCarVC)//购物车
                vc.whoPush=@"wode";

            }
//            if (indexPath.row==2) {
//                ALLOC(webViewVC)
//                vc.url=[NSString stringWithFormat:@"%@/setUp/memberPrivileges.action",BASE_URLL];
//                vc.whoPush =@"center";
//              [self presentViewController:vc animated:YES completion:^{
//
//              }];
//            if (indexPath.row==3) {
//                PUSH(setAboutVC)
//            }
//        }
        }


        if (indexPath.section==3) {
            if (indexPath.row==0) {
                PUSH(setScoreVC)
                vc.whopush = @"center";
                

            }else if (indexPath.row==1)
             {
                PUSH(myAdressVC)

            }else{
                PUSH(sheZhiVC)

            }
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
-(void)userHead
{
    //    if ([sendRequest LogInState]) {
    if (USERID==nil) {
//        PUSH(logInVC)
        ALLOC(logInVC)
        [self presentViewController:vc animated:NO completion:^{
        
        }];
    }else
    {
        PUSH(setUserInfoVC)
        self.tabBarController.tabBar.hidden=YES;

    }


}
-(void)getUserInfo
{

  //  NSLog(@"%@",USER_INFO);
    
    if (USERID==nil) {
        [_userHead setImage:[UIImage imageNamed:@"userFace"] forState:UIControlStateNormal];
        _userName.text=@"您还没有登录,点击头像登录！";
        _userScore.hidden=YES;
        _userRank.hidden=YES;
        _dengji.hidden=YES;
    }else
    {
        _userScore.hidden=NO;
        _userRank.hidden=NO;
        _dengji.hidden=NO;
        LOADVIEW
        [requestData getData:USER_INFO complete:^(NSDictionary *dic) {
            LOADREMOVE
             NSLog(@"----%@",dic);
            //ALERT([dic objectForKey:@"info"])

            NSDictionary*userDic=[dic objectForKey:@"data"];

//            if ([[userDic objectForKey:@"score"] isKindOfClass:[NSNull class]] ||[[userDic objectForKey:@"exp"] isKindOfClass:[NSNull class]]) {
//                _userScore.text=[NSString stringWithFormat:@"积分:%@",@""];
//
//                _dengji.text=[NSString stringWithFormat:@"%@",@"新星VIP"];
//            }else{
//                _userScore.text=[NSString stringWithFormat:@"积分:%@",[userDic objectForKey:@"score"]];
//                _dengji.text=[NSString stringWithFormat:@"%@",[userDic objectForKey:@"exp"]];
//            }

            _userScore.text=[NSString stringWithFormat:@"积分:%@",[self getTheNoNullStr:[userDic objectForKey:@"score"] andRepalceStr:@"0"]];
            _dengji.text=[NSString stringWithFormat:@"%@",[self getTheNoNullStr:[userDic objectForKey:@"exp"] andRepalceStr:@"新星VIP"]];





            id  birthDay=[userDic objectForKey:@"birthDay"];
            if (birthDay==[NSNull null]||[NSString stringWithFormat:@"%@",birthDay].length==0) {
                _userRank.text=[NSString stringWithFormat:@"年龄:%@",@"0"];
            }else{
                NSDateFormatter *dateform = [[NSDateFormatter alloc]init];
                [dateform setDateFormat:@"yyyy-MM-dd"];
                NSDate *birthDate = [dateform dateFromString:birthDay];

                NSTimeInterval dateDiff = [birthDate timeIntervalSinceNow];
                int age=trunc(-dateDiff/(60*60*24))/365;

                _userRank.text =[NSString stringWithFormat:@"年龄:%d",age];
            }


            id  score=[userDic objectForKey:@"score"];
            if (score==[NSNull null]||[NSString stringWithFormat:@"%@",score].length==0) {
             _userScore.text=[NSString stringWithFormat:@"积分:%@",@"0"];
            }

            id nickname=[userDic objectForKey:@"nickName"];
            if (nickname==[NSNull null]||[NSString stringWithFormat:@"%@",nickname].length==0) {

                _userName.text=[NSString stringWithFormat:@"%@",USERID];

            }
            else
            {
                [[NSUserDefaults standardUserDefaults] setObject:[userDic objectForKey:@"nickName"] forKey:@"nickName"];

                [[NSUserDefaults standardUserDefaults] synchronize];
                _userName.text=nickname;

            }
            id face=[userDic objectForKey:@"face"];
            if (face==[NSNull null]) {
                face=nil;
            }else{
                [[NSUserDefaults standardUserDefaults] setObject:[userDic objectForKey:@"face"] forKey:@"face"];

                [[NSUserDefaults standardUserDefaults] synchronize];
                
            }
//            [_userHead sd_setBackgroundImageWithURL:[NSURL URLWithString:face] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                if (image==nil) {
//                    [_userHead setImage:[UIImage imageNamed:@"userFace"] forState:UIControlStateNormal];
//                }
//            }];
            [_userHead sd_setBackgroundImageWithURL:[NSURL URLWithString:face] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"userFace"]];

        }];

    }

}
-(void)getcount
{


    [requestData getData:USER_CENTER_GETCOUNT(USERID) complete:^(NSDictionary *dic) {
        NSLog(@"--%@",USER_CENTER_GETCOUNT(USERID));

        fukuan=[NSString stringWithFormat:@"%@",[dic objectForKey:@"payment"]];
        fahuo=[NSString stringWithFormat:@"%@",[dic objectForKey:@"delivergoods"]];
        pinglun=[NSString stringWithFormat:@"%@",[dic objectForKey:@"comment"]];
//        tuikuang=[NSString stringWithFormat:@"%@",[dic objectForKey:@"comment"]];

        [_tableView reloadData];
        //NSLog(@"%@????????",fahuo);
           }];
    
}

//-(void)signDate{
//
//    NSDate *nowdate =[NSDate date];
//    NSString *nowStr = [[nowdate description]substringToIndex:10];
//    NSString *urlstr= [NSString stringWithFormat:@"%@/users/addscore.action?userId=%@&signInDate=%@",BASE_URLL,USERID,nowStr];
//    [requestData getData:urlstr complete:^(NSDictionary *dic) {
//        signDic = dic;
//        [self getUserInfo];
//        [self judgeSignedOrNot];
//        [_tableView reloadData];
//
//    }];
//}
//-(void)shopCollectClick
//{
//   // PUSH(shopCollectVC)
//
//}
//-(void)baobeiClick
//{
//    //PUSH(productCollectVC)
//
//}
//-(void)myOrderList:(UIButton*)button
//{
////    PUSH(orderlistVC)
////     vc.orders=[NSString stringWithFormat:@"%d",button.tag+1];
//
//}

-(void)viewWillAppear:(BOOL)animated
{

     [super viewWillAppear:animated];
      self.tabBarController.tabBar.hidden=YES;
//    if (USERID==nil) {
//        ALLOC(logInVC)
//        [self presentViewController:vc animated:NO completion:^{
//
//        }];
//    }else
//    {

    [self judgeSignedOrNot];

    [self getcount];
//    }

//    [_tableView reloadData];
}
-(void)judgeSignedOrNot{
    NSDate *nowdate =[NSDate date];
    NSString *nowStr = [[nowdate description]substringToIndex:10];
    NSString *urlstr= [NSString stringWithFormat:@"%@/users/existSign.action?userId=%@&signInDate=%@",BASE_URLL,USERID,nowStr];
    NSLog(@"url ==%@",urlstr);
    [requestData getData:urlstr complete:^(NSDictionary *dic) {

        NSLog(@"----judgeSignedOrNot--");

        SignedOrNot = dic;
        [self getUserInfo];
        [_tableView reloadData];

    }];

}
-(void)backClick
{

    POP


//    PUSH(homePage)
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)selectButton:(UIButton*)button{
//
//
////    PUSH(orderlistVC)
////
////    vc.orders=[NSString stringWithFormat:@"%d",button.tag+1];
////    NSLog(@"vc.orders==%@ ",vc.orders);
//
//    if (button.tag ==1) {
//        PUSH(pubStoryVC)
//
//    }
//
//}

-(void)xialaBtnClick:(UIButton *)button{


    if (USERID==nil) {
        ALLOC(logInVC)
        [self presentViewController:vc animated:NO completion:^{

        }];
    }else{

    if(button.tag==0){


//        [self signDate];

        NSDate *nowdate =[NSDate date];
        NSString *nowStr = [[nowdate description]substringToIndex:10];
        NSString *urlstr= [NSString stringWithFormat:@"%@/users/addscore.action?userId=%@&signInDate=%@",BASE_URLL,USERID,nowStr];
        [requestData getData:urlstr complete:^(NSDictionary *dic) {
            signDic = dic;


            if ([signDic[@"flag"] integerValue]==1) {
                [selectImg setImage:[UIImage imageNamed:@"duihao"] forState:UIControlStateNormal];
                MISSINGVIEW
                missing_v.tishi = [NSString stringWithFormat:@"%@,积分+%@",signDic[@"info"],signDic[@"Score"]];
            }else if ([signDic[@"flag"] integerValue]==0){
                MISSINGVIEW
                missing_v.tishi = @"今天已经签过到了！";
            }

            [self judgeSignedOrNot];
            [_tableView reloadData];
            
        }];




        }


      }
    if (button.tag==1) {

            PUSH(pubStoryVC)

//        [self removeFromParentViewController];

        
    }



}
-(void)OrderSelect:(UIButton*)button{
    NSLog(@"===%ld",(long)button.tag);
    switch (button.tag) {
        case 0:
        {
            PUSH(orderlistVC)
            vc.orders=@"1";
            break;
        }

        case 1:
        {
            PUSH(orderlistVC)
            vc.orders=@"3";
            break;
        }
        case 2:
        {
            PUSH(orderlistVC)
            vc.orders=@"4";
            break;
        }

        case 3:
        {
            PUSH(PostSale)
//            vc.orders=@"4";
            break;
        }

        default:
            break;
    }

}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];


}
-(NSString *)getTheNoNullStr:(id)str andRepalceStr:(NSString*)replace{
    NSString *string=nil;
    if (![str isKindOfClass:[NSNull class]]) {
        string =  [NSString stringWithFormat:@"%@",str];

        if (string.length ==0||(NSNull*)string == [NSNull null]||[string isEqualToString:@"(null)"]) {
            string =replace;
        }
    }else{
        string =replace;
    }
    return string;
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

