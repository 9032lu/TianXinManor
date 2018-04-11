//
//  mycircleViewController.m
//  PsychiatricConsulting
//
//  Created by apple on 15/9/2.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "mycircleViewController.h"
#import "transformTime.h"
#import "storyListCell.h"

@interface mycircleViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate>
{
    SCREEN_WIDTH_AND_HEIGHT
    UITableView *_tableview;
    UIImageView*_smallView;
    NSMutableArray *array ;
    NSMutableArray *dataArray;
    NSArray *modleArray;


}
@property(nonatomic,strong)UITextField *textfiled;
@property(nonatomic,strong)UIView *lview;

@end

@implementation mycircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view .backgroundColor =[UIColor whiteColor];
    array = [[NSMutableArray alloc]init];
    TOP_VIEW(@"我的详情")
    [_tableview removeFromSuperview];

    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64-self.tabBarController.tabBar.frame.size.height) style:UITableViewStyleGrouped];
    _tableview.separatorStyle= UITableViewCellSeparatorStyleNone;

    _tableview.delegate=self;
    _tableview.dataSource =self;
    [self.view addSubview:_tableview];
    [self getdata];


    UIView *lview = [[UIView alloc]initWithFrame:CGRectMake(0, _height-60, _width, 60)];
    self.lview =lview;
    lview.backgroundColor=RGB(234, 234, 234);
    [self.view addSubview:lview];
    UITextField *textfiled = [[UITextField alloc]initWithFrame:CGRectMake(_width*0.05, 12, _width*0.7, 36)];
    [lview addSubview:textfiled];
    textfiled.delegate=self;
    textfiled.placeholder=@"我也要评论";
    textfiled.layer.cornerRadius=7;
    textfiled.backgroundColor = [UIColor whiteColor];
    self.textfiled=textfiled;


    UIButton *plbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    plbutton.frame = CGRectMake(_width*0.8, 12, _width*0.15, 36);
    [lview addSubview:plbutton];
    plbutton.layer.cornerRadius=5;
    plbutton.backgroundColor =APP_ClOUR;
    [plbutton setTitle:@"评论"forState:UIControlStateNormal];
    [plbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [plbutton addTarget:self action:@selector(plbutton) forControlEvents:UIControlEventTouchUpInside];

    _tableview.keyboardDismissMode =UIScrollViewKeyboardDismissModeOnDrag;

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyup:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyHide:) name:UIKeyboardWillHideNotification object:nil];




}
-(void)keyup:(NSNotification *)notice{

    //    NSLog(@"--%@",notice.userInfo);
    NSValue *value = [notice.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationCurve:7];
    CGRect rect = [value CGRectValue];
    self.lview.frame =CGRectMake(0, _height-60-rect.size.height,_width, 60);

    _tableview.frame = CGRectMake(0, 64, _width, _height-rect.size.height-64-self.tabBarController.tabBar.frame.size.height);
    [UIView commitAnimations];


}

-(void)keyHide:(NSNotification *)info{

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationCurve:7];
    self.lview.frame =CGRectMake(0, _height-60, _width, 60);
    _tableview.frame = CGRectMake(0, 64, _width, _height-64-self.tabBarController.tabBar.frame.size.height)
    ;
    [UIView commitAnimations];

}



-(void)plbutton{

    if ([self.textfiled.text isEqualToString:@""]) {
        return;
    }
    NSString *str=self.textfiled.text;
    //    [array addObject:str];
    [_tableview reloadData];
    NSLog(@"----------%@",str);

    //让标的某一行滚到标的某位置
    //让标的最后一行滚到标的底部
    //创建最后一行的索引
//    if (array!=nil) {
//        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:array.count-1 inSection:1];
//        [_tableview scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//
//    }

    self.textfiled.text=nil;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.textfiled endEditing:YES];
    [_tableview endEditing:YES];
    [self.view endEditing:YES];
    //    [self.textfiled resignFirstResponder];
}


//请求评论数据
-(void)getdata{
    NSString *topstring = [NSString stringWithFormat:@"%@/topicComment/list.action?topicsId=%@",BASE_URLL,self.modle.topicsId];
    [requestData getData:topstring complete:^(NSDictionary *dic) {

        NSLog(@"----%@",dic);
        NSMutableArray *plarray = [[NSMutableArray alloc]init];
        dataArray = [dic objectForKey:@"data"];
        for (NSDictionary *dict in dataArray) {
            Modle *modle = [[Modle alloc]init];

            modle.face = [dict objectForKey:@"face"];
            modle.replayContent = [dict objectForKey:@"replayContent"];//评论内容
            modle.commentDate=[dict objectForKey:@"commentDate"];//评论时间
            modle.nickName=[dict objectForKey:@"nickName"];
            modle.replayDate=dict[@"replayDate"];//回复日期
            modle.commentContent=dict[@"commentContent"];//回复内容
            //            modle.topicCommentId=dict[@"topicCommentId"];

            [plarray addObject:modle];

        }
        modleArray =[NSArray arrayWithArray:plarray];

        [_tableview reloadData];
    }];



}
#pragma mark  UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //row数
    if (section==0) {
        return 1;
    }
    return modleArray.count;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //section数
    return 2;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    //尾高
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    //头高
    if (section==0) {
        return _width*0.03*2+40;
    }else if(section==1){
        return 44;
    }else
        return 0.1;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"尽然不掉");
    if (indexPath.section==0) {


        if (self.modle==nil) {
            return 0;
        }else
        {


            //        NSDictionary*dic=[_dataArray objectAtIndex:indexPath.section];
            //        NSString*storyContent=[dic objectForKey:@"storyContent"];

            //        NSArray*imageListArray=nil;
            //        id storyImage=[dic objectForKey:@"storyImage"];
            if ((NSNull*)self.modle.topocImageList==[NSNull null]) {
                self.modle.topocImageList=nil;
            }
            //        else
            //        {
            //            imageListArray=[dic objectForKey:@"storyImage"];
            //        }

            CGSize  size=[self boundWithSize:CGSizeMake(_width*0.94, 0) WithString:self.modle.topicsContent WithFont:[UIFont systemFontOfSize:14]];

            int h1=0;
            if (self.modle.topocImageList.count==0)
            {
                h1=10;
            }else if(self.modle.topocImageList.count>=1&&self.modle.topocImageList.count<=3)
            {
                h1=_width*0.25;
            }else if (self.modle.topocImageList.count>3&&self.modle.topocImageList.count<=6)
            {
                h1=_width*0.52;
            }
            else if (self.modle.topocImageList.count>6&&self.modle.topocImageList.count<=9)
            {
                h1=_width*0.78;
            }
            //        id faceArray=[dic objectForKey:@"faceList"];


            float cellH;

            //        if (faceArray==[NSNull null]) {
            cellH=120-45+h1+size.height;

            if (self.modle.topicsContent.length>50) {
                return cellH+10;
            }else
            {
                return cellH;
            }


        }


    }else if(indexPath.section==1){
        if ((NSNull*)[modleArray[indexPath.row] replayContent]==[NSNull null]) {
            return 89;
        }else{
            CGFloat h1= [self boundWithSize:CGSizeMake(_width*0.94, 0) WithString:[modleArray[indexPath.row] replayContent] WithFont:[UIFont systemFontOfSize:15]].height;

            return h1+55;


        }
    }

    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //头的view
    UIView *view = [UIView new];

    if (section==0) {


        _width=[UIScreen mainScreen].bounds.size.width;
        _height=[UIScreen mainScreen].bounds.size.height;



        _userFace=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.03, 5, 40, 40)];
         _userFace.image=[UIImage imageNamed:@"屏幕快照 2015-08-28 上午11.05.48@2x"];
        _userFace.layer.cornerRadius=20;
        _userFace.clipsToBounds=YES;
        [view addSubview:_userFace];


        _userName=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.03+50, 8, _width*0.94-40, 15)];
        _userName.textAlignment=NSTextAlignmentLeft;
        _userName.textColor=[UIColor blackColor];
        _userName.font=[UIFont systemFontOfSize:15];
        _userName.text=@"比较常见的额";
        [view addSubview:_userName];

//        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
//       button.frame=CGRectMake(_width*0.8, 0, _width*0.2, 55);
//       [button addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
//
//       UIImageView*delete=[[UIImageView alloc]initWithFrame:CGRectMake((_width*0.2-20)/2, 19.5, 14*1.3, 16*1.3)];
//       delete.image=[UIImage imageNamed:@"delete"];
//            [button addSubview:delete];
//        [view addSubview:button];



        _timeIV =[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.03+50, 31.5,12, 12)];
        _timeIV.image=[UIImage imageNamed:@"time"];
        [view addSubview:_timeIV];

        _pubTime=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.03+72, 31.5, _width*0.94-55, 12)];
        _pubTime.textAlignment=NSTextAlignmentLeft;
        _pubTime.textColor=[UIColor grayColor];
        _pubTime.font=[UIFont systemFontOfSize:10];
       _pubTime.text=self.modle.topicsDate;
        [view addSubview:_pubTime];



//        _userName=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.03, 31.5,100, 15)];
//        _userName.text = self.modle.nickName;
//        _userName.font=[UIFont systemFontOfSize:13];
//        _userName.textColor=[UIColor grayColor];
//
//        [view addSubview:_userName];

//        _pubTime=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.03+100, 31.5, _width*0.94-55, 15)];
//        _pubTime.textAlignment=NSTextAlignmentLeft;
//        _pubTime.textColor=[UIColor grayColor];
//        _pubTime.font=[UIFont systemFontOfSize:13];
//        _pubTime.text=self.modle.topicsDate;
//        [view addSubview:_pubTime];


        return view;
    }else if (section ==1){
        UILabel *pinglunlab = [[UILabel alloc]init];
        pinglunlab.frame = CGRectMake(10, 0, _width, 44);
        pinglunlab.text=  [NSString stringWithFormat:@"评论（%lu)",(unsigned long)array.count];
        [view addSubview:pinglunlab];
        return view;
    }
    return nil;

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    Modle* mode=self.modle;

    storyListCell*cell=[[storyListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.timeIV.hidden= YES;



    if (indexPath.section ==0) {


        if (mode==nil) {
            cell.hidden=YES;

        }else{


            float h1;

            cell.pubContent.text=[NSString stringWithFormat:@"%@",mode.topicsContent];
            cell.collectNum.text = [NSString stringWithFormat:@"%@",mode.praiseCount];
            cell.pinglunLab.text=[NSString stringWithFormat:@"%@",mode.commentCount];

            h1=[self boundWithSize:CGSizeMake(_width*0.94, 0) WithLabel:cell.pubContent].height;
            cell.pubContent.frame=CGRectMake(_width*0.03, 55-45, _width*0.94,h1+10);




            //计算图片高度
            //        NSArray*imageListArray=nil;
            //        id storyImage=[dic objectForKey:@"storyImage"];
            if ((NSNull*)mode.topocImageList==[NSNull null]) {
                mode.topocImageList=nil;
            }
            //        else
            //        {
            //            imageListArray=[dic objectForKey:@"storyImage"];
            //        }



            for (int i=0; i<mode.topocImageList.count; i++) {
                int X=i%3;
                int Y=i/3;
                UIButton*image_B=[UIButton buttonWithType:UIButtonTypeCustom];
                image_B.frame=CGRectMake(0+_width*0.32*X, _width*0.27*Y, _width*0.3, _width*0.25);
                image_B.tag=i;

                [image_B sd_setBackgroundImageWithURL:[NSURL URLWithString:[mode.topocImageList[i]objectForKey:@"linkImagePath"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"fang.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (image==nil) {
                        image=[UIImage imageNamed:@"fang.jpg"];
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




            if (mode.topocImageList.count==0)
            {
                cell.manyImageV.frame=CGRectMake(_width*0.03, h1+75-45, _width*0.94, 10);
                cell.lowView.frame=CGRectMake(0, h1+85-45, _width, 45);
            }else if(mode.topocImageList.count>=1&&mode.topocImageList.count<=3)
            {

                cell.manyImageV.frame=CGRectMake(_width*0.03, h1+75-45, _width*0.94, _width*0.25);
                cell.lowView.frame=CGRectMake(0, h1+75-45+_width*0.25, _width, 45);
            }else if (mode.topocImageList.count>3&&mode.topocImageList.count<=6)
            {
                cell.manyImageV.frame=CGRectMake(_width*0.03, h1+75-45, _width*0.94, _width*0.52);
                cell.lowView.frame=CGRectMake(0, h1+75-45+_width*0.52, _width, 45);
            }
            else if (mode.topocImageList.count>6&&mode.topocImageList.count<=9)
            {
                cell.manyImageV.frame=CGRectMake(_width*0.03, h1+75-45, _width*0.94,_width*0.79);
                cell.lowView.frame=CGRectMake(0, h1+75-45+_width*0.79, _width, 45);
            }
            if (cell.pubContent.text.length>50) {
                cell.lowView.frame=CGRectMake(0,cell.lowView.frame.origin.y, _width, 45);

            }

            [cell.zanBtn addTarget:self action:@selector(zanbutton) forControlEvents:UIControlEventTouchUpInside];
            [cell.pinglun addTarget:self action:@selector(pingbutton) forControlEvents:UIControlEventTouchUpInside];

        }



    }
    else
        if (indexPath.section==1){
            //评论区
            cell.lowView.hidden =YES;
            if ((NSNull *)[modleArray[indexPath.row] face]==[NSNull null]) {
                cell.userFace.image =[UIImage imageNamed:@"1024.png"];
            }else{
                [cell.userFace sd_setImageWithURL:[NSURL URLWithString:[modleArray[indexPath.row] face]]
                                 placeholderImage: [UIImage imageNamed:@"1024.png"]];

            }

            cell.userName.text=[modleArray[indexPath.row] nickName];
            cell.pubTime.text =[modleArray[indexPath.row] commentDate];
            if ((NSNull*)[[modleArray objectAtIndex:indexPath.row] replayContent]==[NSNull null]) {
                cell.pubContent.frame= CGRectMake(_width*0.03, 45, _width*0.94, 44) ;
                cell.pubContent.text=@"xxxxxx";
                cell.pubContent.font =[UIFont systemFontOfSize:15];

                UIView*line=[[UIView alloc]initWithFrame:CGRectMake(0, 89, _width, 1)];
                line.backgroundColor=RGB(234, 234, 234);
                [cell addSubview:line];
            }else{
                cell.pubContent.text = [[modleArray objectAtIndex:indexPath.row] replayContent];

                float h1;

                h1= [self boundWithSize:CGSizeMake(_width*0.94, 0) WithString:cell.pubContent.text WithFont:[UIFont systemFontOfSize:14]].height;
                cell.pubContent.frame=CGRectMake(_width*0.03, 45, _width*0.94,h1+10);

                UIView*line=[[UIView alloc]initWithFrame:CGRectMake(0, h1+10, _width, 1)];
                line.backgroundColor=RGB(234, 234, 234);
                [cell addSubview:line];
            }


        }


    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@" section==%d ...row ==%d",indexPath.section,indexPath.row);
    [self.view endEditing:YES];
}
-(void)pingbutton{
    NSLog(@"ping");
}

-(void)zanbutton{
    NSLog(@"zan");
}

-(void)backClick{
    //返回上一级VC
    NSLog(@"22");
    POP
}

-(void)ImageBtnClick:(UIButton*)button

{
    NSArray *imageListArray = self.modle.topocImageList;
    UIView*view1=(UIView*)[button superview];
    //NSLog(@"%ld",(long)view1.tag);

    //    NSDictionary*dic=[_dataArray objectAtIndex:view1.tag];
    //    NSArray*imageListArray=[dic objectForKey:@"linkImagePath"];
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
            [iv sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"linkImagePath"]] placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image==nil) {
                    image=[UIImage imageNamed:@"fang"];
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
            _imageScrollView.tag=view1.tag;


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
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //NSLog(@"fchwoie");
    int currentPage=_imageScrollView.contentOffset.x/_width+1;
    _page_L.text=[NSString stringWithFormat:@"%d/%d",currentPage,_page_number];

    //    _pc.currentPage=_smallScrollV.contentOffset.x/_width;

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

-(void)imageBack:(UIButton*)btn
{

    //NSLog(@"drfgvbhjk");
    [BGView removeFromSuperview];
    [_bigImageSvrollView removeFromSuperview];
    [btn removeFromSuperview];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden = YES;
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self plbutton];

    return YES;
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

//-(void)deleteClick:(UIButton*)button
//{
//    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:nil message:@"确定要删除这条故事么？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    alert.tag=button.tag;
//    [alert show];
//
//
//}
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//
//    if (buttonIndex==1) {
//        
//
//        NSLog(@"====%@,,,%@",self.modle.topicsId,self.modle.userId);
//                [requestData getData:STORY_DELETE_URL(self.modle.topicsId) complete:^(NSDictionary *dic) {
//                    
////                    HH=0;
////                    [self getData:@""];
//                    //[_tableView reloadData];
//                    //ALERT([dic objectForKey:@"info"]);
//                }];
//        
//            }
//
//
//
//}



@end
