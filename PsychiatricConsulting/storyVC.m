//
//  storyVC.m
//  logRegister
//
//  Created by apple on 15-3-14.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "storyVC.h"

#import "storyListCell.h"
#import "jubaoVC.h"
#import "webViewVC.h"
#import "mystoryVC.h"
#import "logInVC.h"
#import "pubStoryVC.h"
#import "logInVC.h"
#import "hospitalVC.h"
@interface storyVC ()

@end

@implementation storyVC


- (void)viewDidLoad {

    [super viewDidLoad];
    NSLog(@"2");

    SCREEN


    self.navigationController.navigationBarHidden=YES;
    TOP_VIEW(@"晒一晒")
    backBtn.image=[UIImage imageNamed:@"未标题-1(4)"];
    backBtn.frame=CGRectMake(_width*0.05, 30, 20, 20);


    //backBtn.hidden=YES;

    UIButton*pubStory=[UIButton buttonWithType:UIButtonTypeCustom];
    pubStory.frame=CGRectMake(_width*0.8, 20, _width*0.2, 44);
    [pubStory setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[pubStory setTitle:@"发布" forState:UIControlStateNormal];
    //[pubStory setBackgroundImage:[UIImage imageNamed:@"diandian"] forState:UIControlStateNormal];
    UIImageView*diandian=[[UIImageView alloc]initWithFrame:CGRectMake((_width*0.2-25)/2, 20, 25, 4)];
    diandian.image=[UIImage imageNamed:@"diandian"];
    [pubStory addSubview:diandian];

    pubStory.titleLabel.font=[UIFont systemFontOfSize:15];
    [pubStory addTarget:self action:@selector(pubStoryBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pubStory];


//    UIButton*myStory=[UIButton buttonWithType:UIButtonTypeCustom];
//    myStory.frame=CGRectMake(0, 20, _width*0.2, 44);
//
//    //    NSString *face=[[NSUserDefaults standardUserDefaults] objectForKey:@"face"];
//    UIImageView*ImageView=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.05, 10, 20, 20)];
//    ImageView.image=[UIImage imageNamed:@"gerenzhongx"];
//    [myStory addSubview:ImageView];
//
//    [myStory addTarget:self action:@selector(myStoryBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:myStory];



    _imageArray=[[NSMutableArray alloc ]initWithCapacity:0];





    [_tableView removeFromSuperview];

    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64-self.tabBarController.tabBar.frame.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;

    _tableView.scrollEnabled=YES;
    _tableView.separatorColor=[UIColor clearColor];
    [self.view addSubview:_tableView];

    _refesh=[SDRefreshHeaderView refreshView];
    [_refesh addToScrollView:_tableView];
    __block storyVC*blockSelf=self;
    _refesh.beginRefreshingOperation=^{
        [blockSelf getStoryList:@""];


    };
    _refesh.isEffectedByNavigationController=NO;

    _refeshDown=[SDRefreshFooterView refreshView];
    [_refeshDown addToScrollView:_tableView];

    _refeshDown.beginRefreshingOperation=^{
        [blockSelf getStoryList:@"1"];


    };
    _refeshDown.isEffectedByNavigationController=NO;

    //[self getStoryList];


}
-(void)getStoryList:(NSString*)more
{


    UIImageView*imagev=(UIImageView*)[_tableView viewWithTag:22222];
    UILabel*tishila=(UILabel*)[_tableView viewWithTag:2222];
    [imagev removeFromSuperview];
    [tishila removeFromSuperview];


    NSString*url=[NSString stringWithFormat:@"%@&size=%@",STORY_LIST_URL(@"2"),@"5"];

    int size=5;
    _currentSize=size;
    if ([more intValue]==1) {
        static int i=1;
        i++;
        url=[NSString stringWithFormat:@"%@&size=%d",STORY_LIST_URL(@"2"),size*i];
        _currentSize=size*i;
    }


    if (self.isdianzan) {
        NSLog(@"=========%d",_currentSize);
         url=[NSString stringWithFormat:@"%@&size=%d",STORY_LIST_URL(@"2"),_currentSize];

    }
    LOADVIEW

    NSLog(@"%@",url);
    [requestData getData:url complete:^(NSDictionary *dic) {
        LOADREMOVE

        // NSLog(@"%@=========",dic);

        [_refesh endRefreshing];
        [_refeshDown endRefreshing];

        _dataArray=[[dic objectForKey:@"data"] objectForKey:@"storyList"];
        NSArray*nullA=@[];
        if (_dataArray==nil||_dataArray==nullA) {

            UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, (_height-60)/2, 50,50)];
            tanhao.image=[UIImage imageNamed:@"tanhao"];
            [_tableView addSubview:tanhao];

            UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (_height-60)/2+60, _width, 20)];
            tishi.text=@"暂无分享..";
            tishi.textColor=[UIColor grayColor];
            tishi.textAlignment=NSTextAlignmentCenter;
            tishi.font=[UIFont systemFontOfSize:14];
            [_tableView addSubview:tishi];
            tanhao.tag=22222;
            tishi.tag=2222;

            
            return ;
        }
        //NSLog(@"---%d",_dataArray.count);
        [_tableView reloadData];

        //数据请求回来后开启定时器

    }];

    NSLog(@"%@",STORY_AD_URL);
    [requestData getData:STORY_AD_URL complete:^(NSDictionary *dic) {
       NSLog(@"%@=========",dic);

        _advistArray=[dic objectForKey:@"data"];
        NSArray*nullA=@[];
        if (_advistArray==nil||_advistArray==nullA) {
            return ;
        }

        [_tableView reloadData];



    }];


}

-(void)pubStoryBtnClick
{
    if (USERID!=nil) {
        PUSH(pubStoryVC)
        vc.whoPush=@"story";
        self.tabBarController.tabBar.hidden=YES;

    }else
    {
        ALLOC(logInVC)
        [self presentViewController:vc animated:YES completion:^{

        }];
    }

}
-(void)myStoryBtnClick
{


}


-(void)advistBtn:(UIButton*)button
{
//    NSString*advUrl=[[_advistArray objectAtIndex:button.tag] objectForKey:@"advUrl"];
//
//     NSLog(@"dvbhjkl\\\\\\\\%@",advUrl);


//    if ([advUrl isEqualToString:@"#"]) {
//        return;
//    }
//    webViewVC*vc=[[webViewVC alloc]init];
//    self.tabBarController.tabBar.hidden=YES;
//    vc.url=advUrl;
//
//    [self.navigationController pushViewController:vc animated:YES];

    NSDictionary*dic=[_advistArray objectAtIndex:button.tag];
    NSString*url=[dic objectForKey:@"advUrl"];


    //
    if (url.length==0||[url isEqualToString:@"#"]) {

        return;
    }else if([url hasPrefix:@"http:"])
    {
        PUSH(webViewVC)
        vc.url=url;
    }else{

        PUSH(hospitalVC);
        vc.shopId=url;
        
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {

        UIView*bgview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 170)];

        _smallScrollV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _width, 170)];
        _smallScrollV.contentSize=CGSizeMake(_width*_advistArray.count, 170);
        _smallScrollV.pagingEnabled=YES;
        _smallScrollV.bounces=NO;
        _smallScrollV.backgroundColor=[UIColor redColor];
//        NSLog(@"jjjjjjj%d",_advistArray.count);


        if (_advistArray.count==0) {
            UIImageView*imagev=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _width, 170)];
            imagev.image=[UIImage imageNamed:@"chang"];
            [_smallScrollV addSubview:imagev];
        }else{
            for (int i=0; i<_advistArray.count; i++) {
               // NSLog(@"hhhhhh");
                UIButton*view=[UIButton buttonWithType:UIButtonTypeCustom];
                [view sd_setBackgroundImageWithURL:[NSURL URLWithString:[[_advistArray objectAtIndex:i] objectForKey:@"advImage"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"chang.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    NSLog(@"url===llllllll===%@",imageURL);

                }];
                view.frame=CGRectMake(_width*i, 0, _width, 170);
                view.tag=i;
                view.backgroundColor=[UIColor darkGrayColor];
                if (i==2) {
                    view.backgroundColor=[UIColor redColor];
                }
                [view addTarget:self action:@selector(advistBtn:) forControlEvents:UIControlEventTouchUpInside];
                //view.backgroundColor=[UIColor yellowColor];
                [_smallScrollV addSubview:view];
            }
        }



        _pc=[[UIPageControl alloc]initWithFrame:CGRectMake(0, 140, _width, 30)];
        _pc.currentPage=0;
        _pc.numberOfPages=_advistArray.count;
        if (_advistArray.count==1) {
            _pc.currentPageIndicatorTintColor=[UIColor clearColor];
        }
        _pc.currentPageIndicatorTintColor=[UIColor whiteColor];


        [bgview addSubview:_smallScrollV];
        [bgview addSubview:_pc];

        return bgview;

    }else
    {
        return nil;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 170;
    }else
    {
        return 10;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

          return 10;


}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //NSLog(@"%ld",(unsigned long)_dataArray.count);


    if (_dataArray.count==0) {
        if (_advistArray.count>0) {
            return 1;
        }else
        {
            return 0;
        }
    }else{
        return _dataArray.count;

    }




}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    storyListCell*cell=[[storyListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (_dataArray.count==0) {
        cell.hidden=YES;

    }else{


        NSDictionary*dic=[_dataArray objectAtIndex:indexPath.section];

       // NSLog(@"%d----%d",_dataArray.count,indexPath.section);

   // id  userId=[dic objectForKey:@"userId"];
        NSString*userId=[dic objectForKey:@"userId"];
        id nickName=[dic objectForKey:@"nickName"];
        if (nickName==[NSNull null]||[nickName isEqualToString:@"(null)"]) {
            cell.userName.text=[NSString stringWithFormat:@"%@****%@",[userId substringToIndex:3],[userId substringFromIndex:8]];
        }else
        {
            cell.userName.text=nickName;
        }

        NSString*createTime=[dic objectForKey:@"createTime"];
        NSString*storyContent=[dic objectForKey:@"storyContent"];
        //NSString*storyId=[dic objectForKey:@"storyId"];


        id face=[dic objectForKey:@"face"];
        if (face==[NSNull null]) {
            face=nil;
        }

        [cell.userFace sd_setImageWithURL:[NSURL URLWithString:face]
                         placeholderImage: [UIImage imageNamed:@"1024.png"]];

        //设置用户信息
        //cell.userName.text=userId;
        cell.pubTime.text=createTime;
        cell.collectNum.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"count"]];
        //计算内容高度

        float h1;

        cell.pubContent.text=[NSString stringWithFormat:@"%@",storyContent];

            h1=[self boundWithSize:CGSizeMake(_width*0.94, 0) WithLabel:cell.pubContent].height;
            cell.pubContent.frame=CGRectMake(_width*0.03, 55, _width*0.94,h1+10);




        //计算图片高度
        NSArray*imageListArray=nil;
        id storyImage=[dic objectForKey:@"storyImage"];
        if (storyImage==[NSNull null]) {
            imageListArray=nil;
        }else
        {
            imageListArray=[dic objectForKey:@"storyImage"];
        }



        for (int i=0; i<imageListArray.count; i++) {
            int X=i%3;
            int Y=i/3;
            UIButton*image_B=[UIButton buttonWithType:UIButtonTypeCustom];
            image_B.frame=CGRectMake(0+_width*0.32*X, _width*0.27*Y, _width*0.3, _width*0.25);
            image_B.tag=i;
            //        [image_B sd_setBackgroundImageWithURL:[NSURL URLWithString:[[imageListArray objectAtIndex:i] objectForKey:@"storyPath"]]
            //         forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"morentu"]];
            [image_B sd_setBackgroundImageWithURL:[NSURL URLWithString:[[imageListArray objectAtIndex:i] objectForKey:@"storyPath"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image==nil) {
                    image=[UIImage imageNamed:@"fang"];
                }
                float   w=image.size.width;
                float   hh=image.size.height;
                if (hh>w) {
                    float   h=(image.size.height-w*5/6)/2;
                    CGRect rect =  CGRectMake(0, h, w, 5*w/6);

                    CGImageRef cgimg = CGImageCreateWithImageInRect([image CGImage], rect);
                    [image_B setBackgroundImage:[UIImage imageWithCGImage:cgimg] forState:UIControlStateNormal];
                     CGImageRelease(cgimg);


                }else
                {
                    float  ww=(w-6*hh/5)/2;
                    CGRect rect =  CGRectMake(ww, 0, 1.2*hh,hh);
                    CGImageRef cgimg = CGImageCreateWithImageInRect([image CGImage], rect);
                    [image_B setBackgroundImage:[UIImage imageWithCGImage:cgimg] forState:UIControlStateNormal];
                     CGImageRelease(cgimg);

                }


            }];

            [image_B addTarget:self action:@selector(ImageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.manyImageV addSubview:image_B];
            cell.manyImageV.tag=indexPath.section;
        }




        if (imageListArray.count==0)
        {
            cell.manyImageV.frame=CGRectMake(_width*0.03, h1+75, _width*0.94, 10);
            cell.lowView.frame=CGRectMake(0, h1+85, _width, 100);
        }else if(imageListArray.count>=1&&imageListArray.count<=3)
        {

            cell.manyImageV.frame=CGRectMake(_width*0.03, h1+75, _width*0.94, _width*0.25);
            cell.lowView.frame=CGRectMake(0, h1+75+_width*0.25, _width, 100);
        }else if (imageListArray.count>3&&imageListArray.count<=6)
        {
            cell.manyImageV.frame=CGRectMake(_width*0.03, h1+75, _width*0.94, _width*0.52);
            cell.lowView.frame=CGRectMake(0, h1+75+_width*0.52, _width, 100);
        }
        else if (imageListArray.count>6&&imageListArray.count<=9)
        {
            cell.manyImageV.frame=CGRectMake(_width*0.03, h1+75, _width*0.94,_width*0.79);
            cell.lowView.frame=CGRectMake(0, h1+75+_width*0.79, _width, 100);
        }
        if (cell.pubContent.text.length>50) {
            cell.lowView.frame=CGRectMake(0,cell.lowView.frame.origin.y, _width, 100);

        }

        cell.jubao.tag=indexPath.section;
        [cell.jubao addTarget:self action:@selector(jubao:) forControlEvents:UIControlEventTouchUpInside];

        cell.zanBtn.tag=indexPath.section;
        [cell.zanBtn addTarget:self action:@selector(zanBtn:) forControlEvents:UIControlEventTouchUpInside];


        id faceArray=[dic objectForKey:@"faceList"];
        if (faceArray==[NSNull null]) {
            cell.zan_ju_view.frame=CGRectMake(0, 10, _width, 45);
            
            
        }else
        {
            NSArray*faceAr=(NSArray*)faceArray;
            
            for (int i=0; i<faceAr.count; i++) {
                
                UIButton*image=[UIButton buttonWithType:UIButtonTypeCustom];
                image.frame=CGRectMake(_width*0.03+35*i,15,30, 30);
                image.tag=i;
                [image sd_setBackgroundImageWithURL:[[faceAr objectAtIndex:i] objectForKey:@"face"]
                                           forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"1024"]];
                //[image addTarget:self action:@selector(ImageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                image.layer.cornerRadius=15;
                image.clipsToBounds=YES;
                [cell.lowView addSubview:image];
                
            }
            
        }



    }





    return cell;
}
//文字收缩
-(void)moreBtnClick:(UIButton*)button
{
    if (!button.selected) {
        button.selected=YES;
        [button setTitle:@"收回" forState:UIControlStateNormal];
        NSIndexPath*indexPath=[NSIndexPath indexPathForRow:0 inSection:button.tag];
        storyListCell*cell=(storyListCell*)[_tableView cellForRowAtIndexPath:indexPath];

        NSDictionary*dic=[_dataArray objectAtIndex:indexPath.section];
        NSString*storyContent=[dic objectForKey:@"storyContent"];
        cell.pubContent.text=storyContent;
        cell.pubContent.numberOfLines=0;
        float h2=[self boundWithSize:CGSizeMake(_width*0.94, 0) WithLabel:cell.pubContent].height;
        cell.pubContent.frame=CGRectMake(_width*0.03, 55, _width*0.94,h2+10);
        button.frame=CGRectMake(0, 55+h2+10, _width, 20);
        float h1=h2+20;

        NSArray*imageListArray=[dic objectForKey:@"storyImage"];
        if (imageListArray.count==0)
        {
            cell.manyImageV.frame=CGRectMake(_width*0.03, h1+75, _width*0.94, 10);
            cell.lowView.frame=CGRectMake(0, h1+85, _width, 100);
        }else if(imageListArray.count>=1&&imageListArray.count<=3)
        {

            cell.manyImageV.frame=CGRectMake(_width*0.03, h1+75, _width*0.94, _width*0.2);
            cell.lowView.frame=CGRectMake(0, h1+75+_width*0.2, _width, 100);
        }else if (imageListArray.count>3&&imageListArray.count<=6)
        {
            cell.manyImageV.frame=CGRectMake(_width*0.03, h1+75, _width*0.94, _width*0.42);
            cell.lowView.frame=CGRectMake(0, h1+75+_width*0.42, _width, 100);
        }
        else if (imageListArray.count>6&&imageListArray.count<=9)
        {
            cell.manyImageV.frame=CGRectMake(_width*0.03, h1+75, _width*0.94,_width*0.64);
            cell.lowView.frame=CGRectMake(0, h1+75+_width*0.64, _width, 100);
        }

        cell.lowView.frame=CGRectMake(0,cell.lowView.frame.origin.y+10, _width, 100);



        cell.jubao.tag=indexPath.section;
        [cell.jubao addTarget:self action:@selector(jubao:) forControlEvents:UIControlEventTouchUpInside];

        cell.zanBtn.tag=indexPath.section;
        [cell.zanBtn addTarget:self action:@selector(zanBtn:) forControlEvents:UIControlEventTouchUpInside];
    }else
    {
        [button setTitle:@"查看更多" forState:UIControlStateNormal];
        button.selected=NO;
        NSIndexPath*indexPath=[NSIndexPath indexPathForRow:0 inSection:button.tag];
        storyListCell*cell=(storyListCell*)[_tableView cellForRowAtIndexPath:indexPath];

        NSDictionary*dic=[_dataArray objectAtIndex:indexPath.section];
        NSString*storyContent=[dic objectForKey:@"storyContent"];
        cell.pubContent.text=storyContent;
        cell.pubContent.numberOfLines=3;
        cell.pubContent.frame=CGRectMake(_width*0.03, 55, _width*0.94,70);
        button.frame=CGRectMake(0, 125, _width, 20);
        float h1=80;

        NSArray*imageListArray=[dic objectForKey:@"storyImage"];
        if (imageListArray.count==0)
        {
            cell.manyImageV.frame=CGRectMake(_width*0.03, h1+75, _width*0.94, 10);
            cell.lowView.frame=CGRectMake(0, h1+85, _width, 100);
        }else if(imageListArray.count>=1&&imageListArray.count<=3)
        {

            cell.manyImageV.frame=CGRectMake(_width*0.03, h1+75, _width*0.94, _width*0.2);
            cell.lowView.frame=CGRectMake(0, h1+75+_width*0.25, _width, 100);
        }else if (imageListArray.count>3&&imageListArray.count<=6)
        {
            cell.manyImageV.frame=CGRectMake(_width*0.03, h1+75, _width*0.94, _width*0.42);
            cell.lowView.frame=CGRectMake(0, h1+75+_width*0.52, _width, 100);
        }
        else if (imageListArray.count>6&&imageListArray.count<=9)
        {
            cell.manyImageV.frame=CGRectMake(_width*0.03, h1+75, _width*0.94,_width*0.64);
            cell.lowView.frame=CGRectMake(0, h1+75+_width*0.79, _width, 100);
        }

        //cell.lowView.frame=CGRectMake(0,cell.lowView.frame.origin.y+10, _width, 100);
        cell.jubao.tag=indexPath.section;
        [cell.jubao addTarget:self action:@selector(jubao:) forControlEvents:UIControlEventTouchUpInside];

        cell.zanBtn.tag=indexPath.row;
        [cell.zanBtn addTarget:self action:@selector(zanBtn:) forControlEvents:UIControlEventTouchUpInside];

    }



}
-(void)ImageBtnClick:(UIButton*)button
{

    UIView*view1=(UIView*)[button superview];
    NSLog(@"¥¥¥¥¥¥¥¥¥¥¥¥");
    NSDictionary*dic=[_dataArray objectAtIndex:view1.tag];
    NSArray*imageListArray=[dic objectForKey:@"storyImage"];
    _page_number=(int)imageListArray.count;

    UIWindow*window=[UIApplication sharedApplication].keyWindow;
    BGView=[[UIView alloc]init];
    BGView.center=button.center;
    BGView.bounds=CGRectMake(0, 0, 0, 0);
    BGView.backgroundColor=[UIColor whiteColor];
    [window addSubview:BGView];
    [UIView animateWithDuration:0.2 animations:^{
        BGView.frame=window.frame;
    } completion:^(BOOL finished) {

        _imageScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _width, _height)];
        _imageScrollView.pagingEnabled=YES;
        _imageScrollView.bounces=NO;
        _imageScrollView.delegate=self;
        _imageScrollView.contentSize=CGSizeMake(_width*imageListArray.count,_height) ;

        _imageScrollView.contentOffset=CGPointMake(_width*button.tag, 0);

        _page_L=[[UILabel alloc]initWithFrame:CGRectMake(0, _height-70, _width, 40)];
        _page_L.text=[NSString stringWithFormat:@"%d/%lu",button.tag+1,(unsigned long)imageListArray.count];
        _page_L.textAlignment=NSTextAlignmentCenter;

        _page_L.textColor=APP_ClOUR;

        //_imageScrollView.backgroundColor=[UIColor grayColor];


        [BGView addSubview:_imageScrollView];



        for (int i=0; i<imageListArray.count; i++) {
            NSDictionary*dic=[imageListArray objectAtIndex:i];
            UIImageView*iv=[[UIImageView alloc]initWithFrame:CGRectMake(_width*i,0, _width, _height)];
            [iv sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"storyPath"]] placeholderImage:[UIImage imageNamed:@"morentu.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image==nil) {
                    image=[UIImage imageNamed:@"morentu.jpg"];
                }

                float  H=_width*image.size.height/image.size.width;
                //NSLog(@"%f",H);

                if (H>_height-64) {
                     iv.center=CGPointMake(_width*i+_width/2, H/2);
                }else
                {
                     iv.center=CGPointMake(_width*i+_width/2, _height/2);
                }

                if (image==nil) {
                    iv.bounds=CGRectMake(0, 0, _width, 200);

                }else
                {
                    iv.bounds=CGRectMake(0, 0, _width, H);
                }
                 _imageScrollView.contentSize=CGSizeMake(_width*imageListArray.count,H) ;
                iv.tag=1;

            }];

            //UIImage*image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dic objectForKey:@"storyPath"]]]];
            //NSLog(@"%f----%f",image.size.width,image.size.height);



            [_imageScrollView addSubview:iv];
//            _imageScrollView.tag=view1.tag;


            iv.userInteractionEnabled=YES;

            UITapGestureRecognizer*doubleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
            doubleTap.numberOfTapsRequired=2;
            [iv addGestureRecognizer:doubleTap];


            UITapGestureRecognizer*backTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backTap:)];
            [backTap setNumberOfTapsRequired:1];
            [iv addGestureRecognizer:backTap];


            [backTap requireGestureRecognizerToFail:doubleTap];

        }

        [BGView addSubview:_page_L];

      //  UIWindow *win=[UIApplication sharedApplication].keyWindow;

        UIView*topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 64)];
        topView.backgroundColor=APP_ClOUR;
        [BGView addSubview:topView];

        UILabel*storySign=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, _width, 44)];
        storySign.text=[NSString stringWithFormat:@"原图"];
        storySign.textAlignment=NSTextAlignmentCenter;
        storySign.textColor=[UIColor whiteColor];
        [BGView addSubview:storySign];




        UIImageView*backBtn=[[UIImageView alloc]init];
        backBtn.frame=CGRectMake(_width*0.06, 30, 12, 20);
        backBtn.image=[UIImage imageNamed:@"left.png"];
        [BGView addSubview:backBtn];

        UIButton*butt=[UIButton buttonWithType:UIButtonTypeCustom];
        butt.frame=CGRectMake(0, 20, _width*0.2, 44);
        [butt addTarget:self action:@selector(imageBack:) forControlEvents:UIControlEventTouchUpInside];

        [BGView addSubview:butt];

    }];




}
-(void)imageBack:(UIButton*)btn
{

    //NSLog(@"drfgvbhjk");
    [BGView removeFromSuperview];
    [_bigImageSvrollView removeFromSuperview];
    [btn removeFromSuperview];

}
-(void)doubleTap:(UITapGestureRecognizer*)gest
{
    UIImageView*view=(UIImageView*)gest.view;

    [_bigImageSvrollView removeFromSuperview];

    //    if (view.tag==1) {
    //        view.tag=2;

    _bigImageSvrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64)];

    _bigImageSvrollView.contentSize=CGSizeMake(view.frame.size.width*2, view.frame.size.height*2);
    _bigImageSvrollView.bounces=NO;

    _bigImageSvrollView.scrollEnabled=YES;
    UIImageView*imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width*2, view.frame.size.height*2)];
    imageV.image=view.image;

    [_bigImageSvrollView addSubview:imageV];


    UITapGestureRecognizer*single=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(single:)];
    [_bigImageSvrollView addGestureRecognizer:single];

    [[UIApplication sharedApplication].keyWindow addSubview:_bigImageSvrollView];

    //    }else
    //    {
    //        view.tag=1;
    //
    //    }


}
-(void)single:(UITapGestureRecognizer*)gest
{
    UIScrollView*scrollView=(UIScrollView*)gest.view;

    [scrollView removeFromSuperview];


}
-(void)backTap:(UITapGestureRecognizer*)gest
{
    //NSLog(@"1");
    [UIView animateWithDuration:0.2 animations:^{
        BGView.bounds=CGRectMake(0, 0, 0, 0);
        for (UIView*view in BGView.subviews) {
            [view removeFromSuperview];
        }
    } completion:^(BOOL finished) {

    }];
}
-(void)zanBtn:(UIButton*)button
{
    if (USERID!=nil) {
        NSDictionary*dic=[_dataArray objectAtIndex:button.tag];
        //NSString*userId=[dic objectForKey:@"userId"];
        NSString*storyId=[dic objectForKey:@"storyId"];

        [requestData getData:STORY_LIST_ZAN_URL(USERID, storyId) complete:^(NSDictionary *dic) {
            NSLog(@"%@",dic);
            MISSINGVIEW
            if ([[dic objectForKey:@"flag"] intValue]==0) {
                missing_v.tishi=[NSString stringWithFormat:@"%@",@""];

            }else
            {
                missing_v.tishi=[NSString stringWithFormat:@"%@",@"点赞成功"];
                self.isdianzan=YES;
                [self getStoryList:@""];
            }


        }];

    }else
    {

    }


}
-(void)jubao:(UIButton*)button
{
    //NSLog(@"%ld",(long)button.tag);
    NSDictionary*dic=[_dataArray objectAtIndex:button.tag];
    NSString*userId=[dic objectForKey:@"userId"];
    NSString*storyId=[dic objectForKey:@"storyId"];


    if (USERID!=nil) {
        jubaoVC*vc=[[jubaoVC alloc]init];
        vc.userId=userId;
//        vc.storyId=storyId;
        self.tabBarController.tabBar.hidden=YES;
        [self.navigationController pushViewController:vc animated:YES];

    }else
    {

    }


}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"尽然不掉");


    if (_dataArray.count==0) {
        return 0;
    }else
    {


        NSDictionary*dic=[_dataArray objectAtIndex:indexPath.section];
        NSString*storyContent=[dic objectForKey:@"storyContent"];

        NSArray*imageListArray=nil;
        id storyImage=[dic objectForKey:@"storyImage"];
        if (storyImage==[NSNull null]) {
            imageListArray=nil;
        }else
        {
            imageListArray=[dic objectForKey:@"storyImage"];
        }

        CGSize  size=[self boundWithSize:CGSizeMake(_width*0.94, 0) WithString:storyContent WithFont:[UIFont systemFontOfSize:14]];

        int h1=0;
        if (imageListArray.count==0)
        {
            h1=10;
        }else if(imageListArray.count>=1&&imageListArray.count<=3)
        {
            h1=_width*0.25;
        }else if (imageListArray.count>3&&imageListArray.count<=6)
        {
            h1=_width*0.52;
        }
        else if (imageListArray.count>6&&imageListArray.count<=9)
        {
            h1=_width*0.78;
        }
        id faceArray=[dic objectForKey:@"faceList"];


        float cellH;

        if (faceArray==[NSNull null]) {
            cellH=120+h1+size.height;

        }else
        {
            cellH=120+h1+size.height+50;
        }
        static int i=0;
        i++;
        // NSLog(@"%f----%d",cellH,i);
        if (i>_dataArray.count) {
            //NSLog(@"pppppp");
            
        }else
        {
            _tabH=_tabH+cellH;
            //        NSLog(@"-----%f",_tabH);
        }
        if (storyContent.length>50) {
            return cellH+10;
        }else
        {
            return cellH;
        }


    }

    //return cellH;
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

-(CGSize)boundWithSize:(CGSize)size  WithLabel:(UILabel*)label
{
    NSDictionary *attribute = @{NSFontAttributeName: label.font};

    CGSize retSize = [label.text boundingRectWithSize:size
                                              options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                           attributes:attribute
                                              context:nil].size;

    return retSize;
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    // NSLog(@"--%f",scrollView.contentOffset.y);
    //    if (scrollView.contentOffset.y<0) {
    //        LOADING_VIEW
    //
    //        [self getStoryList];
    //    }
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // NSLog(@"%f",scrollView.contentOffset.y);
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //NSLog(@"fchwoie");
    int currentPage=_imageScrollView.contentOffset.x/_width+1;
    _page_L.text=[NSString stringWithFormat:@"%d/%d",currentPage,_page_number];
    
    _pc.currentPage=_smallScrollV.contentOffset.x/_width;
    
}
-(void)timeAction
{
    if (_advistArray.count==0) {
        return;
    }
    static  int  i=0;
    i++;
    if (i==_advistArray.count) {
        i=0;
    }
    //NSLog(@"%d",i);

    _pc.currentPage=i;

    [UIView animateWithDuration:0.5 animations:^{
        // _pc.frame=CGRectMake(_width*i, 140, _width, 30);
        _smallScrollV.contentOffset=CGPointMake(_width*i, 0);
    }];



    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_timer invalidate];
    _timer=nil;
}
-(void)backClick
{
    if (USERID!=nil ) {
        PUSH(mystoryVC)
        vc.whoPush=@"maijia";
        self.tabBarController.tabBar.hidden=YES;

    }else
    {
        
        ALLOC(logInVC)
        [self presentViewController:vc animated:YES completion:nil];
    }
}

-(BOOL)shouldAutorotate
{
    return NO;
}
-(void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
   // self.tabBarController.tabBar.hidden=YES;

    _timer=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];

    [self getStoryList:@""];

    
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
