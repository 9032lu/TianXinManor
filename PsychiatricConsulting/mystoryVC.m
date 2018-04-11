//
//  mystoryVC.m
//  logRegister
//
//  Created by apple on 15-1-29.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "mystoryVC.h"

#import "storyListCell.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "pubStoryVC.h"
#import "transformTime.h"
#import "detailViewController.h"
@interface mystoryVC ()

@end

@implementation mystoryVC

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden = YES;
    
    [self getData:@""];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN

    HH=0;

    TOP_VIEW(@"我的社区");
    UIButton*rightUpBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightUpBtn.frame=CGRectMake(_width*0.87, 25,25, 25);
    [rightUpBtn setBackgroundImage:[UIImage imageNamed:@"sq9"] forState:UIControlStateNormal];
    [topView addSubview:rightUpBtn];
    UIButton*rightUpBtnBack=[UIButton buttonWithType:UIButtonTypeCustom];
    rightUpBtnBack.frame=CGRectMake(_width*0.85, 20,_width*0.8, 30);
    [rightUpBtnBack addTarget:self action:@selector(rightUpBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:rightUpBtnBack];

//    [[NSUserDefaults standardUserDefaults]setObject:@"18691529897" forKey:@"userID"];
    _imageArray=[[NSMutableArray alloc ]init];

    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    //_tableView.rowHeight=400;
    _tableView.scrollEnabled=YES;
    _tableView.separatorColor=[UIColor clearColor];
    [self.view addSubview:_tableView];



    _refesh=[SDRefreshHeaderView refreshView];
    __block mystoryVC*blockSelf=self;
    [_refesh addToScrollView:_tableView];

    _refesh.beginRefreshingOperation=^{
        [blockSelf getData:@"shuaxin"];


    };
    _refesh.isEffectedByNavigationController =NO;
    //下拉刷新
    _refeshDown=[SDRefreshFooterView refreshView];
    [_refeshDown addToScrollView:_tableView];

    _refeshDown.beginRefreshingOperation=^{
        [blockSelf getData:@"more"];


    };



}

-(void)pubStoryBtnClick
{

        PUSH(pubStoryVC)
        vc.whoPush=@"story";
        self.tabBarController.tabBar.hidden=YES;


}

-(void)getData:(NSString*)more
{

    UIImageView*iv=(UIImageView*)[_tableView viewWithTag:22222];
    UILabel*la=(UILabel*)[_tableView viewWithTag:222222];
    [iv removeFromSuperview];
    [la removeFromSuperview];
    LOADVIEW

    //2.加载话题分类列表。
    NSString *str = [NSString stringWithFormat:@"%@/topics/list.action?userId=%@",BASE_URLL,USERID];
    if([more isEqualToString:@"more"]){

        str = [NSString stringWithFormat:@"%@?id=%@&tag=2",str,_currentId];

    }

    [requestData getData:str complete:^(NSDictionary *dic) {
        LOADREMOVE
//        listArray = [dic objectForKey:@"data"];

        [_refesh endRefreshing];
        [_refeshDown endRefreshing];
        NSArray*baseA=[dic objectForKey:@"data"];
//
//         NSLog(@"baseA=%@",baseA);
        if ([more isEqualToString:@"more"]) {
            for (int i=0; i<baseA.count; i++) {
                [listArray addObject:[baseA objectAtIndex:i]];
            }
        }else
        {
            listArray=[NSMutableArray arrayWithArray:baseA];
            
        }
        _currentId = [[listArray lastObject] objectForKey:@"rowNumber"];

        [_tableView reloadData];

        if (listArray.count==0||listArray==nil) {

            UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, (_height-260)/2, 50,50)];
            tanhao.image=[UIImage imageNamed:@"tanhao"];

            [_tableView addSubview:tanhao];

            UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (_height-260)/2+60, _width, 20)];
            tishi.text=@"还没有发布话题！";
            tishi.textColor=[UIColor grayColor];
            tishi.textAlignment=NSTextAlignmentCenter;
            tishi.font=[UIFont systemFontOfSize:14];
            [_tableView addSubview:tishi];

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

            [array1 addObject:modle1];
//             NSLog(@"*****%lu",(unsigned long)array1.count);
            if ((NSNull*)modle1.topocImageList==[NSNull null]) {
            }
        }
        modle1Array =[NSArray arrayWithArray:array1];
        [_tableView reloadData];
        
    }];
    
}
- (NSString *)changeTimeString:(NSString *)timestring
{
    NSDateFormatter *datef= [[NSDateFormatter alloc]init];
    [datef setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSDate *Date= [datef dateFromString:timestring];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [formatter stringFromDate:Date];
}

-(void)backClick
{
        POP
        self.tabBarController.tabBar.hidden=NO;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return modle1Array.count;

}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        Modle *mode =modle1Array[indexPath.row];
    if ((NSNull*)mode.topocImageList==[NSNull null]) {
        return _width*0.025+117-10;
    }else if ((NSNull*)mode.topocImageList!=[NSNull null] && mode.topocImageList.count ==1) {
        return  0.275*_width+52;
    }else if((NSNull*)mode.topocImageList!=[NSNull null] && mode.topocImageList.count==2){
        return  0.37*_width+117;
    }else if((NSNull*)mode.topocImageList!=[NSNull null] && mode.topocImageList.count>=3){
        return  _width*0.275+117;
    }


    return 0;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];

    [tableView setSeparatorInset:UIEdgeInsetsZero];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    Modle *mode =modle1Array[indexPath.row];
//                    NSLog(@"-----%@",mode.topocImageList);


        if ((NSNull*)mode.topocImageList==[NSNull null]){


            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.03, _width*0.025, _width*0.75, 20)];
            [cell addSubview:lab];
            //            lab.backgroundColor=[UIColor greenColor];
            lab.text = mode.topicsTitle;
            lab.font = [UIFont systemFontOfSize:15];

            UILabel *shijianlab = [UILabel new];
            shijianlab.frame = CGRectMake(_width*0.83, _width*0.025, 100, 20);
            shijianlab.textColor =[UIColor darkGrayColor];

//            shijianlab.bounds = CGRectMake(0, 0, 48, 20);
//            shijianlab.center =CGPointMake(_width*0.9, lab.center.y);
            //转换时间，计算时间差
            NSString *datestr = [transformTime prettyDateWithReference:mode.topicsDate];
            shijianlab.text =datestr;

            shijianlab.font = [UIFont systemFontOfSize:13];
            [cell addSubview:shijianlab];

            UILabel *detailLab = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.03, 20+10, _width*0.94, 35)];
            [cell addSubview:detailLab];
            detailLab.numberOfLines=2;
            detailLab.textColor =[UIColor darkGrayColor];
            detailLab.font = [UIFont systemFontOfSize:14];
            detailLab.text = mode.topicsContent;



            _zan_ju_view = [[UIView alloc]initWithFrame:CGRectMake(0, detailLab.frame.origin.y+detailLab.frame.size.height+10, _width, 45)];

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
            _zanlab.text= [NSString stringWithFormat:@"%@",mode.praiseCount] ;
            _zanlab.textColor =[UIColor lightGrayColor];
            _zanlab.font=[UIFont systemFontOfSize:12];
            [_zanBtn addSubview:_zanlab];

            //             //           NSLog(@"%@",_zanlab.text);


            _pinglun = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            _pinglun.frame = CGRectMake(_width*0.83, 5, _width*0.15, 20);
            _pinglun.layer.cornerRadius = 7;
            _pinglun.layer.borderWidth=1;
            _pinglun.layer.borderColor= COR_ClOUR.CGColor;
            [_zan_ju_view addSubview:_pinglun];

            UIImageView *plimag = [[UIImageView alloc]init];
            plimag.frame = CGRectMake(_zanBtn.frame.size.width*0.15, 1.5, 16, 16);
            plimag.image =[UIImage imageNamed:@"ping1"];
            [_pinglun addSubview:plimag];
            _PLlab = [[UILabel alloc]init];

            _PLlab.frame = CGRectMake(_zanBtn.frame.size.width*0.65, 1, 16, 16);
            _PLlab.text=[NSString stringWithFormat:@"%@",mode.commentCount];
            _PLlab.textColor =[UIColor lightGrayColor];
            _PLlab.font=[UIFont systemFontOfSize:12];
            [_pinglun addSubview:_PLlab];

            [cell addSubview: _zan_ju_view];



            UIView*line=[[UIView alloc]initWithFrame:CGRectMake(0, _width*0.025+117-10-10-1, _width, 10)];
            line.backgroundColor=RGB(234, 234, 234);
            [cell addSubview:line];
        }
        else if ((NSNull*)mode.topocImageList!=[NSNull null] && mode.topocImageList.count==1) {
            UIView*line=[[UIView alloc]initWithFrame:CGRectMake(0, 0.275*_width+52-10-1, _width, 10)];
            line.backgroundColor=RGB(234, 234, 234);
            [cell addSubview:line];

            UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(_width*0.03, _width*0.025, _width*0.3, _width*0.25)];

            [cell addSubview:imgv];
            //            imgv.backgroundColor =[UIColor redColor];

            NSString *str =       [mode.topocImageList[0]objectForKey:@"linkImagePath"];

            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",str]];
            [imgv sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {


//                float   w=image.size.width;
//                float   hh=image.size.height;
//                if (hh>w) {
//                    float   h=(image.size.height-w*5/6)/2;
//                    CGRect rect =  CGRectMake(0, h, w, 5*w/6);
//
//                    CGImageRef cgimg = CGImageCreateWithImageInRect([image CGImage], rect);
//
//                    [imgv setImage:[UIImage imageWithCGImage:cgimg]];
//                    CGImageRelease(cgimg);
//
//
//                }else
//                {
//                    float  ww=(w-6*hh/5)/2;
//                    CGRect rect =  CGRectMake(ww, 0, 1.2*hh,hh);
//                    CGImageRef cgimg = CGImageCreateWithImageInRect([image CGImage], rect);
//                    [imgv setImage:[UIImage imageWithCGImage:cgimg]];
//                    CGImageRelease(cgimg);
//
//                }





            }];



            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.35, _width*0.025, _width*0.45, 20)];
            [cell addSubview:lab];
            lab.text = mode.topicsTitle;
            lab.font = [UIFont systemFontOfSize:15];
            UILabel *detailLab = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.35, 20+10, _width*0.6, 35)];
            [cell addSubview:detailLab];
            detailLab.font = [UIFont systemFontOfSize:14];
            detailLab.text = mode.topicsContent;
            detailLab.numberOfLines= 0;
            detailLab.textColor=[UIColor darkGrayColor];
            UILabel *shijianlab = [UILabel new];
            shijianlab.frame = CGRectMake(_width*0.83, _width*0.025, 100, 20);
            shijianlab.textColor =[UIColor darkGrayColor];
//            shijianlab.bounds = CGRectMake(0, 0, 48, 20);
//            shijianlab.center =CGPointMake(_width*0.9, lab.center.y);
            NSString *datestr = [transformTime prettyDateWithReference:mode.topicsDate];
            shijianlab.text =[self changeTimeString: datestr];
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

            //           //           NSLog(@"%@",_zanlab.text);


            _pinglun = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            _pinglun.frame = CGRectMake(_width*0.83, 5, _width*0.15, 20);
            _pinglun.layer.cornerRadius = 7;
            _pinglun.layer.borderWidth=1;
            _pinglun.layer.borderColor= COR_ClOUR.CGColor;
            [_zan_ju_view addSubview:_pinglun];

            UIImageView *plimag = [[UIImageView alloc]init];
            plimag.frame = CGRectMake(_zanBtn.frame.size.width*0.15, 1.5, 16, 16);
            plimag.image =[UIImage imageNamed:@"ping1"];
            [_pinglun addSubview:plimag];
            _PLlab = [[UILabel alloc]init];

            _PLlab.frame = CGRectMake(_zanBtn.frame.size.width*0.65, 1, 16, 16);
            _PLlab.text=[NSString stringWithFormat:@"%@",mode.commentCount];
            _PLlab.textColor =[UIColor lightGrayColor];
            _PLlab.font=[UIFont systemFontOfSize:12];
            [_pinglun addSubview:_PLlab];

            [cell addSubview: _zan_ju_view];




        }else  if((NSNull*)mode.topocImageList!=[NSNull null] && mode.topocImageList.count==2){

            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.03, _width*0.025, _width*0.75, 20)];
            [cell addSubview:lab];
            lab.text = mode.topicsTitle;
            lab.font = [UIFont systemFontOfSize:15];
            UILabel *shijianlab = [UILabel new];
            shijianlab.frame = CGRectMake(_width*0.83, _width*0.025, 100, 20);
            shijianlab.textColor =[UIColor darkGrayColor];
//            shijianlab.bounds = CGRectMake(0, 0, 48, 20);
//            shijianlab.center =CGPointMake(_width*0.9, lab.center.y);
            NSString *datestr = [transformTime prettyDateWithReference:mode.topicsDate];
            shijianlab.text =[self changeTimeString: datestr];
            shijianlab.font = [UIFont systemFontOfSize:13];
            [cell addSubview:shijianlab];


            _smallView=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.03, _width*0.025+25, _width*0.94, _width*0.35)];
            [cell addSubview:_smallView];

            for (int i = 0; i<2; i ++) {

                UIImageView *imagev = [[UIImageView alloc]initWithFrame:CGRectMake(_width*0.94/2*i, 0, _width*0.94/2-_width*0.02, _width*0.35)];

                NSString *str =       [mode.topocImageList[i]objectForKey:@"linkImagePath"];

                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",str]];
                [imagev sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

                }];

                [_smallView addSubview:imagev];

            }


            UIView*line=[[UIView alloc]initWithFrame:CGRectMake(0, 0.37*_width+117-10-1, _width, 10)];
            line.backgroundColor=RGB(234, 234, 234);
            [cell addSubview:line];

            UILabel *dlab = [[UILabel alloc]init];
            dlab.frame =CGRectMake( _smallView.frame.origin.x, _smallView.frame.origin.y+_smallView.frame.size.height+5, _smallView.frame.size.width, 35);
            dlab.text = mode.topicsContent;
            dlab.textColor=[UIColor darkGrayColor];
            dlab.numberOfLines=0;
            dlab.font = [UIFont systemFontOfSize:14];
            [cell addSubview:dlab];

            _zan_ju_view=[[UIView alloc]initWithFrame:CGRectMake(0, dlab.frame.origin.y+dlab.frame.size.height+5, _width, 45)];

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


            _pinglun = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            _pinglun.frame = CGRectMake(_width*0.83, 5, _width*0.15, 20);
            _pinglun.layer.cornerRadius = 7;
            _pinglun.layer.borderWidth=1;
            _pinglun.layer.borderColor= COR_ClOUR.CGColor;
            [_zan_ju_view addSubview:_pinglun];

            UIImageView *plimag = [[UIImageView alloc]init];
            plimag.frame = CGRectMake(_zanBtn.frame.size.width*0.15, 1.5, 16, 16);
            plimag.image =[UIImage imageNamed:@"ping1"];
            [_pinglun addSubview:plimag];
            _PLlab = [[UILabel alloc]init];

            _PLlab.frame = CGRectMake(_zanBtn.frame.size.width*0.65, 1, 16, 16);
            _PLlab.text=[NSString stringWithFormat:@"%@",mode.commentCount];
            _PLlab.textColor =[UIColor lightGrayColor];
            _PLlab.font=[UIFont systemFontOfSize:12];
            [_pinglun addSubview:_PLlab];

            [cell addSubview: _zan_ju_view];

        }
        else if((NSNull*)mode.topocImageList!=[NSNull null] && mode.topocImageList.count>=3)

        {
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.03, _width*0.025, _width*0.75, 20)];
            [cell addSubview:lab];

            lab.text = mode.topicsTitle;
            lab.font = [UIFont systemFontOfSize:15];

            UILabel *shijianlab = [UILabel new];
            shijianlab.frame = CGRectMake(_width*0.83, _width*0.025, 100, 20);
            shijianlab.textColor =[UIColor darkGrayColor];
//            shijianlab.bounds = CGRectMake(0, 0, 48, 20);
//            shijianlab.center =CGPointMake(_width*0.9, lab.center.y);
            NSString *datestr = [transformTime prettyDateWithReference:mode.topicsDate];
            shijianlab.text =[self changeTimeString: datestr];
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


            UIView*line=[[UIView alloc]initWithFrame:CGRectMake(0, _width*0.275+117-10-1, _width, 10)];
            line.backgroundColor=RGB(234, 234, 234);
            [cell addSubview:line];

            UILabel *dlab = [[UILabel alloc]init];
            dlab.frame =CGRectMake( _smallView.frame.origin.x, _smallView.frame.origin.y+_smallView.frame.size.height+10, _smallView.frame.size.width, 40);
            dlab.text = mode.topicsContent;
            //            dlab.backgroundColor=[UIColor darkGrayColor];
            dlab.numberOfLines=0;
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
            
            //            //           NSLog(@"%@",_zanlab.text);
            
            
            _pinglun = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            _pinglun.frame = CGRectMake(_width*0.83, 5, _width*0.15, 20);
            _pinglun.layer.cornerRadius = 7;
            _pinglun.layer.borderWidth=1;
            _pinglun.layer.borderColor= COR_ClOUR.CGColor;
            [_zan_ju_view addSubview:_pinglun];
            
            UIImageView *plimag = [[UIImageView alloc]init];
            plimag.frame = CGRectMake(_zanBtn.frame.size.width*0.15, 1.5, 16, 16);
            plimag.image =[UIImage imageNamed:@"ping1"];
            [_pinglun addSubview:plimag];
            _PLlab = [[UILabel alloc]init];
            
            _PLlab.frame = CGRectMake(_zanBtn.frame.size.width*0.65, 1, 16, 16);
            _PLlab.textColor =[UIColor lightGrayColor];
            _PLlab.text=[NSString stringWithFormat:@"%@",mode.commentCount];
            _PLlab.font=[UIFont systemFontOfSize:12];
            [_pinglun addSubview:_PLlab];
            
            [cell addSubview: _zan_ju_view];
            
            
            
            
            
        }
        
        



    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PUSH(detailViewController)
    vc.whoPush = @"wode";

    vc.topicsId =[modle1Array[indexPath.row] topicsId];


}



-(BOOL)shouldAutorotate
{
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)imgbtn:(UIButton *)button{
    NSLog(@"..........%ld",(long)button.tag);
}
-(void)rightUpBtnClick
{
    PUSH(pubStoryVC)

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
