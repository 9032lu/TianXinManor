//
//  luntanViewController.m
//  PsychiatricConsulting
//
//  Created by mac on 15-8-30.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "luntanViewController.h"
#import "jubaoVC.h"
#import "Modle.h"
#import "transformTime.h"
#import "detailViewController.h"
#import "myButton.h"

@interface luntanViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    SCREEN_WIDTH_AND_HEIGHT
    UITableView *tableview;

    SDRefreshHeaderView     *_refesh;
    SDRefreshFooterView     *_refeshDown;

    NSString                *_currentId;
    NSMutableArray *_dataArray;

    NSMutableArray *Mdarray;
    UIImageView    *_smallView;



}
@end

@implementation luntanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    TOP_VIEW(self.titleName);
//    NSLog(@"%@===%@",self.titleName,self.interactiveId);
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64) style:UITableViewStyleGrouped];
    tableview.delegate=self;
    tableview.dataSource=self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    [self getdata:@""];

    //上提刷新
    _refesh=[SDRefreshHeaderView refreshView];
    __block luntanViewController*blockSelf=self;
    [_refesh addToScrollView:tableview];

    _refesh.beginRefreshingOperation=^{
        [blockSelf getdata:@"shuaxin"];

    };
    _refesh.isEffectedByNavigationController =NO;
    //下拉刷新
    _refeshDown=[SDRefreshFooterView refreshView];
    [_refeshDown addToScrollView:tableview];

    _refeshDown.beginRefreshingOperation=^{
        [blockSelf getdata:@"more"];

        
    };


}

-(void)getdata:(NSString*)more {
    UIImageView*iv=(UIImageView*)[tableview viewWithTag:22222];
    UILabel*la=(UILabel*)[tableview viewWithTag:222222];
    [iv removeFromSuperview];
    [la removeFromSuperview];

    NSString*str=[NSString stringWithFormat:@"%@/topics/list.action" ,BASE_URLL];




    if (self.interactiveId!=nil) {
        str=[NSString stringWithFormat:@"%@?interactiveId=%d",str,[_interactiveId intValue]];
    }
    LOADVIEW
    if ([more isEqualToString:@"more"]) {
        str=[NSString stringWithFormat:@"%@&id=%@&tag=2",str,_currentId];
    }

    [requestData getData:str complete:^(NSDictionary *dic) {
        LOADREMOVE
        [_refesh endRefreshing];
        [_refeshDown endRefreshing];

        NSArray*baseA=[dic objectForKey:@"data"];

        if ([more isEqualToString:@"more"]) {
            for (int i=0; i<baseA.count; i++) {
                [_dataArray addObject:[baseA objectAtIndex:i]];
            }
        }else
        {
            _dataArray=[NSMutableArray arrayWithArray:baseA];
            
        }
        _currentId=[[_dataArray lastObject] objectForKey:@"rowNumber"];

        Mdarray =[[NSMutableArray alloc]initWithCapacity:_dataArray.count];

        for (NSDictionary *dict in _dataArray) {

             Modle *MD = [[Modle alloc]init];

            MD.typeName = dict[@"typeName"];//类别
            MD.topicsTitle = dict[@"topicsTitle"];//主题
            MD.topicsContent = dict[@"topicsContent"];//内容
            MD.userId = dict[@"userId"];//用户账号
            MD.topocImageList =dict[@"topocImageList"];//内容图片
            MD.praiseCount = dict[@"praiseCount"];//点赞数
            MD.commentCount=dict[@"commentCount"];//评论数
            MD.topicsDate=dict[@"topicsDate"];//发表时间
            MD.nickName=dict[@"nickName"];
            MD.topicsId=dict[@"topicsId"];
            [Mdarray addObject:MD];

        }
//        NSLog(@"mdarray==%@",Mdarray);

//        _currentId=[[_dataArray lastObject] objectForKey:@"productId"];

        [tableview reloadData];

        if (_dataArray.count==0||_dataArray==nil) {

            UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, (_height-260)/2, 50,50)];
            tanhao.image=[UIImage imageNamed:@"tanhao"];

            [tableview addSubview:tanhao];

            UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (_height-260)/2+60, _width, 20)];
            tishi.text=@"没有相关的话题！";
            tishi.textColor=[UIColor grayColor];
            tishi.textAlignment=NSTextAlignmentCenter;
            tishi.font=[UIFont systemFontOfSize:14];
            [tableview addSubview:tishi];
            
            tanhao.tag=22222;
            tishi.tag=222222;
        }
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;

}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    Modle *mode =Mdarray[indexPath.row];
    if ((NSNull*)mode.topocImageList==[NSNull null]) {
        return _width*0.025+117-10;
    }else if ((NSNull*)mode.topocImageList!=[NSNull null] && mode.topocImageList.count ==1) {
        return  0.275*_width+52;
    }else if((NSNull*)mode.topocImageList!=[NSNull null] && mode.topocImageList.count==2){
        return  0.37*_width+117;
    }else if((NSNull*)mode.topocImageList!=[NSNull null] && mode.topocImageList.count>=3){
        return  _width*0.275+117;
    }





       return 0.1;

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Modle *mode =Mdarray[indexPath.row];
//    static NSString *cellID = @"cellID";
//    UITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
//    if (cellID==nil) {
       UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
//    }
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    if ((NSNull*)mode.topocImageList==[NSNull null]){


        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.03, _width*0.025, _width*0.75, 20)];
        [cell addSubview:lab];
        //            lab.backgroundColor=[UIColor greenColor];
        lab.text = mode.topicsTitle;
        lab.font = [UIFont systemFontOfSize:15];

        UILabel *shijianlab = [UILabel new];
        shijianlab.frame = CGRectMake(_width*0.83, _width*0.025, 100, 20);
        shijianlab.textColor =[UIColor darkGrayColor];
//        shijianlab.bounds = CGRectMake(0, 0, 48, 20);
//        shijianlab.center =CGPointMake(_width*0.9, lab.center.y);
        NSString *datestr = [transformTime prettyDateWithReference:mode.topicsDate];
        shijianlab.text = datestr;
        shijianlab.font = [UIFont systemFontOfSize:13];
        [cell addSubview:shijianlab];

        UILabel *detailLab = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.03, 20+10, _width*0.94, 35)];
        [cell addSubview:detailLab];
        detailLab.numberOfLines=2;
        detailLab.font = [UIFont systemFontOfSize:14];
        detailLab.text = mode.topicsContent;
        detailLab.textColor =[UIColor darkGrayColor];

        _zan_ju_view=[[UIView alloc]initWithFrame:CGRectMake(0, detailLab.frame.origin.y+detailLab.frame.size.height+10, _width, 45)];
        //             _zan_ju_view.backgroundColor = [UIColor redColor];

        _typen=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        _typen.frame=CGRectMake(10, 5, _width*0.15, 20);
        [_typen setTitle:mode.typeName forState:UIControlStateNormal];
        _typen.titleLabel.font = [UIFont systemFontOfSize:12];
        [_typen setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _typen.layer.cornerRadius = 7;
        _typen.layer.borderWidth=1;
        _typen.layer.borderColor=COR_ClOUR.CGColor;
        //             _typen.layer.borderColor= [UIColor redColor].CGColor;

        [_zan_ju_view addSubview:_typen];

        _zanBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _zanBtn.frame = CGRectMake(_width*0.62, 5, _width*0.15, 20);
        _zanBtn.layer.cornerRadius = 7;
        _zanBtn.layer.borderWidth=1;
        _zanBtn.layer.borderColor= COR_ClOUR.CGColor;
        [_zan_ju_view addSubview:_zanBtn];
        myButton *zanbutton = [[myButton alloc]initWithFrame:CGRectMake(_width*0.62, 0, _width*0.15, 44)];
        //           zanbutton.backgroundColor =[UIColor redColor];
        zanbutton.IDstring = mode;
        [zanbutton addTarget:self action:@selector(zanclick:) forControlEvents:(UIControlEventTouchUpInside)];

        [_zan_ju_view addSubview:zanbutton];

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
        _PLlab.textColor=[UIColor lightGrayColor];
        _PLlab.font=[UIFont systemFontOfSize:12];
        [_pinglun addSubview:_PLlab];

        [cell addSubview: _zan_ju_view];



        UIView*line=[[UIView alloc]initWithFrame:CGRectMake(0, _width*0.025+117-10-1-10, _width, 10)];
        line.backgroundColor=RGB(234, 234, 234);
        [cell addSubview:line];
    }
    else if ((NSNull*)mode.topocImageList!=[NSNull null] && mode.topocImageList.count==1) {
        UIView*line=[[UIView alloc]initWithFrame:CGRectMake(0, 0.275*_width+52-10-1, _width, 10)];
        line.backgroundColor=RGB(234, 234, 234);
        [cell addSubview:line];

        UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(_width*0.03, _width*0.025, _width*0.3, _width*0.25)];

        [cell addSubview:imgv];

        NSString *str =       [mode.topocImageList[0]objectForKey:@"linkImagePath"];

        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",str]];
        [imgv sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {


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



        }];



        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.35, _width*0.025, _width*0.45, 20)];
        [cell addSubview:lab];
        lab.text = mode.topicsTitle;
        lab.font = [UIFont systemFontOfSize:15];
        UILabel *detailLab = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.35, 20+10, _width*0.6, 35)];
        [cell addSubview:detailLab];
        detailLab.font = [UIFont systemFontOfSize:14];
        detailLab.numberOfLines=2;
        detailLab.textColor =[UIColor darkGrayColor];
        detailLab.text = mode.topicsContent;

        UILabel *shijianlab = [UILabel new];
        shijianlab.frame = CGRectMake(_width*0.83, _width*0.025, 100, 20);
        shijianlab.textColor =[UIColor darkGrayColor];
//        shijianlab.bounds = CGRectMake(0, 0, 48, 20);
//        shijianlab.center =CGPointMake(_width*0.9, lab.center.y);
        NSString *datestr = [transformTime prettyDateWithReference:mode.topicsDate];
        shijianlab.text = datestr;
        shijianlab.font = [UIFont systemFontOfSize:13];
        [cell addSubview:shijianlab];


        _zan_ju_view=[[UIView alloc]initWithFrame:CGRectMake(0, imgv.frame.origin.y+imgv.frame.size.height+10, _width, 45)];

        _typen=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        _typen.frame=CGRectMake(10, 5, _width*0.15, 20);
        [_typen setTitle:mode.typeName forState:UIControlStateNormal];
        _typen.titleLabel.font = [UIFont systemFontOfSize:12];
        [_typen setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _typen.layer.cornerRadius = 7;
        _typen.layer.borderWidth=1;
        _typen.layer.borderColor=COR_ClOUR.CGColor;

        [_zan_ju_view addSubview:_typen];

        _zanBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _zanBtn.frame = CGRectMake(_width*0.62, 5, _width*0.15, 20);
        _zanBtn.layer.cornerRadius = 7;
        _zanBtn.layer.borderWidth=1;
        _zanBtn.layer.borderColor= COR_ClOUR.CGColor;
        [_zan_ju_view addSubview:_zanBtn];
        myButton *zanbutton = [[myButton alloc]initWithFrame:CGRectMake(_width*0.62, 0, _width*0.15, 44)];
        //           zanbutton.backgroundColor =[UIColor redColor];
        zanbutton.IDstring = mode;
        [zanbutton addTarget:self action:@selector(zanclick:) forControlEvents:(UIControlEventTouchUpInside)];

        [_zan_ju_view addSubview:zanbutton];

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
//        shijianlab.bounds = CGRectMake(0, 0, 48, 20);
//        shijianlab.center =CGPointMake(_width*0.9, lab.center.y);
        NSString *datestr = [transformTime prettyDateWithReference:mode.topicsDate];
        shijianlab.text = datestr;
        shijianlab.font = [UIFont systemFontOfSize:13];
        [cell addSubview:shijianlab];


        _smallView=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.03, _width*0.025+25, _width*0.94, _width*0.35)];
        [cell addSubview:_smallView];

        for (int i = 0; i<2; i ++) {

            UIImageView *imagev = [[UIImageView alloc]initWithFrame:CGRectMake(_width*0.94/2*i, 0, _width*0.94/2-2, _width*0.35)];

            NSString *str =       [mode.topocImageList[i]objectForKey:@"linkImagePath"];

            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",str]];
            [imagev sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {



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


        UIView*line=[[UIView alloc]initWithFrame:CGRectMake(0, 0.37*_width+117-10-1, _width, 10)];
        line.backgroundColor=RGB(234, 234, 234);
        [cell addSubview:line];

        UILabel *dlab = [[UILabel alloc]init];
        dlab.frame =CGRectMake( _smallView.frame.origin.x, _smallView.frame.origin.y+_smallView.frame.size.height+5, _smallView.frame.size.width, 35);
        dlab.text = mode.topicsContent;
        dlab.textColor=[UIColor darkGrayColor];
        dlab.numberOfLines=2;
        dlab.font = [UIFont systemFontOfSize:14];
        [cell addSubview:dlab];

        _zan_ju_view=[[UIView alloc]initWithFrame:CGRectMake(0, dlab.frame.origin.y+dlab.frame.size.height+5, _width, 45)];

        _typen=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        _typen.frame=CGRectMake(10, 5, _width*0.15, 20);
        [_typen setTitle:mode.typeName forState:UIControlStateNormal];
        _typen.titleLabel.font = [UIFont systemFontOfSize:12];
        [_typen setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        _typen.layer.cornerRadius = 7;
        _typen.layer.borderWidth=1;
        _typen.layer.borderColor= COR_ClOUR.CGColor;
        [_zan_ju_view addSubview:_typen];

        _zanBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _zanBtn.frame = CGRectMake(_width*0.62, 5, _width*0.15, 20);
        _zanBtn.layer.cornerRadius = 7;
        _zanBtn.layer.borderWidth=1;
        _zanBtn.layer.borderColor= COR_ClOUR.CGColor;
        [_zan_ju_view addSubview:_zanBtn];
        myButton *zanbutton = [[myButton alloc]initWithFrame:CGRectMake(_width*0.62, 0, _width*0.15, 44)];
        //           zanbutton.backgroundColor =[UIColor redColor];
        zanbutton.IDstring = mode;
        [zanbutton addTarget:self action:@selector(zanclick:) forControlEvents:(UIControlEventTouchUpInside)];

        [_zan_ju_view addSubview:zanbutton];

        UIImageView *zanimag = [[UIImageView alloc]init];
        zanimag.frame = CGRectMake(_zanBtn.frame.size.width*0.15, 1, 16, 16);
        zanimag.image =[UIImage imageNamed:@"zan2"];
        [_zanBtn addSubview:zanimag];
        _zanlab = [[UILabel alloc]init];
        _zanlab.frame = CGRectMake(_zanBtn.frame.size.width*0.65, 1, 16, 16);
        _zanlab.textColor=[UIColor lightGrayColor];
        _zanlab.text= [NSString stringWithFormat:@"%@",mode.praiseCount] ;
        _zanlab.font=[UIFont systemFontOfSize:12];
        [_zanBtn addSubview:_zanlab];

        //           NSLog(@"%@",_zanlab.text);


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
        _PLlab.textColor=[UIColor lightGrayColor];
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
//        shijianlab.bounds = CGRectMake(0, 0, 48, 20);
//        shijianlab.center =CGPointMake(_width*0.9, lab.center.y);
        NSString *datestr = [transformTime prettyDateWithReference:mode.topicsDate];
        shijianlab.text =datestr;
        shijianlab.font = [UIFont systemFontOfSize:13];
        [cell addSubview:shijianlab];




        _smallView=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.03, _width*0.025+25, _width*0.94, _width*0.25)];

        [cell addSubview:_smallView];

        for (int i = 0; i<3; i ++) {


            UIImageView *imagev = [[UIImageView alloc]initWithFrame:CGRectMake(_width*0.32*i, 0, _width*0.3, _width*0.25)];

            NSString *str =       [mode.topocImageList[i]objectForKey:@"linkImagePath"];

            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",str]];
            [imagev sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {



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


        UIView*line=[[UIView alloc]initWithFrame:CGRectMake(0, _width*0.275+117-10-1, _width, 10)];
        line.backgroundColor=RGB(234, 234, 234);
        [cell addSubview:line];

        UILabel *dlab = [[UILabel alloc]init];
        dlab.frame =CGRectMake( _smallView.frame.origin.x, _smallView.frame.origin.y+_smallView.frame.size.height+10, _smallView.frame.size.width, 40);
        dlab.text = mode.topicsContent;
        dlab.textColor =[UIColor darkGrayColor];
        //            dlab.backgroundColor=[UIColor darkGrayColor];
        dlab.numberOfLines=2;
        dlab.font = [UIFont systemFontOfSize:14];
        [cell addSubview:dlab];

        _zan_ju_view=[[UIView alloc]initWithFrame:CGRectMake(0, dlab.frame.origin.y+dlab.frame.size.height,_width*0.6, _width*0.1)];
        //            _zan_ju_view.backgroundColor = [UIColor redColor];

        _typen=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        _typen.frame=CGRectMake(10, 5, _width*0.15, 20);
        [_typen setTitle:mode.typeName forState:UIControlStateNormal];
        _typen.titleLabel.font = [UIFont systemFontOfSize:12];
        [_typen setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _typen.layer.cornerRadius = 7;
        _typen.layer.borderWidth=1;
        _typen.layer.borderColor= COR_ClOUR.CGColor;

        [_zan_ju_view addSubview:_typen];

        _zanBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _zanBtn.frame = CGRectMake(_width*0.62, 5, _width*0.15, 20);
        _zanBtn.layer.cornerRadius = 7;
        _zanBtn.layer.borderWidth=1;
        _zanBtn.layer.borderColor= COR_ClOUR.CGColor;
        [_zan_ju_view addSubview:_zanBtn];
        myButton *zanbutton = [[myButton alloc]initWithFrame:CGRectMake(_width*0.62, 0, _width*0.15, 44)];
        //           zanbutton.backgroundColor =[UIColor redColor];
        [zanbutton addTarget:self action:@selector(zanclick:) forControlEvents:(UIControlEventTouchUpInside)];
        zanbutton.IDstring = mode;
        [_zan_ju_view addSubview:zanbutton];

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

        [cell addSubview: _zan_ju_view];





    }
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PUSH(detailViewController)
    vc.topicsId =[Mdarray[indexPath.row] topicsId];

}

-(void)pingbutton:(UIButton*)button{
    PUSH(detailViewController)
    vc.topicsId =[Mdarray[button.tag] topicsId];

}
-(void)backClick{
    POP
}
-(void)jubao:(UIButton*)button{
    NSLog(@"举报");
    PUSH(jubaoVC)
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

-(void)zanclick:(myButton *)button{


    //            NSLog(@"%@////%@////",modle.userId,button.IDstring);

    if (USERID!=nil) {
        //            NSDictionary*dic=[_dataArray objectAtIndex:button.tag];
        //            //NSString*userId=[dic objectForKey:@"userId"];
        //            NSString*storyId=[dic objectForKey:@"storyId"];


        [requestData getData:STORY_LIST_ZAN_URL(button.IDstring.userId,button.IDstring.topicsId) complete:^(NSDictionary *dic) {
            NSLog(@"%@",dic);
            MISSINGVIEW
            if ([[dic objectForKey:@"flag"] intValue]==0) {
                missing_v.tishi=[NSString stringWithFormat:@"%@",@"已点赞"];
                NSLog(@" miss");

            }else
            {
                missing_v.tishi=[NSString stringWithFormat:@"%@",@"点赞成功"];
                self.isdianzan=YES;
                [self getdata:@""];

            }

        }];

    }else
    {

    }



    NSLog(@"赞");
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
