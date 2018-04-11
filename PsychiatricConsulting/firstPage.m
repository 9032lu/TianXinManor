//
//  firstPage.m
//  ShengMengShangmao
//
//  Created by apple on 15-3-26.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "firstPage.h"
//#import "areaClassVC.h"
//#import "industryClassVC.h"
#import "chargeListVC.h"
#import "newsVC.h"
#import "danli.h"

#import "webViewVC.h"

#import "cityListVC.h"
#import "cityViewController.h"
#import "logInVC.h"
#import "registerVC.h"
#import "shopListVC.h"
#import "hospitalVC.h"

#import "scoreVC.h"
#import "foodListViewController.h"
#import "citySelectVC.h"
#import "productVC.h"
#import "newProductListVC.h"
#import "searchViewController.h"
#import "notificationVCViewController.h"
#import "missingView.h"
#import "MyOrderViewController.h"
@interface firstPage ()

@end

@implementation firstPage

- (void)viewDidLoad {
    [super viewDidLoad];

    TOP_VIEW(@"")

    backBtn.image=[UIImage imageNamed:@"low"];
    backBtn.frame=CGRectMake(_width*0.15, 37, 16, 10);


    _text_f=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.22, 27, _width*0.6, 30)];
    UIView*back_search_v=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 34, 34)];
    UIImageView*sear_iv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"suosou"]];
    sear_iv.frame=CGRectMake(8, 8, 20, 20);
    [back_search_v addSubview:sear_iv];

    _text_f.leftView=back_search_v;
    _text_f.leftViewMode=UITextFieldViewModeAlways;
    _text_f.layer.cornerRadius=8;
    _text_f.placeholder=@"输入产品名称";


    [_text_f setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];

    [_text_f setValue:[UIColor colorWithRed:145/255.0f green:145/255.0f blue:149/255.0f alpha:1] forKeyPath:@"_placeholderLabel.color"];
    _text_f.delegate=self;
    _text_f.userInteractionEnabled=NO;
    _text_f.backgroundColor=[UIColor whiteColor];
    [topView addSubview:_text_f];

    UIButton*searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame=CGRectMake(_width*0.22, 24, _width*0.58, 34);
    [searchBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.layer.cornerRadius=5;
    [topView addSubview:searchBtn];




    //backBtn.bounds=CGRectMake(0, 0, 20, 20);
    _city_L=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _width*0.15, 44)];
//    _city_L.text=@"重庆市";

//    _city_L.text = SELECT_CITY;
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"selectCity"];


    _city_L.textAlignment=NSTextAlignmentCenter;
    _city_L.font=[UIFont systemFontOfSize:14];
    _city_L.textColor=[UIColor whiteColor];
    [backTi addSubview:_city_L];
//    NSLog(@"-----%@",SELECT_CITY);
    self.navigationController.navigationBar.hidden=YES;



    UIButton*rightUpBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightUpBtn.frame=CGRectMake(_width*0.87, 30,25, 20);
    [rightUpBtn setBackgroundImage:[UIImage imageNamed:@"xinfeng"] forState:UIControlStateNormal];
    [topView addSubview:rightUpBtn];

    _redView=[[UIView alloc]initWithFrame:CGRectMake(_width*0.87+20, 28, 7, 7)];
    _redView.backgroundColor=[UIColor redColor];
    _redView.layer.cornerRadius=3.5;
    [self.view addSubview:_redView];



    UIButton*rightUpBtnBack=[UIButton buttonWithType:UIButtonTypeCustom];
    rightUpBtnBack.frame=CGRectMake(_width*0.85, 20,_width*0.8, 30);
    [rightUpBtnBack addTarget:self action:@selector(rightUpBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:rightUpBtnBack];


    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64-self.tabBarController.tabBar.frame.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces=YES;
    [self.view addSubview:_tableView];
    _tableView.separatorColor=[UIColor clearColor];




    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status==0) {
            static int i=0;
            i++;
            if (i==1) {
                MISSINGVIEW
                missing_v.tishi=@"你没有连接网络，请连接后再试";
            }
        }else
        {
            [self getData];
//            [self getlocation];
        }
    }];




}

-(void)getData
{
//    NSLog(@"%@",APP_URL);
    LOADVIEW
    [requestData getData:APP_URL complete:^(NSDictionary *dic) {
        LOADREMOVE
        _advistArray=[[dic objectForKey:@"data"] objectForKey:@"advList"];
        _productA=[[dic objectForKey:@"data"] objectForKey:@"proList"];
        _categoryA=[[dic objectForKey:@"data"] objectForKey:@"categoryList"];
        _shopListA=[[dic objectForKey:@"data"] objectForKey:@"shopList"];
        [_tableView reloadData];
    }];





}
-(void)timeAction
{
    if (_advistArray.count==0) {
        return;
    }
    static int i=0;
    i++;
    if (i==_advistArray.count) {
        i=0;
    }
    _pc.currentPage=i;

    [UIView animateWithDuration:0.5 animations:^{
        _pc.frame=CGRectMake(_width*i, _width/2-30, _width, 30);
        _smallScrollV.contentOffset=CGPointMake(_width*i, 0);
    }];


}
-(void)searchClick
{
    NSLog(@"8888888");
    PUSH(searchViewController)
//    vc.whoPush=@"shouye";
//    self.tabBarController.tabBar.hidden=YES;
//    vc.aboutStr=_text_f.text;
//    [_text_f resignFirstResponder];

}

#pragma mark tableView---delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0||section==1) {
        return 1;
    }else
    {
        return 2;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 15;
    }else if(section==3)
    {
        return 1;
    }else
    {
        return 15;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==0||section==1||section==2) {
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 20)];
        view.backgroundColor=RGB(244, 244, 244);
        return view;
    }else
    {
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return _width/2;
    }else
    {
        return 0.1;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return _width*0.3;
        }

    }
    if (indexPath.section==1) {
        return _width/2;
    }
    if (indexPath.section==2) {
        if (indexPath.row==0) {
            return 50;
        }else
        {
            int hang;
            if (_shopListA.count%3==0) {
                hang=(int)_shopListA.count/3;
            }else
            {
                hang=(int)_shopListA.count/3+1;
            }
            return _width/3*hang;
        }
    }
    if (indexPath.section==3) {
        if (indexPath.row==0) {
            return 50;
        }else
        {

            return (_width*0.28)*_productA.count;
        }

    } else
    {
        return 70;
    }

}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        _smallScrollV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _width, _width/2)];
        _smallScrollV.contentSize=CGSizeMake(_width*_advistArray.count, _width/2);
        _smallScrollV.pagingEnabled=YES;
        _smallScrollV.bounces=NO;
        //_smallScrollV.backgroundColor=[UIColor redColor];
        //NSLog(@"jjjjjjj%d",_advistArray.count);

        if (_advistArray.count==0) {
            UIImageView*imagev=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _width, _width/2)];

            imagev.image=[UIImage imageNamed:@"chang"];
            [_smallScrollV addSubview:imagev];
        }else{
            for (int i=0; i<_advistArray.count; i++) {
//                NSLog(@"hhhhhh、、、、、、%@",_advistArray);
                UIButton*view=[UIButton buttonWithType:UIButtonTypeCustom];
                [view sd_setBackgroundImageWithURL:[NSURL URLWithString:[[_advistArray objectAtIndex:i] objectForKey:@"advImage"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"chang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

                }];
                view.frame=CGRectMake(_width*i, 0, _width, _width/2);

                view.tag=i;
//                view.backgroundColor=[UIColor darkGrayColor];
//                if (i==2) {
//                    view.backgroundColor=[UIColor redColor];
//                }
                [view addTarget:self action:@selector(advistBtn:) forControlEvents:UIControlEventTouchUpInside];
                //view.backgroundColor=[UIColor yellowColor];
                [_smallScrollV addSubview:view];
            }

        }
        _pc=[[UIPageControl alloc]initWithFrame:CGRectMake(0, _width/2-30, _width, 30)];
        _pc.currentPage=0;
        _pc.numberOfPages=_advistArray.count;
        if (_advistArray.count==1) {
            _pc.currentPageIndicatorTintColor=[UIColor clearColor];
        }
        _pc.currentPageIndicatorTintColor=[UIColor whiteColor];
        [_smallScrollV addSubview:_pc];
        
        return _smallScrollV;

    }else
    {
        return nil;
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSLog(@"---sec==%ld----row ==%ld",(long)indexPath.section,(long)indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            PUSH(newProductListVC)

        }
    }
    if (indexPath.section==2) {
        if (indexPath.row==0) {
            PUSH(shopListVC)
        }
    }
    if (indexPath.section==3) {
        if (indexPath.row==0) {
            PUSH(foodListViewController)
        }
    }



    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];

    [tableView setSeparatorInset:UIEdgeInsetsZero];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    if (indexPath.section==0) {

        if (indexPath.row==0) {
            NSArray*className=@[@"热门商品",@"商品资讯",@"积分乐园",@"商家活动"];
            NSArray*imageName=@[@"lzd1",@"4",@"lzd2",@"5"];
            for (int i=0; i<4; i++) {
                int  X=i%4;


                UIButton*shopBtn=[UIButton buttonWithType:UIButtonTypeCustom];
                shopBtn.frame=CGRectMake(_width/4*X, 0, _width/4, _width*0.3);

                [cell.contentView addSubview:shopBtn];
                shopBtn.tag=i;
                [shopBtn addTarget:self action:@selector(shopBtnClick:) forControlEvents:UIControlEventTouchUpInside];

                UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake((_width*0.25-50)/2,(_width*0.25-50)/2, 50, 50)];
                imageview.image=[UIImage imageNamed:[imageName objectAtIndex:i]];
                //imageview.layer.cornerRadius=_width*0.1;
                imageview.clipsToBounds=YES;
                [shopBtn addSubview:imageview];

                UILabel*name_L=[[UILabel alloc]initWithFrame:CGRectMake(0, _width*0.2, _width/4, _width*0.1+5)];
                //name_L.text=[NSString stringWithFormat:@"%@",shopName];
                name_L.text=[className objectAtIndex:i];
                name_L.textAlignment=NSTextAlignmentCenter;
                name_L.textColor=[UIColor darkGrayColor];
                name_L.numberOfLines=0;
                name_L.font=[UIFont systemFontOfSize:13];
                [shopBtn addSubview:name_L];

            }
        }

    }
    if (indexPath.section==1) {

        for (int i=0; i<5; i++) {
            int X=(i-1)%2;
            int Y=(i-1)/2;
            UIButton*fiveBtn=[UIButton buttonWithType:UIButtonTypeCustom];

            UILabel*name_L=[[UILabel alloc]init];
            name_L.numberOfLines=0;
            name_L.textAlignment=NSTextAlignmentLeft;
            name_L.font=[UIFont boldSystemFontOfSize:15];
            name_L.textColor=[UIColor darkGrayColor];
            name_L.text=[[_categoryA objectAtIndex:i] objectForKey:@"categoryName"];

            UILabel*dec_L=[[UILabel alloc]init];
            dec_L.textAlignment=NSTextAlignmentLeft;
            dec_L.font=[UIFont italicSystemFontOfSize:11];
            dec_L.textColor=[UIColor grayColor];

            id  description=[[_categoryA objectAtIndex:i] objectForKey:@"description"];
            if (description==[NSNull null]) {
                description=@"";
            }
            dec_L.text=description;


            UIImageView*imageview=[[UIImageView alloc]init];
            [imageview sd_setImageWithURL:[NSURL URLWithString:[[_categoryA objectAtIndex:i] objectForKey:@"picPath"]] placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

            }];


            if (i==0) {
                 fiveBtn.frame=CGRectMake(0, 0, _width/3, _width/2);
                 name_L.frame=CGRectMake(_width*0.05, _width*0.02, _width/3-_width*0.05, _width*0.06);

                dec_L.frame=CGRectMake(_width*0.05, _width*0.08, _width/3-_width*0.05, _width*0.06);

                imageview.frame=CGRectMake(0, _width*0.15, _width/3-_width*0.02, _width/3-_width*0.02);

            }else
            {
                fiveBtn.frame=CGRectMake(_width/3+_width/3*X, _width/4*Y, _width/3, _width/4);
                name_L.frame=CGRectMake(_width*0.02,(_width/4-_width*0.18), _width/6-_width*0.02, _width*0.12);
                name_L.font=[UIFont boldSystemFontOfSize:14];

                dec_L.frame=CGRectMake(_width*0.02, (_width/4-_width*0.06), _width/3-_width*0.02, _width*0.06);
                imageview.frame=CGRectMake(_width/6, _width*0.02, _width/6-_width*0.02, _width/6-_width*0.02);
            }

            fiveBtn.tag=i;
            [fiveBtn addSubview:dec_L];
            [fiveBtn addSubview:name_L];
            [fiveBtn addSubview:imageview];
            [fiveBtn addTarget:self action:@selector(fiveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:fiveBtn];
        }



        for (int i=0; i<1;i++) {
            UIView*xuxian=[[UIView alloc]initWithFrame:CGRectMake(_width/3, 0, 4, _width/2)];
            xuxian.backgroundColor=RGB(244, 244, 244);
//             xuxian.backgroundColor=APP_ClOUR;
            [cell.contentView addSubview:xuxian];
        }

        for (int i=0; i<1;i++) {
            UIView*xuxian=[[UIView alloc]initWithFrame:CGRectMake(_width/3*2, 0, 4, _width/2)];
            xuxian.backgroundColor=RGB(244, 244, 244);
//            xuxian.backgroundColor=APP_ClOUR;
            [cell.contentView addSubview:xuxian];
        }
        for (int i=0; i<1;i++) {
            UIView*xuxian=[[UIView alloc]initWithFrame:CGRectMake(_width/3, _width/4, _width/3*2, 4)];
            xuxian.backgroundColor=RGB(244, 244, 244);
//            xuxian.backgroundColor=APP_ClOUR;
            [cell.contentView addSubview:xuxian];
        }

    }
    if (indexPath.section==2) {
        if (indexPath.row==0) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text=@"商家专区";
        }
        if (indexPath.row==1) {



            for (int i=0; i<_shopListA.count; i++) {
                int X=(i)%3;
                int Y=(i)/3;
                UIButton*fiveBtn=[UIButton buttonWithType:UIButtonTypeCustom];

                UILabel*name_L=[[UILabel alloc]init];
                name_L.textAlignment=NSTextAlignmentCenter;
                name_L.font=[UIFont boldSystemFontOfSize:15];
                name_L.textColor=[UIColor darkGrayColor];
                name_L.text=[[_shopListA objectAtIndex:i] objectForKey:@"shopName"];



                UIImageView*imageview=[[UIImageView alloc]init];
                [imageview sd_setImageWithURL:[NSURL URLWithString:[[_shopListA objectAtIndex:i] objectForKey:@"shopLogo"]] placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

                }];


                fiveBtn.frame=CGRectMake(_width/3*X, _width/3*Y, _width/3, _width/3);
                name_L.frame=CGRectMake(0,(_width/3-_width*0.06), _width/3, _width*0.06);

                imageview.frame=CGRectMake(_width*0.02, _width*0.02, _width/3-_width*0.04,(_width/3-_width*0.1));

                fiveBtn.tag=i;

                [fiveBtn addSubview:name_L];
                [fiveBtn addSubview:imageview];
                [fiveBtn addTarget:self action:@selector(sixShopBTnClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:fiveBtn];
            }

            int hang;
            if (_shopListA.count%3==0) {
                hang=(int)_shopListA.count/3;
            }else
            {
                hang=(int)_shopListA.count/3+1;
            }

            for (int i=0; i<hang;i++) {
                UIView*xuxian=[[UIView alloc]initWithFrame:CGRectMake(0,_width/3*i, _width, 4)];
                xuxian.backgroundColor=RGB(244, 244, 244);
//                  xuxian.backgroundColor=APP_ClOUR;

                [cell.contentView addSubview:xuxian];
            }
            for (int i=0; i<2;i++) {
                UIView*xuxian=[[UIView alloc]initWithFrame:CGRectMake(-2+_width/3*(i+1),0, 4, _width/3*hang)];
                xuxian.backgroundColor=RGB(244, 244, 244);
//                xuxian.backgroundColor=APP_ClOUR;

                [cell.contentView addSubview:xuxian];
            }




//            for (int i=0; i<_width/6;i++) {
//                UIView*xuxian=[[UIView alloc]initWithFrame:CGRectMake(6*i, _width/3-2, 4, 4)];
//                xuxian.backgroundColor=RGB(244, 244, 244);
//                //             xuxian.backgroundColor=APP_ClOUR;
//                [cell.contentView addSubview:xuxian];
//            }
//
//            for (int i=0; i<_width/9;i++) {
//                UIView*xuxian=[[UIView alloc]initWithFrame:CGRectMake(_width/3, 6*i, 4, 4)];
//                xuxian.backgroundColor=RGB(244, 244, 244);
//                //            xuxian.backgroundColor=APP_ClOUR;
//                [cell.contentView addSubview:xuxian];
//            }
//            for (int i=0; i<_width/9;i++) {
//                UIView*xuxian=[[UIView alloc]initWithFrame:CGRectMake(_width/3*2, 6*i, 4, 4)];
//                xuxian.backgroundColor=RGB(244, 244, 244);
//                //            xuxian.backgroundColor=APP_ClOUR;
//                [cell.contentView addSubview:xuxian];
//            }
        }
    }

    if (indexPath.section==3) {
        if (indexPath.row==0) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text=@"猜你喜欢";
        }
        if (indexPath.row==1) {
            for (int i=0; i<_productA.count; i++) {
                NSDictionary*dic=[_productA objectAtIndex:i];
                NSString*productImage=[dic objectForKey:@"productImage"];
                NSString*productName=[dic objectForKey:@"productName"];
                NSString*ratePrice=[dic objectForKey:@"ratePrice"];
                NSString*productId=[dic objectForKey:@"productId"];
                NSString*shopName=[dic objectForKey:@"shopName"];
                NSString*salesQuality=[dic objectForKey:@"salesQuality"];

                NSString*districtName=[dic objectForKey:@"districtName"];




                UIButton*proBtn=[UIButton buttonWithType:UIButtonTypeCustom];
                proBtn.frame=CGRectMake(0,(_width*0.28)*i, _width, _width*0.28);
//                proBtn.backgroundColor=[UIColor redColor];
                proBtn.tag=[productId intValue];
                [proBtn addTarget:self action:@selector(productBtnClick:) forControlEvents:UIControlEventTouchUpInside];

                UIView*line=[[UIView alloc]initWithFrame:CGRectMake(0, 1, _width, 1)];
                line.backgroundColor=RGB(234, 234, 234);
                [proBtn addSubview:line];


                UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.03, _width*0.02, _width*0.31, _width*0.25)];
                [imageview sd_setImageWithURL:[NSURL URLWithString:productImage] placeholderImage:[UIImage imageNamed:@"chang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

                }];
                imageview.layer.cornerRadius=5;
                imageview.clipsToBounds=YES;
                [proBtn addSubview:imageview];

                UILabel*shop_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.37, _width*0.02, _width*0.61, _width*0.06)];
                shop_L.text=[NSString stringWithFormat:@"[%@] %@",districtName,shopName];
                shop_L.numberOfLines=0;
                shop_L.textAlignment=NSTextAlignmentLeft;
                shop_L.textColor=[UIColor grayColor];
                shop_L.font=[UIFont boldSystemFontOfSize:12];
                [proBtn addSubview:shop_L];


                UILabel*name_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.37,_width*0.08, _width*0.61, _width*0.12)];
                name_L.text=[NSString stringWithFormat:@"%@",productName];
                name_L.numberOfLines=0;
                name_L.textAlignment=NSTextAlignmentLeft;
                name_L.textColor=[UIColor darkGrayColor];
                name_L.font=[UIFont boldSystemFontOfSize:15];
                [proBtn addSubview:name_L];

                UILabel*className=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.7, _width*0.2, _width*0.28,_width*0.06)];
                className.text=[NSString stringWithFormat:@"销量（%@）",salesQuality];
                className.numberOfLines=1;
                className.textAlignment=NSTextAlignmentRight;
                className.textColor=[UIColor grayColor];
                className.font=[UIFont italicSystemFontOfSize:13];
                [proBtn addSubview:className];


                UILabel*price_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.37, _width*0.2, _width*0.3,_width*0.06)];
                price_L.text=[NSString stringWithFormat:@"￥%.2f",[ratePrice doubleValue]];
                price_L.numberOfLines=1;
                price_L.textAlignment=NSTextAlignmentLeft;
                price_L.textColor=APP_ClOUR;
                price_L.font=[UIFont systemFontOfSize:15];
                [proBtn addSubview:price_L];

                [cell.contentView addSubview:proBtn];
            }

        }

    }

    return cell;
}
#pragma mark广告位下四个按钮响应
-(void)shopBtnClick:(UIButton*)button
{
    //UITabBarController*tabbarC=(UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;

    if (button.tag==0) {
        PUSH(foodListViewController)
        vc.whoPush=@"ishot";
    }
    if (button.tag==1) {
        PUSH(newsVC)
    }
    if (button.tag==2) {
        PUSH(scoreVC)
    }
    if (button.tag==3) {
        PUSH(chargeListVC)
        vc.whoPush=@"shouye";

    }
}
#pragma mark菜系分类响应
-(void)fiveBtnClick:(UIButton*)button
{


    PUSH(foodListViewController)
    NSString*categoryId=[[_categoryA objectAtIndex:button.tag] objectForKey:@"categoryId"];
    NSString*categoryName=[[_categoryA objectAtIndex:button.tag] objectForKey:@"categoryName"];
    vc.name=categoryName;

    vc.whoPush=@"class";
//    vc.button = button;

    vc.categoryId=categoryId;

}
#pragma mark推荐商铺响应
-(void)sixShopBTnClick:(UIButton*)button
{
    PUSH(hospitalVC)
    NSString*shopId=[[_shopListA objectAtIndex:button.tag] objectForKey:@"shopId"];
    vc.shopId=shopId;

}
-(void)advistBtn:(UIButton*)button
{

    NSDictionary*dic=[_advistArray objectAtIndex:button.tag];
    NSString*url=[dic objectForKey:@"advUrl"];



//
//
    if (url.length==0||[url isEqualToString:@"#"]) {
//        NSLog(@"------------------1-----");

        return;
    }else if([url hasPrefix:@"http:"])
    {
//        NSLog(@"------------------2-----");

        NSLog(@"advurl====%@",url);

        PUSH(webViewVC)
        vc.url=url;
    }else{
//        NSLog(@"------------------3-----%@",url);

        PUSH(hospitalVC);
        vc.shopId=url;

    }

//    Goods*good=[_advListArray objectAtIndex:button.tag];
//
//    if ([good.type intValue]==1) {
//        //NSLog(@"%@",good.advUrl);
//        if ([good.advUrl isEqualToString:@"#"]) {
//            return;
//        }
//        webViewVC*vc=[[webViewVC alloc]init];
//        self.tabBarController.tabBar.hidden=YES;
//        vc.url=good.advUrl;
//        [self.navigationController pushViewController:vc animated:YES];
//
//    }else
//    {
//        shopVC*vc=[[shopVC alloc]init];
//        vc.shopId=[NSString stringWithFormat:@"%@",good.advUrl];
//        [self.navigationController pushViewController:vc animated:YES];
//        
//    }


}

-(void)categorybtnClick:(UIButton*)button
{

//    PUSH(newProductListVC)
//    self.tabBarController.tabBar.hidden=YES;
//    vc.whoPush=@"class";
//    vc.cagetoryId=[NSString stringWithFormat:@"%d",button.tag];
}
-(void)morebtnClick
{
//    NSLog(@"hhhhh");

    UITabBarController*tab=(UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;

    tab.selectedIndex=1;


}
-(void)productBtnClick:(UIButton*)button
{
    PUSH(productVC)
    self.tabBarController.tabBar.hidden=YES;
   vc.productId=[NSString stringWithFormat:@"%ld",(long)button.tag];
}


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark myinfo
-(void)rightUpBtnClick
{
    PUSH(notificationVCViewController)

}
#pragma mark 定位
-(void)backClick
{
//    NSLog(@"location");
    PUSH(cityViewController)

    self.tabBarController.tabBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_timer invalidate];
    _timer=nil;
}
#pragma mark 定位
//-(void)getlocation
//{
//    if ([CLLocationManager locationServicesEnabled]) {
//        _locationManger=[[CLLocationManager alloc]init];
//        _locationManger.delegate=self;
//        _locationManger.desiredAccuracy=kCLLocationAccuracyBest;
//        _locationManger.distanceFilter=100;
//        if ([_locationManger respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
//            [_locationManger requestWhenInUseAuthorization];
//        }
//        _locationManger.pausesLocationUpdatesAutomatically=NO;
//        [_locationManger startUpdatingLocation];
//        //[_locationManger requestAlwaysAuthorization];
//
//    }else
//    {
//        _locationManger=[[CLLocationManager alloc]init];
//        _locationManger.delegate=self;
//        _locationManger.desiredAccuracy=kCLLocationAccuracyBest;
//        _locationManger.distanceFilter=5.0;
//        [_locationManger requestWhenInUseAuthorization];
//
//        [_locationManger startUpdatingLocation];
//        // [_locationManger requestAlwaysAuthorization];
//
//
//    }
//}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{

    CLLocation*loction=[locations lastObject];
    [self getcity:loction];
    [manager stopUpdatingLocation];


    CLLocationCoordinate2D loc=[[locations lastObject] coordinate];

    NSString*latitude=[NSString stringWithFormat:@"%f",loc.latitude];
    NSString*longitude=[NSString stringWithFormat:@"%f",loc.longitude];
    danli*myapp=[danli shareClient];
    myapp.lat=latitude;
    myapp.log=longitude;
    [[NSUserDefaults standardUserDefaults] setObject:latitude forKey:@"latitude"];
    [[NSUserDefaults standardUserDefaults] setObject:longitude forKey:@"longitude"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
-(void)getcity:(CLLocation*)loc
{
//    NSLog(@"aaaaaaaaa%@",loc);
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray *array, NSError *error)
     {

         if (array.count > 0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];

             //将获得的所有信息显示到label上
             // self.location.text = placemark.name;
             //获取城市
             NSString *city = placemark.locality;
             if (!city) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 city = placemark.administrativeArea;

             }
//             NSLog(@"------city = %@",city );
             danli*myapp=[danli shareClient];
             myapp.loca_city=city;
             //NSString*curCity=[[NSUserDefaults standardUserDefaults] objectForKey:@"currentCity"];
             //if (curCity==nil) {


             [[NSUserDefaults standardUserDefaults] setObject:@"重庆市" forKey:@"currentCity"];
             [[NSUserDefaults standardUserDefaults] synchronize];
             if (SELECT_CITY==nil) {
                 _city_L.text=CURRENT_CITY;

                 [[NSUserDefaults standardUserDefaults] setObject:CURRENT_CITY forKey:@"selectCity"];
                 [[NSUserDefaults standardUserDefaults] synchronize];

                 [self getData];

             }


//             if (SELECT_CITY==nil&&CURRENT_CITY==nil) {
//                 [self getData];
//             }



             // }
         }
         else if (error == nil && [array count] == 0)
         {
//             NSLog(@"No results were returned.");
         }
         else if (error != nil)
         {
//             NSLog(@"An error occurred = %@", error);
         }
     }];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    
//    NSLog(@"=====%@",SELECT_CITY);

    if (SELECT_CITY==NULL) {
        _city_L.text = @"重庆市";
//        _city_L.text=CURRENT_CITY;

    }else
    {

        _city_L.text=SELECT_CITY;
    }

    danli*myapp=[danli shareClient];
    if (myapp.cityIsChange) {
        [self getData];
        myapp.cityIsChange=NO;
    }


    if (myapp.isread) {
        _redView.hidden=YES;
    }

    _timer=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];

//    NSLog(@"777777999999%@",districtId);
//    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"districtId"];

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
