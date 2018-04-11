////
////  ShequViewController.m
////  PsychiatricConsulting
////
////  Created by apple on 15/8/27.
////  Copyright (c) 2015年 Liuyang. All rights reserved.
////
//
#import "ShequViewController.h"
#import "pubStoryVC.h"
#import "luntanViewController.h"
#import "Modle.h"
#import "mystoryVC.h"
#import "transformTime.h"
#import "SQFLViewController.h"
#import "detailViewController.h"
#import "myButton.h"
#import "homePage.h"
#import "logInVC.h"
@interface ShequViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate>

{
    SCREEN_WIDTH_AND_HEIGHT
    UITableView *_tableview;
    UIImageView    *_smallView;
    UILabel*name_L;
//    NSArray*className;

    NSArray*dataArray;
    NSArray *modleArray;
    NSArray *modle1Array;

    SDRefreshHeaderView     *_refesh;
    SDRefreshFooterView     *_refeshDown;

    NSString                *_currentId;

    NSMutableArray *listArray;

}


@end

@implementation ShequViewController
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden = YES;
//    [self getData:@""];


}
- (void)viewDidLoad {
    [super viewDidLoad];



//    NSTimeInterval time = -[olddate timeIntervalSinceDate:curDate];
//

//    NSString *string=[transformTime prettyDateWithReference:@"2015-09-06 16:26:58.233"];
//        NSLog(@"old==%@",string);


    SCREEN
    listArray =[[NSMutableArray alloc]init];
    TOP_VIEW(@"社区");
//    backBtn.image=[UIImage imageNamed:@"未标题-1(4)"];
//    backBtn.frame=CGRectMake(_width*0.05, 30, 20, 20);

    UIButton*rightUpBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightUpBtn.frame=CGRectMake(_width*0.87, 30,20, 20);
    [rightUpBtn setBackgroundImage:[UIImage imageNamed:@"未标题-1(4)"] forState:UIControlStateNormal];
    [topView addSubview:rightUpBtn];
    UIButton*rightUpBtnBack=[UIButton buttonWithType:UIButtonTypeCustom];
    rightUpBtnBack.frame=CGRectMake(_width*0.85, 20,_width*0.8, 30);
    [rightUpBtnBack addTarget:self action:@selector(rightUpBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:rightUpBtnBack];


    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64) style:UITableViewStyleGrouped];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.bounces=YES;
    [self.view addSubview:_tableview];
//    _tableview.delaysContentTouches=NO;
    _tableview.separatorColor=[UIColor clearColor];

//上提刷新
    _refesh=[SDRefreshHeaderView refreshView];
    __block ShequViewController*blockSelf=self;
    [_refesh addToScrollView:_tableview];

    _refesh.beginRefreshingOperation=^{
        [blockSelf getData:@"shuaxin"];
        [blockSelf getdata];

        
    };
    _refesh.isEffectedByNavigationController =NO;
//下拉刷新
    _refeshDown=[SDRefreshFooterView refreshView];
    [_refeshDown addToScrollView:_tableview];

    _refeshDown.beginRefreshingOperation=^{
        [blockSelf getData:@"more"];
        [blockSelf getdata];



    };

    [self getdata];
    [self getData:@""];




}

-(void)getdata{


    //1.加载社区话题分类数据
    LOADVIEW
    [requestData getData:APP_URLL complete:^(NSDictionary *dic) {
        LOADREMOVE
        NSMutableArray *array = [[NSMutableArray alloc]init];
        dataArray = [dic objectForKey:@"data"];
        for (NSDictionary *dict in dataArray) {
            Modle *modle = [[Modle alloc]init];

            modle.typeName = [dict objectForKey:@"typeName"];
            modle.typeBackground = [dict objectForKey:@"typeBackground"];
            modle.smallIcon=[dict objectForKey:@"smallIcon"];
            modle.typeOrder=[dict objectForKey:@"typeOrder"];
            modle.interactiveId=dict[@"interactiveId"];
            modle.Remarks=dict[@"Remarks"];
            [array addObject:modle];
//            NSLog(@"-----array-- %@",modle.typeName);


        }
        modleArray =[NSArray arrayWithArray:array];
//        SQFLViewController *sqflVC = [[SQFLViewController alloc]init];
//        sqflVC.modleArray=modleArray;


        [_tableview reloadData];
    }];
    


}
-(void)getData:(NSString*)more
{

    UIImageView*iv=(UIImageView*)[_tableview viewWithTag:22222];
    UILabel*la=(UILabel*)[_tableview viewWithTag:222222];
    [iv removeFromSuperview];
    [la removeFromSuperview];
//    LOADVIEW

    //2.加载话题分类列表。
    NSString *str = [NSString stringWithFormat:@"%@/topics/list.action",BASE_URLL];
               NSLog(@"%@",str);
    if([more isEqualToString:@"more"]){

        str = [NSString stringWithFormat:@"%@?id=%@&tag=2",str,_currentId];
//        //           NSLog(@"str=%@",str);
    }
    [requestData getData:str complete:^(NSDictionary *dic) {
//        LOADREMOVE

        [_refesh endRefreshing];
        [_refeshDown endRefreshing];

        NSArray*baseA=[dic objectForKey:@"data"];

        //
        if (baseA.count !=0) {
            if ([more isEqualToString:@"more"]) {
                for (int i=0; i<baseA.count; i++) {
                    [listArray addObject:[baseA objectAtIndex:i]];
                }
            }else
            {
                listArray=[NSMutableArray arrayWithArray:baseA];
                //
            }

        }



        _currentId=[[listArray lastObject] objectForKey:@"rowNumber"];

        [_tableview reloadData];

        if (listArray.count==0||listArray==nil) {

            UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, (_height-260+100)/2, 50,50)];
            tanhao.image=[UIImage imageNamed:@"tanhao"];

            [_tableview addSubview:tanhao];

            UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (_height-260+100)/2+60, _width, 20)];
            tishi.text=@"没有相关的话题！";
            tishi.textColor=[UIColor grayColor];
            tishi.textAlignment=NSTextAlignmentCenter;
            tishi.font=[UIFont systemFontOfSize:14];
            [_tableview addSubview:tishi];
            
            tanhao.tag=22222;
            tishi.tag=222222;
        }


        NSMutableArray *array1 = [[NSMutableArray alloc]init];
        for (NSDictionary *dict in listArray) {
            Modle *modle1 =[[Modle alloc]init];

            modle1.typeName = dict[@"typeName"];//类别
            modle1.topicsTitle = dict[@"topicsTitle"];//主题
            modle1.topicsContent = dict[@"topicsContent"];//内容
           modle1.userId = dict[@"userId"];//用户账号
            modle1.topocImageList =dict[@"topocImageList"];//内容图片
            modle1.praiseCount = dict[@"praiseCount"];//点赞数
            modle1.commentCount=dict[@"commentCount"];//评论数
            modle1.topicsDate=dict[@"topicsDate"];//发表时间
            modle1.nickName=dict[@"nickName"];
            modle1.topicsId=dict[@"topicsId"];
            modle1.isTop = dict[@"isTop"];
            
            [array1 addObject:modle1];
            if ((NSNull*)modle1.topocImageList==[NSNull null]) {
            }
        }
        modle1Array =[NSArray arrayWithArray:array1];
        [_tableview reloadData];

    }];

}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        if (dataArray.count%3!=0) {
            return _width/4*(dataArray.count/3+1)+20;
        }else
            return _width/4*(dataArray.count/3)+20;
    }else
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 15;
    }else
    return 0.1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==1) {
        return modle1Array.count;

    }else
        return 0;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;

}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{



    UIView *view= [[UIView alloc]init];
    view.backgroundColor = RGB(238, 240, 240);

    if (section==0) {

        for (int i=0; i<dataArray.count; i++) {
            int  X=i%3;
            int y= i/3;
            Modle *modle = modleArray[i];

            UIButton*shopBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            shopBtn.frame=CGRectMake(_width/3*X, y *(_width/4+10), _width/3-1, _width/4-1+10);
            [view addSubview:shopBtn];
            shopBtn.backgroundColor = [UIColor whiteColor];
            shopBtn.tag=i;
            [shopBtn addTarget:self action:@selector(shopBtnClick:) forControlEvents:UIControlEventTouchUpInside];

            UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake((_width/3-_width*0.16)/2,10, _width*0.16, _width*0.16)];
            [imageview sd_setImageWithURL:modle.smallIcon placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

            }];


            imageview.clipsToBounds=YES;
            [shopBtn addSubview:imageview];
            name_L=[[UILabel alloc]initWithFrame:CGRectMake(0,10+_width*0.16 , _width/3, _width*0.08+5)];
            name_L.text=modle.typeName;
            name_L.textAlignment=NSTextAlignmentCenter;
            name_L.textColor=[UIColor blackColor];
            name_L.numberOfLines=0;
//            name_L.backgroundColor=[UIColor orangeColor];
            name_L.font=[UIFont systemFontOfSize:13];
            [shopBtn addSubview:name_L];

                UIView*shuxian=[[UIView alloc]initWithFrame:CGRectMake(_width/4*(i+1),10, 1, 30)];
                shuxian.backgroundColor=RGB(234, 234, 234);
//                [cell.contentView addSubview:shuxian];


        }
    }else if (section==1){
        return nil;
    }

    return view;



}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        Modle *mode =modle1Array[indexPath.row];
        if ((NSNull*)mode.topocImageList==[NSNull null]) {
            return _width*0.025+117-10;
        }else if ((NSNull*)mode.topocImageList!=[NSNull null] && mode.topocImageList.count ==1) {
            return  0.275*_width+52;
        }else if((NSNull*)mode.topocImageList!=[NSNull null] && mode.topocImageList.count==2){
            NSString *str = [NSString stringWithFormat:@"      %@",mode.topicsContent];
            CGFloat WW =  [self boundWithSize:CGSizeMake(MAXFLOAT, 35) WithString:str WithFont:[UIFont systemFontOfSize:14]].width;
            if (WW <=_width*0.94) {
                return  0.375*_width+117-15;

            }else
            return  0.375*_width+117;
        }else if((NSNull*)mode.topocImageList!=[NSNull null] && mode.topocImageList.count>=3){
            NSString *str = [NSString stringWithFormat:@"      %@",mode.topicsContent];
            CGFloat WW =  [self boundWithSize:CGSizeMake(MAXFLOAT, 35) WithString:str WithFont:[UIFont systemFontOfSize:14]].width;
            if (WW <=_width*0.94) {
                return  0.275*_width+117-15;

            }else
                return  0.275*_width+117;
        }


    }

    return 0;

}

 -(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];

    [tableView setSeparatorInset:UIEdgeInsetsZero];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
        Modle *mode =modle1Array[indexPath.row];
//     NSLog(@"++ indexPath.row =%ld+++++%@",(long)indexPath.row,mode.topicsDate);

    if (indexPath.section==1) {
        _zanBtn.userInteractionEnabled = NO;

         if ((NSNull*)mode.topocImageList==[NSNull null]){


             UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.03, _width*0.025, _width*0.96, 20)];
             [cell addSubview:lab];
             //            lab.backgroundColor=[UIColor greenColor];
             lab.text = mode.topicsTitle;
             lab.textColor = [UIColor blackColor];
             lab.font = [UIFont systemFontOfSize:15];

             UILabel *shijianlab = [UILabel new];
             shijianlab.frame = CGRectMake(_width*0.83, _width*0.025, 100, 20);
//             shijianlab.center =CGPointMake(_width*0.9, lab.center.y);
             //转换时间，计算时间差
             NSString *datestr = [transformTime prettyDateWithReference:mode.topicsDate];
             shijianlab.text = datestr;
             shijianlab.textColor = [UIColor darkGrayColor];
             shijianlab.font = [UIFont systemFontOfSize:13];
             [cell addSubview:shijianlab];

             UILabel *detailLab = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.03, 20+_width*0.025, _width*0.94, 35)];
             [cell addSubview:detailLab];
             detailLab.numberOfLines=2;
             detailLab.textColor = [UIColor darkGrayColor];
             detailLab.font = [UIFont systemFontOfSize:14];
             detailLab.text = mode.topicsContent;



             _zan_ju_view = [[UIView alloc]initWithFrame:CGRectMake(0, detailLab.frame.origin.y+detailLab.frame.size.height+7, _width, 45)];

             _typen=[UIButton buttonWithType:UIButtonTypeRoundedRect];
             _typen.frame=CGRectMake(10, 5, _width*0.15, 20);
             [_typen setTitle:mode.typeName forState:UIControlStateNormal];
             _typen.layer.cornerRadius = 7;
             _typen.layer.borderWidth=1;
             _typen.layer.borderColor=COR_ClOUR.CGColor;
             _typen.titleLabel.font = [UIFont systemFontOfSize:12];
             [_typen setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

//             _typen.layer.borderColor= [UIColor redColor].CGColor;

             [_zan_ju_view addSubview:_typen];

             _zanBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
             _zanBtn.frame = CGRectMake(_width*0.62, 5, _width*0.15, 20);
             _zanBtn.layer.cornerRadius = 7;
             _zanBtn.layer.borderWidth=1;
             _zanBtn.layer.borderColor= COR_ClOUR.CGColor;
             [_zan_ju_view addSubview:_zanBtn];

             UIImageView *zanimag = [[UIImageView alloc]init];
             zanimag.frame = CGRectMake(_zanBtn.frame.size.width*0.15, 1, 16, 16);
             zanimag.image =[UIImage imageNamed:@"zan2"];
             [_zanBtn addSubview:zanimag];
             _zanlab = [[UILabel alloc]init];
             _zanlab.frame = CGRectMake(_zanBtn.frame.size.width*0.65, 1, 16, 16);
             _zanlab.textAlignment = NSTextAlignmentLeft;
             _zanlab.text= [NSString stringWithFormat:@"%@",mode.praiseCount] ;
             _zanlab.textColor =[UIColor lightGrayColor];
             _zanlab.font=[UIFont systemFontOfSize:12];
             [_zanBtn addSubview:_zanlab];
             myButton *zanbutton = [[myButton alloc]initWithFrame:CGRectMake(_width*0.62, 0, _width*0.15, 44)];
             //             zanbutton.backgroundColor =[UIColor redColor];
             zanbutton.IDstring = mode;
             [zanbutton addTarget:self action:@selector(zanclick:) forControlEvents:UIControlEventTouchUpInside];
             [_zan_ju_view addSubview:zanbutton];

//             //           NSLog(@"%@",_zanlab.text);


             _pinglun = [UIButton buttonWithType:UIButtonTypeRoundedRect];
             _pinglun.frame = CGRectMake(_width*0.83, 5, _width*0.15, 20);
             _pinglun.layer.cornerRadius = 7;
             _pinglun.layer.borderWidth=1;
             _pinglun.layer.borderColor= COR_ClOUR.CGColor;
             [_zan_ju_view addSubview:_pinglun];

             UIButton *PLbtn = [[UIButton alloc]initWithFrame:CGRectMake(_width*0.82, 0, _width*0.15, 44)];
             PLbtn.tag= indexPath.row;
             [PLbtn addTarget:self action:@selector(pingbutton:) forControlEvents:UIControlEventTouchUpInside];
             [_zan_ju_view addSubview:PLbtn];


             UIImageView *plimag = [[UIImageView alloc]init];
             plimag.frame = CGRectMake(_zanBtn.frame.size.width*0.15, 1.5, 16, 16);
             plimag.image =[UIImage imageNamed:@"ping1"];
             [_pinglun addSubview:plimag];
             _PLlab = [[UILabel alloc]init];

             _PLlab.frame = CGRectMake(_zanBtn.frame.size.width*0.65, 1, 16, 16);
                         _PLlab.text=[NSString stringWithFormat:@"%@",mode.commentCount];
            _PLlab.text=[NSString stringWithFormat:@"%@",mode.commentCount];
             _PLlab.textColor =[UIColor lightGrayColor];
             _PLlab.font=[UIFont systemFontOfSize:12];
             [_pinglun addSubview:_PLlab];
             
             [cell.contentView addSubview: _zan_ju_view];



             UIView*line=[[UIView alloc]initWithFrame:CGRectMake(0, _width*0.025+117-1-10-10, _width, 10)];
             line.backgroundColor=RGB(234, 234, 234);
             [cell addSubview:line];


}
       else if ((NSNull*)mode.topocImageList!=[NSNull null] && mode.topocImageList.count==1) {
            UIView*line=[[UIView alloc]initWithFrame:CGRectMake(0, 0.275*_width+52-1-10, _width, 10)];
            line.backgroundColor=RGB(234, 234, 234);
            [cell addSubview:line];

            UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(_width*0.03, _width*0.025, _width*0.3, _width*0.25)];
            [cell.contentView addSubview:imgv];

           NSString *str =  [mode.topocImageList[0]objectForKey:@"linkImagePath"];

           NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",str]];
           [imgv sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

               if (image==nil) {
                   imgv.image = [UIImage imageNamed:@"fang"];

               }else{

               float   w=image.size.width;
               float   hh=image.size.height;
               if (hh>w) {
                   float   h=(image.size.height-w*5/6)/2;
                   CGRect rect =  CGRectMake(0, h, w, 5*w/6);

                   CGImageRef cgimg = CGImageCreateWithImageInRect([image CGImage], rect);

                   [imgv setImage:[UIImage imageWithCGImage:cgimg]];
                   CGImageRelease(cgimg);


               }else
               {
                   float  ww=(w-6*hh/5)/2;
                   CGRect rect =  CGRectMake(ww, 0, 1.2*hh,hh);
                   CGImageRef cgimg = CGImageCreateWithImageInRect([image CGImage], rect);
                   [imgv setImage:[UIImage imageWithCGImage:cgimg]];
                   CGImageRelease(cgimg);
                   
               }
             }

           }];


           NSString *strtopicsContent = [NSString stringWithFormat:@"      %@",mode.topicsContent];


            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.35, _width*0.025, _width*0.45, 20)];
            [cell addSubview:lab];
            lab.text = mode.topicsTitle;
            lab.font = [UIFont systemFontOfSize:15];

            UILabel *detailLab = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.35, 20+10, _width*0.6, 35)];
            [cell addSubview:detailLab];
            detailLab.font = [UIFont systemFontOfSize:14];
           detailLab.numberOfLines=2;
           detailLab.textColor=[UIColor darkGrayColor];
            detailLab.text = strtopicsContent;

            UILabel *shijianlab = [UILabel new];
           shijianlab.frame = CGRectMake(_width*0.83, _width*0.025, 100, 20);

//            shijianlab.bounds = CGRectMake(0, 0, 48, 20);
//            shijianlab.center =CGPointMake(_width*0.9, lab.center.y);
           NSString *datestr = [transformTime prettyDateWithReference:mode.topicsDate];
           shijianlab.text = datestr;
           shijianlab.textColor=[UIColor darkGrayColor];
            shijianlab.font = [UIFont systemFontOfSize:13];
            [cell addSubview:shijianlab];


           _zan_ju_view=[[UIView alloc]initWithFrame:CGRectMake(0, imgv.frame.origin.y+imgv.frame.size.height+10, _width, 45)];

           _typen=[UIButton buttonWithType:UIButtonTypeRoundedRect];
           _typen.frame=CGRectMake(10, 5, _width*0.15, 20);
           [_typen setTitle:mode.typeName forState:UIControlStateNormal];
           _typen.layer.cornerRadius = 7;
           _typen.layer.borderWidth=1;
           [_typen setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

           _typen.layer.borderColor=COR_ClOUR.CGColor;


           _typen.titleLabel.font = [UIFont systemFontOfSize:12];
           [_zan_ju_view addSubview:_typen];

           _zanBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
           _zanBtn.frame = CGRectMake(_width*0.62, 5, _width*0.15, 20);
           _zanBtn.layer.cornerRadius = 7;
           _zanBtn.layer.borderWidth=1;
           _zanBtn.layer.borderColor= COR_ClOUR.CGColor;



           UIImageView *zanimag = [[UIImageView alloc]init];
           zanimag.frame = CGRectMake(_zanBtn.frame.size.width*0.15, 1, 16, 16);
           zanimag.image =[UIImage imageNamed:@"zan2"];
           [_zanBtn addSubview:zanimag];
           _zanlab = [[UILabel alloc]init];
           _zanlab.frame = CGRectMake(_zanBtn.frame.size.width*0.65, 1, 16, 16);
           _zanlab.text= [NSString stringWithFormat:@"%@",mode.praiseCount] ;
           _zanlab.textColor=[UIColor lightGrayColor];
           _zanlab.font=[UIFont systemFontOfSize:12];
           [_zanBtn addSubview:_zanlab];
           myButton *zanbutton = [[myButton alloc]initWithFrame:CGRectMake(_width*0.62, 0, _width*0.15, 44)];
//           zanbutton.backgroundColor =[UIColor redColor];
           zanbutton.IDstring = mode;

           [zanbutton addTarget:self action:@selector(zanclick:) forControlEvents:UIControlEventTouchUpInside];
           [_zan_ju_view addSubview:_zanBtn];
           [_zan_ju_view addSubview:zanbutton];

//           //           NSLog(@"%@",_zanlab.text);


           _pinglun = [UIButton buttonWithType:UIButtonTypeRoundedRect];
           _pinglun.frame = CGRectMake(_width*0.83, 5, _width*0.15, 20);
           _pinglun.layer.cornerRadius = 7;
           _pinglun.layer.borderWidth=1;
           _pinglun.layer.borderColor= COR_ClOUR.CGColor;
           [_zan_ju_view addSubview:_pinglun];

           UIButton *PLbtn = [[UIButton alloc]initWithFrame:CGRectMake(_width*0.82, 0, _width*0.15, 44)];
           PLbtn.tag= indexPath.row;
           [PLbtn addTarget:self action:@selector(pingbutton:) forControlEvents:UIControlEventTouchUpInside];
           [_zan_ju_view addSubview:PLbtn];

           UIImageView *plimag = [[UIImageView alloc]init];
           plimag.frame = CGRectMake(_zanBtn.frame.size.width*0.15, 1.5, 16, 16);
           plimag.image =[UIImage imageNamed:@"ping1"];
           [_pinglun addSubview:plimag];
           _PLlab = [[UILabel alloc]init];

           _PLlab.frame = CGRectMake(_zanBtn.frame.size.width*0.65, 1, 16, 16);
                       _PLlab.text=[NSString stringWithFormat:@"%@",mode.commentCount];
            _PLlab.text=[NSString stringWithFormat:@"%@",mode.commentCount];
           _PLlab.textColor=[UIColor lightGrayColor];
           _PLlab.font=[UIFont systemFontOfSize:12];
           [_pinglun addSubview:_PLlab];

           [cell.contentView addSubview: _zan_ju_view];
           NSString *strsssss = [NSString stringWithFormat:@"%@",mode.isTop];

           if ([strsssss isEqualToString:@"1"]) {
               UIImageView *topImage = [[UIImageView alloc]initWithFrame:CGRectMake(_width*0.03, _width*0.025, 30, 30)];
               topImage.image = [UIImage imageNamed:@"sq7"];

               [cell addSubview:topImage];

           }



        }else  if((NSNull*)mode.topocImageList!=[NSNull null] && mode.topocImageList.count==2){

            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.03, _width*0.025, _width*0.75, 20)];
            [cell addSubview:lab];
            lab.text = mode.topicsTitle;
            lab.font = [UIFont systemFontOfSize:15];

            UILabel *shijianlab = [UILabel new];
//            shijianlab.bounds = CGRectMake(0, 0, 48, 20);
            shijianlab.frame = CGRectMake(_width*0.83, _width*0.025, 100, 20);

//            shijianlab.center =CGPointMake(_width*0.9, lab.center.y);
            NSString *datestr = [transformTime prettyDateWithReference:mode.topicsDate];
            shijianlab.text = datestr;
            shijianlab.font = [UIFont systemFontOfSize:13];
            shijianlab.textColor=[UIColor lightGrayColor];
            [cell addSubview:shijianlab];


            _smallView=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.03, _width*0.025+25, _width*0.94, _width*0.35)];
            [cell addSubview:_smallView];

            for (int i = 0; i<2; i ++) {

            UIImageView *imagev = [[UIImageView alloc]initWithFrame:CGRectMake(_width*0.94/2*i, 0, _width*0.94/2-_width*0.02, _width*0.35)];

                NSString *str =   [mode.topocImageList[i]objectForKey:@"linkImagePath"];

                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",str]];

                [imagev sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {


                    if (image==nil) {

                        image=[UIImage imageNamed:@"fang"];

                    }
                    float   w=image.size.width;
                    float   hh=image.size.height;
                    if (hh>w) {
                        float   h=(image.size.height-w*5/6)/2;
                        CGRect rect =  CGRectMake(0, h, w, 5*w/6);

                        CGImageRef cgimg = CGImageCreateWithImageInRect([image CGImage], rect);


                        [imagev setImage:[UIImage imageWithCGImage:cgimg]];
                        CGImageRelease(cgimg);


                    }else
                    {
                        float  ww=(w-6*hh/5)/2;
                        CGRect rect =  CGRectMake(ww, 0, 1.2*hh,hh);
                        CGImageRef cgimg = CGImageCreateWithImageInRect([image CGImage], rect);
                        [imagev setImage:[UIImage imageWithCGImage:cgimg]];

                        CGImageRelease(cgimg);
                        
                    }

                    
                }];

                [_smallView addSubview:imagev];

            }

            NSString *str = [NSString stringWithFormat:@"      %@",mode.topicsContent];

            CGFloat WW =  [self boundWithSize:CGSizeMake(MAXFLOAT, 35) WithString:str WithFont:[UIFont systemFontOfSize:14]].width;

            UIView*line=[[UIView alloc]initWithFrame:CGRectMake(0, 0.375*_width+117-1-10, _width, 10)];
            line.backgroundColor=RGB(234, 234, 234);
            [cell addSubview:line];

            UILabel *dlab = [[UILabel alloc]init];

            if (WW <=_width*0.94) {
                dlab.frame =CGRectMake( _smallView.frame.origin.x, _smallView.frame.origin.y+_smallView.frame.size.height+5, _smallView.frame.size.width, 20);
                line.frame =CGRectMake(0, 0.375*_width+117-1-10-15, _width, 10);

            }else{
                dlab.frame =CGRectMake( _smallView.frame.origin.x, _smallView.frame.origin.y+_smallView.frame.size.height+5, _smallView.frame.size.width, 35);

            }
            dlab.text = str;
            dlab.textColor=[UIColor darkGrayColor];
            dlab.numberOfLines=2;
            dlab.font = [UIFont systemFontOfSize:14];
            [cell addSubview:dlab];

            _zan_ju_view=[[UIView alloc]initWithFrame:CGRectMake(0, dlab.frame.origin.y+dlab.frame.size.height+7, _width, 45)];

            _typen=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            _typen.frame=CGRectMake(10, 5, _width*0.15, 20);
            [_typen setTitle:mode.typeName forState:UIControlStateNormal];
            _typen.layer.cornerRadius = 7;
            _typen.layer.borderWidth=1;
            _typen.layer.borderColor= COR_ClOUR.CGColor;
          _typen.titleLabel.font = [UIFont systemFontOfSize:12];
            [_typen setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

            [_zan_ju_view addSubview:_typen];

            _zanBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            _zanBtn.frame = CGRectMake(_width*0.62, 5, _width*0.15, 20);
            _zanBtn.layer.cornerRadius = 7;
            _zanBtn.layer.borderWidth=1;
            _zanBtn.layer.borderColor= COR_ClOUR.CGColor;
            [_zan_ju_view addSubview:_zanBtn];

            UIImageView *zanimag = [[UIImageView alloc]init];
            zanimag.frame = CGRectMake(_zanBtn.frame.size.width*0.15, 1, 16, 16);
            zanimag.image =[UIImage imageNamed:@"zan2"];
            [_zanBtn addSubview:zanimag];
            _zanlab = [[UILabel alloc]init];
            _zanlab.frame = CGRectMake(_zanBtn.frame.size.width*0.65, 1, 16, 16);
            
            _zanlab.text= [NSString stringWithFormat:@"%@",mode.praiseCount] ;
            _zanlab.font=[UIFont systemFontOfSize:12];
            [_zanBtn addSubview:_zanlab];
            _zanlab.textColor =[UIColor lightGrayColor];
            //           NSLog(@"%@",_zanlab.text);
            myButton *zanbutton = [[myButton alloc]initWithFrame:CGRectMake(_width*0.62, 0, _width*0.15, 44)];
//            zanbutton.backgroundColor =[UIColor redColor];
            zanbutton.IDstring = mode;

            [zanbutton addTarget:self action:@selector(zanclick:) forControlEvents:UIControlEventTouchUpInside];
            [_zan_ju_view addSubview:zanbutton];


            _pinglun = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            _pinglun.frame = CGRectMake(_width*0.83, 5, _width*0.15, 20);
            _pinglun.layer.cornerRadius = 7;
            _pinglun.layer.borderWidth=1;
            _pinglun.layer.borderColor= COR_ClOUR.CGColor;
            [_zan_ju_view addSubview:_pinglun];

            UIButton *PLbtn = [[UIButton alloc]initWithFrame:CGRectMake(_width*0.82, 0, _width*0.15, 44)];
            PLbtn.tag= indexPath.row;
            [PLbtn addTarget:self action:@selector(pingbutton:) forControlEvents:UIControlEventTouchUpInside];
            [_zan_ju_view addSubview:PLbtn];


            UIImageView *plimag = [[UIImageView alloc]init];
            plimag.frame = CGRectMake(_zanBtn.frame.size.width*0.15, 1.5, 16, 16);
            plimag.image =[UIImage imageNamed:@"ping1"];
            [_pinglun addSubview:plimag];
            _PLlab = [[UILabel alloc]init];

            _PLlab.frame = CGRectMake(_zanBtn.frame.size.width*0.65, 1, 16, 16);
                        _PLlab.text=[NSString stringWithFormat:@"%@",mode.commentCount];
            _PLlab.text=[NSString stringWithFormat:@"%@",mode.commentCount];
            _PLlab.textColor =[UIColor lightGrayColor];
            _PLlab.font=[UIFont systemFontOfSize:12];
            [_pinglun addSubview:_PLlab];
            
            [cell.contentView addSubview: _zan_ju_view];
            NSString *strsssss = [NSString stringWithFormat:@"%@",mode.isTop];

            if ([strsssss isEqualToString:@"1"]) {
                UIImageView *topImage = [[UIImageView alloc]initWithFrame:CGRectMake(_width*0.03, _width*0.025+25, 30, 30)];
                topImage.image = [UIImage imageNamed:@"sq7"];

                [cell addSubview:topImage];

            }


        }
            else if((NSNull*)mode.topocImageList!=[NSNull null] && mode.topocImageList.count>=3)

        {
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.03, _width*0.025, _width*0.75, 20)];
            [cell addSubview:lab];

            lab.text = mode.topicsTitle;
            lab.font = [UIFont systemFontOfSize:15];

            UILabel *shijianlab = [UILabel new];
            shijianlab.frame = CGRectMake(_width*0.83, _width*0.025, 100, 20);
//            shijianlab.center =CGPointMake(_width*0.9, lab.center.y);
            NSString *datestr = [transformTime prettyDateWithReference:mode.topicsDate];
            shijianlab.text = datestr;
            shijianlab.textColor=[UIColor darkGrayColor];
            shijianlab.font = [UIFont systemFontOfSize:13];
            [cell addSubview:shijianlab];




            _smallView=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.03, _width*0.025+25, _width*0.94, _width*0.25)];
            _smallView.userInteractionEnabled = NO;

            [cell addSubview:_smallView];

      for (int i = 0; i<3; i ++) {

          UIButton *imagebtn = [[UIButton alloc]init];
          imagebtn.frame= CGRectMake(0+_width*0.32*i, 0, _width*0.3, _width*0.25);
          [imagebtn addTarget:self action:@selector(imgbtn:) forControlEvents:UIControlEventTouchUpInside];
          imagebtn.tag=i;

          NSString *str =       [mode.topocImageList[i]objectForKey:@"linkImagePath"];

          NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",str]];
          [imagebtn sd_setBackgroundImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
              if (image==nil) {

                  image=[UIImage imageNamed:@"fang"];

              }
              float   w=image.size.width;
              float   hh=image.size.height;
              if (hh>w) {
                  float   h=(image.size.height-w*5/6)/2;
                  CGRect rect =  CGRectMake(0, h, w, 5*w/6);

                  CGImageRef cgimg = CGImageCreateWithImageInRect([image CGImage], rect);


                  [imagebtn setBackgroundImage:[UIImage imageWithCGImage:cgimg] forState:UIControlStateNormal];
                  CGImageRelease(cgimg);


              }else
              {
                  float  ww=(w-6*hh/5)/2;
                  CGRect rect =  CGRectMake(ww, 0, 1.2*hh,hh);
                  CGImageRef cgimg = CGImageCreateWithImageInRect([image CGImage], rect);
                  [imagebtn setBackgroundImage:[UIImage imageWithCGImage:cgimg] forState:UIControlStateNormal];
                  CGImageRelease(cgimg);
                  
              }
              


          }];
//          [imagebtn sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"qqq1.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//
//}];


    [_smallView addSubview:imagebtn];

            }


            UIView*line=[[UIView alloc]initWithFrame:CGRectMake(0, _width*0.275+117-1-10, _width, 10)];
            line.backgroundColor=RGB(234, 234, 234);
            [cell addSubview:line];


            NSString *strtopicsContent = [NSString stringWithFormat:@"      %@",mode.topicsContent];

            UILabel *dlab = [[UILabel alloc]init];

            CGFloat WW =  [self boundWithSize:CGSizeMake(MAXFLOAT, 35) WithString:strtopicsContent WithFont:[UIFont systemFontOfSize:14]].width;

            if (WW <=_width*0.94) {
                dlab.frame =CGRectMake( _smallView.frame.origin.x, _smallView.frame.origin.y+_smallView.frame.size.height+5, _smallView.frame.size.width, 20);

                dlab.frame =CGRectMake( _smallView.frame.origin.x, _smallView.frame.origin.y+_smallView.frame.size.height+5, _smallView.frame.size.width, 20);

                line.frame =CGRectMake(0, 0.275*_width+117-1-10-15, _width, 10);

            }else{
                dlab.frame =CGRectMake( _smallView.frame.origin.x, _smallView.frame.origin.y+_smallView.frame.size.height+5, _smallView.frame.size.width, 35);
                
            }

//            dlab.frame =CGRectMake( _smallView.frame.origin.x, _smallView.frame.origin.y+_smallView.frame.size.height+10, _smallView.frame.size.width, 35);
            dlab.text = strtopicsContent;
//            dlab.backgroundColor=[UIColor darkGrayColor];
            dlab.numberOfLines=2;
            dlab.textColor =[UIColor darkGrayColor];
            dlab.font = [UIFont systemFontOfSize:14];
            [cell addSubview:dlab];

            _zan_ju_view=[[UIView alloc]initWithFrame:CGRectMake(0, dlab.frame.origin.y+dlab.frame.size.height,_width*0.6, _width*0.1)];
//            _zan_ju_view.backgroundColor = [UIColor redColor];

            _typen=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            _typen.frame=CGRectMake(10, 5, _width*0.15, 20);
            [_typen setTitle:mode.typeName forState:UIControlStateNormal];
            _typen.titleLabel.font=[UIFont systemFontOfSize:13];
            _typen.layer.cornerRadius = 7;
            _typen.layer.borderWidth=1;
            [_typen setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            _typen.layer.borderColor= COR_ClOUR.CGColor;

            _typen.titleLabel.font = [UIFont systemFontOfSize:12];
            [_zan_ju_view addSubview:_typen];

            _zanBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            _zanBtn.frame = CGRectMake(_width*0.62, 5, _width*0.15, 20);
            _zanBtn.layer.cornerRadius = 7;
            _zanBtn.layer.borderWidth=1;
            _zanBtn.userInteractionEnabled=NO;
            _zanBtn.layer.borderColor= COR_ClOUR.CGColor;
            [_zan_ju_view addSubview:_zanBtn];

            UIImageView *zanimag = [[UIImageView alloc]init];
            zanimag.frame = CGRectMake(_zanBtn.frame.size.width*0.15, 1, 16, 16);
            zanimag.image =[UIImage imageNamed:@"zan2"];
            [_zanBtn addSubview:zanimag];
            _zanlab = [[UILabel alloc]init];
            _zanlab.frame = CGRectMake(_zanBtn.frame.size.width*0.65, 1, 16, 16);
            _zanlab.text= [NSString stringWithFormat:@"%@",mode.praiseCount] ;
            _zanlab.textColor =[UIColor lightGrayColor];
            _zanlab.font=[UIFont systemFontOfSize:12];
            [_zanBtn addSubview:_zanlab];
            myButton *zanbutton = [[myButton alloc]initWithFrame:CGRectMake(_width*0.62, 0, _width*0.15, 44)];
            [zanbutton addTarget:self action:@selector(zanclick:) forControlEvents:UIControlEventTouchUpInside];
            zanbutton.IDstring = mode;

            [_zan_ju_view addSubview:zanbutton];

//            //           NSLog(@"%@",_zanlab.text);


            _pinglun = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            _pinglun.frame = CGRectMake(_width*0.83, 5, _width*0.15, 20);
            _pinglun.layer.cornerRadius = 7;
            _pinglun.layer.borderWidth=1;
            _pinglun.layer.borderColor= COR_ClOUR.CGColor;
            [_zan_ju_view addSubview:_pinglun];

            UIButton *PLbtn = [[UIButton alloc]initWithFrame:CGRectMake(_width*0.82, 0, _width*0.15, 44)];
            PLbtn.tag= indexPath.row;
            [PLbtn addTarget:self action:@selector(pingbutton:) forControlEvents:UIControlEventTouchUpInside];
            [_zan_ju_view addSubview:PLbtn];



            UIImageView *plimag = [[UIImageView alloc]init];
            plimag.frame = CGRectMake(_zanBtn.frame.size.width*0.15, 1.5, 16, 16);
            plimag.image =[UIImage imageNamed:@"ping1"];
            [_pinglun addSubview:plimag];
            _PLlab = [[UILabel alloc]init];

            _PLlab.frame = CGRectMake(_zanBtn.frame.size.width*0.65, 1, 16, 16);
            _PLlab.textColor=[UIColor lightGrayColor];
            _PLlab.text=[NSString stringWithFormat:@"%@",mode.commentCount];
            _PLlab.font=[UIFont systemFontOfSize:12];
            [_pinglun addSubview:_PLlab];
            
            [cell.contentView addSubview: _zan_ju_view];

            NSString *strsssss = [NSString stringWithFormat:@"%@",mode.isTop];

            if ([strsssss isEqualToString:@"1"]) {
                UIImageView *topImage = [[UIImageView alloc]initWithFrame:CGRectMake(_width*0.03, _width*0.025+25, 30, 30)];
                topImage.image = [UIImage imageNamed:@"sq7"];

                [cell addSubview:topImage];

            }


        }


    }

    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    PUSH(detailViewController)
    vc.topicsId =[modle1Array[indexPath.row] topicsId];
//    vc.modle =modle1Array[indexPath.row];
//

}
-(void)imgbtn:(UIButton *)button{
    NSLog(@"..........%ld",(long)button.tag);
}
-(void)pingbutton:(UIButton*)button{
    //           NSLog(@"ping");
    PUSH(detailViewController)
    vc.topicsId =[modle1Array[button.tag] topicsId];

}

-(void)zanclick:(myButton *)button{


//            NSLog(@"%@////%@////",modle.userId,button.IDstring);

        if (USERID!=nil) {
            //            NSDictionary*dic=[_dataArray objectAtIndex:button.tag];
            //            //NSString*userId=[dic objectForKey:@"userId"];
            //            NSString*storyId=[dic objectForKey:@"storyId"];


            [requestData getData:STORY_LIST_ZAN_URL(USERID,button.IDstring.topicsId) complete:^(NSDictionary *dic) {
                NSLog(@"%@",dic);
                MISSINGVIEW
                if ([[dic objectForKey:@"flag"] intValue]==0) {
                    missing_v.tishi=[NSString stringWithFormat:@"%@",@"已点赞"];
                    NSLog(@" miss");

                }else
                {
                    [self getData:@""];

                    missing_v.tishi=[NSString stringWithFormat:@"%@",@"点赞成功"];
                    self.isdianzan=YES;

                }
                
            }];
            
        }else
        {
            ALLOC(logInVC)
            [self presentViewController:vc animated:NO completion:^{
                
            }];        }
        
        

    NSLog(@"赞");
}

-(void)shopBtnClick:(UIButton*)button{
    PUSH(luntanViewController)
    vc.titleName=[modleArray[button.tag] typeName];
    vc.interactiveId = [modleArray[button.tag] interactiveId];
//    NSLog(@"-----%@",vc.interactiveId);
}
-(void)rightUpBtnClick{
//PUSH(pubStoryVC)
//    vc.modleArray =modleArray;
//
//               NSLog(@"vc===%@",vc.modleArray);
    if (USERID==nil) {
        ALLOC(logInVC)
        [self presentViewController:vc animated:NO completion:^{

        }];
    }else{
        PUSH(mystoryVC)

    }



}
-(void)backClick{
    //           NSLog(@"我的社区");
//    PUSH(homePage)
    POP

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
