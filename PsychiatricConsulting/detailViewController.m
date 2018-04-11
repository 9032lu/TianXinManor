//
//  detailViewController.m
//  PsychiatricConsulting
//
//  Created by apple on 15/8/28.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "detailViewController.h"
#import "jubaoVC.h"
#import "transformTime.h"
#import "storyListCell.h"
#import "myButton.h"
#import "logInVC.h"
@interface detailViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    SCREEN_WIDTH_AND_HEIGHT
    UITableView *_tableview;
    UIImageView*_smallView;
    NSMutableArray *array ;
    NSMutableArray *dataArray;
    NSArray *modleArray;
    NSMutableArray *listArray;
float cellH1;
    float cellH2;

    CGFloat h3;
    CGFloat Plhh;
    CGFloat HFhh ;

    CGFloat hh1;

}
@property(nonatomic,strong)UITextField *textfiled;
@property(nonatomic,strong)UIView *lview;


@property(nonatomic,strong)UITextField *HFtextfiled;
@property(nonatomic,strong)UIView *HFlview;

@end

@implementation detailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view .backgroundColor =[UIColor whiteColor];
    array = [[NSMutableArray alloc]init];
    TOP_VIEW(@"详情")
    HFhh =0.0;
    Plhh=0.0;
    hh1=0.1;
    [_tableview removeFromSuperview];

//   NSString *changetime= [self changeTimeString:@"2015-08-28 01:37:50.0"];
//    NSLog(@"changetime ===%@",);
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64) style:UITableViewStyleGrouped];
//    _tableview.separatorStyle= UITableViewCellSeparatorStyleNone;
    _tableview.delegate=self;
    _tableview.dataSource =self;
    [self.view addSubview:_tableview];




//    UIView *lview = [[UIView alloc]initWithFrame:CGRectMake(0, _height-60, _width, 60)];
//    self.lview =lview;
//    lview.backgroundColor=RGB(234, 234, 234);
//    [self.view addSubview:lview];
//
//    UITextField *textfiled = [[UITextField alloc]initWithFrame:CGRectMake(_width*0.05, 12, _width*0.7, 36)];
//    [lview addSubview:textfiled];
//    textfiled.delegate=self;
//    textfiled.placeholder=@"我也要评论";
//    textfiled.layer.cornerRadius=7;
//    textfiled.backgroundColor = [UIColor whiteColor];
//    self.textfiled=textfiled;
//
//
//    UIButton *plbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    plbutton.frame = CGRectMake(_width*0.8, 12, _width*0.15, 36);
//    [lview addSubview:plbutton];
//    plbutton.layer.cornerRadius=5;
//    plbutton.backgroundColor =APP_ClOUR;
//    [plbutton setTitle:@"评论"forState:UIControlStateNormal];
//    [plbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [plbutton addTarget:self action:@selector(plbutton) forControlEvents:UIControlEventTouchUpInside];

    _tableview.keyboardDismissMode =UIScrollViewKeyboardDismissModeOnDrag;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyup:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyHide:) name:UIKeyboardWillHideNotification object:nil];
    

    [self getdata];
    [self getData:self.topicsId];


}
-(void)keyup:(NSNotification *)notice{
    
    NSLog(@"++%@",notice.userInfo);
    NSValue *value = [notice.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationCurve:7];
    CGRect rect = [value CGRectValue];
    self.lview.frame =CGRectMake(0, _height-60-rect.size.height,_width, 60);
    self.HFlview.frame =CGRectMake(0, _height-60-rect.size.height,_width, 60);

    _tableview.frame = CGRectMake(0, 64, _width, _height-rect.size.height-64-60);
    [UIView commitAnimations];
    
    
}

-(void)keyHide:(NSNotification *)info{
    NSLog(@"--%@",info.userInfo);

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationCurve:7];
    self.HFlview.frame =CGRectMake(0, _height, _width, 60);

    self.lview.frame =CGRectMake(0, _height, _width, 60);
    _tableview.frame = CGRectMake(0, 64, _width, _height-64)
;
    [UIView commitAnimations];
    
}



-(void)plbutton{
    
    if ([self.textfiled.text isEqualToString:@""]) {
        return;
    }

    LOADVIEW
    viewh.remind_L=@"正在提交数据";

    NSLog(@"url====%@",STORY_LIST_PINGLUN_URL(USERID, self.topicsId, self.textfiled.text) );
    [requestData getData:STORY_LIST_PINGLUN_URL(USERID, self.topicsId, self.textfiled.text) complete:^(NSDictionary *dic) {
 //            [_denglu removeFromSuperview];
        LOADREMOVE
        if ([[dic objectForKey:@"flag"] intValue]==1) {

            //ALERT([dic objectForKey:@"info"])
            [self getdata];
            [self getData:self.topicsId];
//            POP
        }else
        {
            NSLog(@"11111111");

        }
        MISSINGVIEW
        missing_v.tishi=[NSString stringWithFormat:@"%@",[dic objectForKey:@"info"]];
    }];



    NSString *str=self.textfiled.text;
//    [array addObject:str];
    [_tableview reloadData];
//    NSLog(@"----------%@",str);

    //让标的某一行滚到标的某位置
    //让标的最后一行滚到标的底部
    //创建最后一行的索引
//    if (modleArray!=nil) {
//        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:modleArray.count-1 inSection:1];
//        [_tableview scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
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
    LOADVIEW
       NSString *topstring = [NSString stringWithFormat:@"%@/topicComment/list.action?topicsId=%@",BASE_URLL,self.topicsId];
    NSLog(@"=====---%@",topstring);
    [requestData getData:topstring complete:^(NSDictionary *dic) {
LOADREMOVE

        NSMutableArray *plarray = [[NSMutableArray alloc]init];
        dataArray = [dic objectForKey:@"data"];
        for (NSDictionary *dict in dataArray) {
            Modle *modle = [[Modle alloc]init];

            modle.face = [dict objectForKey:@"face"];

            modle.replayContent = [dict objectForKey:@"replayContent"];//评论内容
            modle.commentDate=[dict objectForKey:@"commentDate"];//评论时间
            if ((NSNull*)[dict objectForKey:@"nickName"]!=[NSNull null]) {
                modle.nickName=[dict objectForKey:@"nickName"];
            }else{
                modle.nickName = @"匿名";
            }
             modle.replayDate=[dict objectForKey:@"replayDate"];//回复日期
            if((NSNull*)[dict objectForKey:@"exp"]!=[NSNull null]){
                modle.exp = [dict objectForKey:@"exp"];//评论用户等级

            }else{
                modle.exp= @"新星VIP";
            }

//            modle.exp=[dict objectForKey:@"exp"];
            modle.commentContent=dict[@"commentContent"];//回复内容
            modle.topicCommentId=dict[@"topicCommentId"];

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
    }else
            return modleArray.count;



}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//section数
    return 2;

}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view;
    if (section==1) {
//        if (modleArray==nil) {
            UIView *ve= [[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 90)];

            UIImageView *imageview= [[UIImageView alloc]initWithFrame:CGRectMake((_width-55)/2, 10, 55, 50)];

            imageview.image=[UIImage imageNamed:@"iconfont-uni0"];
            [ve addSubview:imageview];
            ve.backgroundColor=[UIColor whiteColor];
            UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, _width, 30)];
            lable.text = @"暂无评论，快抢沙发";
            lable.textColor = [UIColor darkGrayColor];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.font = [UIFont systemFontOfSize:15];
        [ve addSubview:lable];
        UIView*line=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 1)];
        line.backgroundColor=RGB(234, 234, 234);
        [ve addSubview:line];

            view= ve;
        if (modleArray.count!=0) {
            ve=nil;
            view=nil;
        }

    }
    return view;
}

//尾高
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CGFloat footH;
    if (section ==0) {
        footH= 15;
    }else if(section==1){
        if (modleArray.count==0) {
            footH= 130;
        }else
            footH=0.1;

    }
    return footH;

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
        NSString *strtopicsContent = [NSString stringWithFormat:@"      %@",self.modle.topicsContent];
        CGSize  size=[self boundWithSize:CGSizeMake(_width*0.94, MAXFLOAT) WithString:strtopicsContent WithFont:[UIFont systemFontOfSize:14]];
     CGFloat h2 = [self boundWithSize:CGSizeMake(_width*0.94, 0) WithString:self.modle.topicsTitle WithFont:[UIFont systemFontOfSize:15]].height;



        int h1=0;
        if (self.modle.topocImageList.count==0)
        {
            h1=10;
        }else if(self.modle.topocImageList.count>=1&&self.modle.topocImageList.count<=3)
        {
            if (self.modle.topocImageList.count==1) {
                h1=_width*0.5;
            }else if (self.modle.topocImageList.count==2){
                h1=_width*0.35;
            }else{
                h1=_width*0.25;

            }

        }else if (self.modle.topocImageList.count>3&&self.modle.topocImageList.count<=6)
        {
            h1=_width*0.52;
        }
        else if (self.modle.topocImageList.count>6&&self.modle.topocImageList.count<=9)
        {
            h1=_width*0.79;
        }
//        id faceArray=[dic objectForKey:@"faceList"];


        if ([self.whoPush isEqualToString:@"wode"]) {
            cellH1=120-45+h1+size.height +h2;

//            if (self.modle.topicsContent.length>50) {
//                return cellH1+10+h2;
//            }else
//            {
                return cellH1;
//            }

        }else{
            cellH1=120-45+h1+size.height;

//            if (self.modle.topicsContent.length>50) {
//                return cellH1+10;
//            }else
//            {
                return cellH1;
//            }

        }


        
    }

    
        }else if(indexPath.section==1){


            if ((NSNull*)[modleArray[indexPath.row] commentContent]==[NSNull null]) {
                cellH2= 89;
            }else{
 NSString *commentContentstr = [NSString stringWithFormat:@"      %@",[modleArray[indexPath.row] commentContent]];

                 hh1= [self boundWithSize:CGSizeMake(_width*0.94, MAXFLOAT) WithString:commentContentstr WithFont:[UIFont systemFontOfSize:14]].height;


//                    h3 = [self boundWithSize:CGSizeMake(_width*0.94, MAXFLOAT) WithString:[modleArray[indexPath.row] replayContent] WithFont:[UIFont systemFontOfSize:14]].height;
//
//                }else{
//                    h3=0.01;
//                }


                if ([USERID isEqualToString:_modle.userId]) {

                    if ((NSNull*)[modleArray[indexPath.row] replayContent]!=[NSNull null]  ){
                        NSString *huifustring = [NSString stringWithFormat:@"    回复%@：%@",[modleArray[indexPath.row] nickName],[modleArray[indexPath.row] replayContent]];

                        HFhh= [self boundWithSize:CGSizeMake(_width*0.94, MAXFLOAT) WithString:huifustring WithFont:[UIFont systemFontOfSize:15]].height;
                    }else{
                        HFhh = 0.1;
                    }

//                    NSLog(@"+++++++%f",hh1+55+10+h3+HFhh);

                    cellH2= hh1+55+10+HFhh;

                }else{


                    if ((NSNull*)[modleArray[indexPath.row] replayContent]!=[NSNull null]  ){

                        NSString *huifustring = [NSString stringWithFormat:@"     %@回复%@：%@",_modle.nickName,[modleArray[indexPath.row] nickName],[modleArray[indexPath.row] replayContent]];

                        HFhh= [self boundWithSize:CGSizeMake(_width*0.94, MAXFLOAT) WithString:huifustring WithFont:[UIFont systemFontOfSize:14]].height;
                    }else{
                        HFhh = 0.1;
                    }


                    cellH2= hh1+55+10+HFhh;

                }




            }

            return cellH2;
                    }

    return 0.1;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//头的view
    UIView *view = [UIView new];
    view.backgroundColor =[UIColor whiteColor];

//用户的个人信息
    if (section==0) {

        _width=[UIScreen mainScreen].bounds.size.width;
        _height=[UIScreen mainScreen].bounds.size.height;
        UIView*line=[[UIView alloc]initWithFrame:CGRectMake(0, _width*0.03*2+40, _width, 2)];
        line.backgroundColor=RGB(234, 234, 234);
        [view addSubview:line];

    if ([self.whoPush isEqualToString:@"wode"]) {
        _userFace=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.03, 5, 40, 40)];
        if (self.userFace==nil) {
            _userFace.image=[UIImage imageNamed:@"userFace"];
        }else{

            NSString *faceImg = [[NSUserDefaults standardUserDefaults]objectForKey:@"face"];
            [_userFace sd_setImageWithURL:[NSURL URLWithString:faceImg] placeholderImage:[UIImage imageNamed:@"userFace"]];
//            _userFace.image=[UIImage imageNamed:@"userFace"];


        }

        _userFace.layer.cornerRadius=20;
        _userFace.clipsToBounds=YES;
        [view addSubview:_userFace];
            
            
        _userName=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.03+50, 8, _width*0.94-40, 15)];
         _userName.textAlignment=NSTextAlignmentLeft;
         _userName.textColor=[UIColor blackColor];
         _userName.font=[UIFont systemFontOfSize:15];
        _userName.text=_modle.nickName;
         [view addSubview:_userName];
        _timeIV =[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.03+50, 31.5,12, 12)];
          _timeIV.image=[UIImage imageNamed:@"time"];
                [view addSubview:_timeIV];
        
                _pubTime=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.03+72, 31.5, _width*0.94-55, 12)];
                _pubTime.textAlignment=NSTextAlignmentLeft;
                _pubTime.textColor=[UIColor grayColor];
                _pubTime.font=[UIFont systemFontOfSize:12];

        _pubTime.text=[self changeTimeString:self.modle.topicsDate];
//        NSLog(@"-----%@",_pubTime.text);
                [view addSubview:_pubTime];

    }else{
        _topictitle=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.03, 8, _width*0.94, 15)];
        _topictitle.textAlignment=NSTextAlignmentLeft;
        _topictitle.textColor=[UIColor blackColor];
        _topictitle.font=[UIFont systemFontOfSize:15];

        _topictitle.text=self.modle.topicsTitle;
        [view addSubview:_topictitle];


        _userName=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.03, 31.5,100, 15)];
        if ((NSNull*)self.modle.nickName != [NSNull null]) {
            _userName.text = self.modle.nickName;

        }
        _userName.font=[UIFont systemFontOfSize:13];
        _userName.textColor=[UIColor grayColor];

        [view addSubview:_userName];

        _pubTime=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.03+100, 31.5, _width*0.94-55, 15)];
        _pubTime.textAlignment=NSTextAlignmentLeft;
        _pubTime.textColor=[UIColor grayColor];
        _pubTime.font=[UIFont systemFontOfSize:12];
        _pubTime.text= [self changeTimeString:self.modle.topicsDate];
        [view addSubview:_pubTime];

    }



        return view;
    }else if (section ==1){
        UIView*line=[[UIView alloc]initWithFrame:CGRectMake(0, 44, _width, 1)];
        line.backgroundColor=RGB(234, 234, 234);
        [view addSubview:line];
        UILabel *pinglunlab = [[UILabel alloc]init];
        pinglunlab.frame = CGRectMake(10, 0, _width, 44);
        pinglunlab.text=  [NSString stringWithFormat:@"评论（ %lu )",(unsigned long)modleArray.count];
        pinglunlab.textColor =[UIColor darkGrayColor];
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


        float h1,h2 = 0.0;
        cell.collectNum.text = [NSString stringWithFormat:@"%@",mode.praiseCount];
        cell.pinglunLab.text=[NSString stringWithFormat:@"%@",mode.commentCount];




        NSString *strtopicsContent = [NSString stringWithFormat:@"      %@",mode.topicsContent];

        if ( [self.whoPush isEqualToString:@"wode"]) {
            cell.pubContent.text = mode.topicsTitle;
            cell.detailContent.text = strtopicsContent;
            h1=[self boundWithSize:CGSizeMake(_width*0.94, 0) WithLabel:cell.pubContent].height;

            h2=[self boundWithSize:CGSizeMake(_width*0.94, 0) WithLabel:cell.detailContent].height;

            cell.pubContent.frame=CGRectMake(_width*0.03, 55-45, _width*0.94,h1+10);
            cell.pubContent.textColor=[UIColor blackColor];
            cell.detailContent.textColor =[UIColor blackColor];
            

            ;

        }else{
            cell.pubContent.font = [UIFont systemFontOfSize:14];
            cell.pubContent.textAlignment = NSTextAlignmentLeft;
            cell.pubContent.text=strtopicsContent;
            h1=[self boundWithSize:CGSizeMake(_width*0.94, 0) WithLabel:cell.pubContent].height;


            cell.pubContent.frame=CGRectMake(_width*0.03, 55-45, _width*0.94,h1+10);
            cell.pubContent.textColor =[UIColor blackColor];
            

        }



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


            for (int i=0; i<mode.topocImageList.count; i++)

            {

                int X=i%3;
                int Y=i/3;
                UIButton*image_B=[UIButton buttonWithType:UIButtonTypeCustom];
                if (mode.topocImageList.count==1) {
                    image_B.frame=CGRectMake(0+_width*0.32*X, _width*0.27*Y, _width*0.6, _width*0.5);

                }else if (mode.topocImageList.count==2){
                    image_B.frame=CGRectMake(_width*0.94/2*i, 0, _width*0.94/2-_width*0.02, _width*0.35);

                }else{
                    image_B.frame=CGRectMake(0+_width*0.32*X, _width*0.27*Y, _width*0.3, _width*0.25);
                }
                image_B.tag=i;

                [image_B sd_setBackgroundImageWithURL:[NSURL URLWithString:[mode.topocImageList[i]objectForKey:@"linkImagePath"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"fang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
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

//                NSLog(@"††††††==%@",[mode.topocImageList[i]objectForKey:@"linkImagePath"]);

                [image_B addTarget:self action:@selector(ImageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.manyImageV addSubview:image_B];
                cell.manyImageV.tag=indexPath.section;
            }


        if (![self.whoPush isEqualToString:@"wode"]) {
            cell.detailContent.hidden =YES;
            h2=0.0;
        }

        if (mode.topocImageList.count==0)
        {
            cell.manyImageV.frame=CGRectMake(_width*0.03, h1+75-45, _width*0.94, 10);
            cell.detailContent.frame=CGRectMake(_width*0.03, h1+20+5, _width*0.94,h2+10);

            cell.lowView.frame=CGRectMake(0, cellH1-45, _width, 45);


        }else if(mode.topocImageList.count>=1&&mode.topocImageList.count<=3)
        {
            if (mode.topocImageList.count==1) {
                cell.manyImageV.frame=CGRectMake(_width*0.03, h1+75-45, _width*0.94, _width*0.5);
                cell.detailContent.frame=CGRectMake(_width*0.03, h1+20+cell.manyImageV.frame.size.height+10, _width*0.94,h2+10);
                cell.lowView.frame=CGRectMake(0, cellH1-45, _width, 45);

//                cell.lowView.frame=CGRectMake(0, h1+h2+75-45+_width*0.5, _width, 45);

            }else if (mode.topocImageList.count==2){
                cell.manyImageV.frame=CGRectMake(_width*0.03, h1+75-45, _width*0.94, _width*0.35);

                cell.detailContent.frame=CGRectMake(_width*0.03, h1+20+cell.manyImageV.frame.size.height+10, _width*0.94,h2+10);
                cell.lowView.frame=CGRectMake(0, cellH1-45, _width, 45);

//                cell.lowView.frame=CGRectMake(0, h1+h2+75-45+_width*0.35, _width, 45);

            }else{
                cell.manyImageV.frame=CGRectMake(_width*0.03, h1+75-45, _width*0.94, _width*0.25);
                cell.detailContent.frame=CGRectMake(_width*0.03, h1+20+cell.manyImageV.frame.size.height+10, _width*0.94,h2+10);
                cell.lowView.frame=CGRectMake(0, cellH1-45, _width, 45);

//                cell.lowView.frame=CGRectMake(0, h1+h2+75-45+_width*0.25, _width, 45);

            }





        }else if (mode.topocImageList.count>3&&mode.topocImageList.count<=6)
        {
            cell.manyImageV.frame=CGRectMake(_width*0.03, h1+75-45, _width*0.94, _width*0.52);
            cell.detailContent.frame=CGRectMake(_width*0.03, h1+20+cell.manyImageV.frame.size.height+10, _width*0.94,h2+10);
            cell.lowView.frame=CGRectMake(0, cellH1-45, _width, 45);

//            cell.lowView.frame=CGRectMake(0, h1+h2+75-45+_width*0.52, _width, 45);
        }
        else
        {
            cell.manyImageV.frame=CGRectMake(_width*0.03, h1+75-45, _width*0.94,_width*0.79);
            cell.detailContent.frame=CGRectMake(_width*0.03, h1+20+cell.manyImageV.frame.size.height+10, _width*0.94,h2+10);
            cell.lowView.frame=CGRectMake(0, cellH1-45, _width, 45);

//            cell.lowView.frame=CGRectMake(0, h1+h2+75-45+_width*0.79, _width, 45);
        }
        if (cell.pubContent.text.length>50) {
            cell.lowView.frame=CGRectMake(0, cellH1-45, _width, 45);

//            cell.lowView.frame=CGRectMake(0,cell.lowView.frame.origin.y, _width, 45);

        }

        [cell.jubao addTarget:self action:@selector(jubao:) forControlEvents:UIControlEventTouchUpInside];
//
//        cell.zanBtn.tag=indexPath.section;
        [cell.zanBtn addTarget:self action:@selector(zanbutton) forControlEvents:UIControlEventTouchUpInside];
        [cell.pinglun addTarget:self action:@selector(pingbutton) forControlEvents:UIControlEventTouchUpInside];

    }



    }
    else
        if (indexPath.section==1){
        //评论区
//            if (indexPath.row ==1) {
//                cell.backgroundColor = [UIColor redColor];
//            }
            [cell setSeparatorInset:UIEdgeInsetsMake(2, 0, 0, 0)];
                cell.lowView.hidden =YES;
                if ((NSNull *)[modleArray[indexPath.row] face]==[NSNull null]) {
                    cell.userFace.image =[UIImage imageNamed:@"userFace"];
                }else{
                    [cell.userFace sd_setImageWithURL:[NSURL URLWithString:[modleArray[indexPath.row] face]]
                                     placeholderImage: [UIImage imageNamed:@"userFace"]];

                }
            cell.userName.frame  = CGRectMake(_width*0.03+50, 8, _width*0.7-40, 15);
            cell.userName.text=[modleArray[indexPath.row] nickName];

           CGFloat ww= [self boundWithSize:CGSizeMake(_width*0.7-40, 0) WithLabel:cell.userName].width;

            UILabel *rankLab = [[UILabel alloc]initWithFrame:CGRectMake(cell.userName.frame.origin.x+ww+10, 8, _width*0.2, 15)];
            rankLab.textColor=RGB(214, 194, 44);
            rankLab.font= [UIFont systemFontOfSize:15];
            [cell.contentView addSubview:rankLab];
                rankLab.text = [modleArray[indexPath.row] exp];


            NSString *commentContentstr = [NSString stringWithFormat:@"    %@",[modleArray[indexPath.row] commentContent]];


                cell.pubTime.text = [self changeTimeString:[modleArray[indexPath.row] commentDate]];
                cell.pubContent.text = commentContentstr;
                cell.pubContent.textColor =[UIColor darkGrayColor];
            cell.pubContent.textAlignment = NSTextAlignmentLeft;
            cell.pubContent.font =[UIFont systemFontOfSize:14];


                Plhh= [self boundWithSize:CGSizeMake(_width*0.94, 0) WithString:cell.pubContent.text WithFont:[UIFont systemFontOfSize:14]].height;
                cell.pubContent.frame=CGRectMake(_width*0.03, 45, _width*0.94,Plhh+10);

            UIView*line=[[UIView alloc]init];

            line.backgroundColor=RGB(234, 234, 234);
//            [cell addSubview:line];

               if ([USERID isEqualToString:_modle.userId]) {


                myButton *replay = [[myButton alloc]initWithFrame:CGRectMake(_width*0.75, 15, _width*0.2, 44)];
                [replay addTarget:self action:@selector(replayClick:) forControlEvents:UIControlEventTouchUpInside];
                replay.tag = indexPath.row;
                replay.nameString = [modleArray[indexPath.row] nickName];
                topicCommentIdSSS =[modleArray[indexPath.row] topicCommentId];
//                replay.catagerid  = [modleArray[indexPath.row] topicCommentId];


                UIButton *jbbtn =[[UIButton alloc]init];
                jbbtn.bounds = CGRectMake(0, 0, _width*0.15, 20);
                jbbtn.center=replay.center;
                [jbbtn setTitle:@"回复" forState:UIControlStateNormal];
                [jbbtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                jbbtn.titleLabel.font = [UIFont systemFontOfSize:12];
                jbbtn.userInteractionEnabled=NO;
                jbbtn.layer.cornerRadius = 7;
                jbbtn.layer.borderWidth=1;
                jbbtn.layer.borderColor= COR_ClOUR.CGColor;
                [cell.contentView addSubview:jbbtn];
                [cell.contentView addSubview:replay];

                   if((NSNull*)[modleArray[indexPath.row] replayContent]!=[NSNull null]){

                       replay.hidden = YES;
                       jbbtn.hidden = YES;
                   }

                if ((NSNull*)[modleArray[indexPath.row] replayContent]!=[NSNull null]) {
                    cell.repalyLab.text = [NSString stringWithFormat:@"    回复%@：%@",[modleArray[indexPath.row] nickName],[modleArray[indexPath.row] replayContent]];
                    
                    cell.repalyLab.attributedText = [self changColor:cell.repalyLab.text FirstName:@"" SecondName:[modleArray[indexPath.row] nickName]];

                    HFhh= [self boundWithSize:CGSizeMake(_width*0.94, MAXFLOAT) WithString:cell.repalyLab.text WithFont:[UIFont systemFontOfSize:14]].height;
                    cell.repalyLab.frame=CGRectMake(_width*0.03, 40+Plhh+15, _width*0.94,HFhh);

                }

                line.frame =CGRectMake(0, HFhh+Plhh+55+10, _width, 1);

            }else{
                line.frame =CGRectMake(0, HFhh+Plhh+55+10, _width, 1);
                if ((NSNull*)[modleArray[indexPath.row] replayContent]!=[NSNull null]) {

                    cell.repalyLab.text = [NSString stringWithFormat:@"    %@回复%@：%@",_modle.nickName,[modleArray[indexPath.row] nickName],[modleArray[indexPath.row] replayContent]];

                    cell.repalyLab.attributedText = [self changColor:cell.repalyLab.text FirstName:_modle.nickName SecondName:[modleArray[indexPath.row] nickName]];

                    HFhh= [self boundWithSize:CGSizeMake(_width*0.94, MAXFLOAT) WithString:cell.repalyLab.text WithFont:[UIFont systemFontOfSize:14]].height;
                    cell.repalyLab.frame=CGRectMake(_width*0.03, 45+Plhh+10, _width*0.94,HFhh);
                    
                }
            }
        }

    return cell;
}

-(void)replayClick:(myButton*)sender{

 if((NSNull*)[modleArray[sender.tag] replayContent]==[NSNull null]){
        _HFlview =nil;

     self.lview.frame =CGRectMake(0, _height, _width, 60);
     if (_HFlview ==nil) {
            _HFlview = [[UIView alloc]initWithFrame:CGRectMake(0, _height-60, _width, 60)];
            _tableview.frame = CGRectMake(0, 64, _width, _height-64-60);
            _HFlview.backgroundColor=RGB(234, 234, 234);
            [self.view addSubview:_HFlview];
            _HFtextfiled = [[UITextField alloc]initWithFrame:CGRectMake(_width*0.05, 12, _width*0.7, 36)];
            [_HFlview addSubview:_HFtextfiled];
            _HFtextfiled.delegate=self;
            _HFtextfiled.placeholder=  [NSString stringWithFormat:@"回复%@：",sender.nameString];
            _HFtextfiled.layer.cornerRadius=7;
            _HFtextfiled.tag =333;
            _HFtextfiled.backgroundColor = [UIColor whiteColor];

            topicCommentIdSSS =[modleArray[sender.tag] topicCommentId];

            UIButton *plbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            plbutton.frame = CGRectMake(_width*0.8, 12, _width*0.15, 36);
            [_HFlview addSubview:plbutton];
            plbutton.layer.cornerRadius=5;
            plbutton.backgroundColor =APP_ClOUR;
            [plbutton setTitle:@"发送"forState:UIControlStateNormal];
            [plbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [plbutton addTarget:self action:@selector(HFbutton) forControlEvents:UIControlEventTouchUpInside];
        }else{
            _HFlview.frame =CGRectMake(0, _height-60, _width, 60);
            _tableview.frame = CGRectMake(0, 64, _width, _height-64-60);

        }
 }else{

         MISSINGVIEW
         missing_v.tishi  = @"您已回复过该条评论了！";
     }



}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"section ===%ld===row===%ld",(long)indexPath.section,(long)indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.view endEditing:YES];
}
//仿照评论。写上传回复内容
-(void)HFbutton{
//    NSLog(@"回复成功");

    if ([_HFtextfiled.text isEqualToString:@""]) {
        return;
    }

    LOADVIEW
    viewh.remind_L=@"正在提交数据";
    
    NSLog(@"+恢复评论的ID===%@",REPLAY(_HFtextfiled.text, topicCommentIdSSS));
    [requestData getData:REPLAY(_HFtextfiled.text, topicCommentIdSSS) complete:^(NSDictionary *dic) {
        LOADREMOVE
        if ([[dic objectForKey:@"flag"] intValue]==1) {

            [self getdata];
            [self getData:self.topicsId];
        }else
        {
            NSLog(@"11111111");

        }
        MISSINGVIEW
        missing_v.tishi=[NSString stringWithFormat:@"%@",[dic objectForKey:@"info"]];
    }];


}
-(void)pingbutton{
    NSLog(@"ping");
    if (USERID==nil) {
        ALLOC(logInVC)
        [self presentViewController:vc animated:NO completion:^{

        }];
    }else{
        self.HFlview.frame =CGRectMake(0, _height, _width, 60);

        _lview=nil;
        if (_lview ==nil) {
            _lview = [[UIView alloc]initWithFrame:CGRectMake(0, _height-60, _width, 60)];
            _tableview.frame = CGRectMake(0, 64, _width, _height-64-60);

            _lview.backgroundColor=RGB(234, 234, 234);
            [self.view addSubview:_lview];

            _textfiled = [[UITextField alloc]initWithFrame:CGRectMake(_width*0.05, 12, _width*0.7, 36)];
            [_lview addSubview:_textfiled];
            _textfiled.delegate=self;
            _textfiled.placeholder=@"我也要评论";
            _textfiled.layer.cornerRadius=7;
            _textfiled.tag =222;
            _textfiled.backgroundColor = [UIColor whiteColor];


            UIButton *plbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            plbutton.frame = CGRectMake(_width*0.8, 12, _width*0.15, 36);
            [_lview addSubview:plbutton];
            plbutton.layer.cornerRadius=5;
            plbutton.backgroundColor =APP_ClOUR;
            [plbutton setTitle:@"评论"forState:UIControlStateNormal];
            [plbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [plbutton addTarget:self action:@selector(plbutton) forControlEvents:UIControlEventTouchUpInside];
        }else{
            _lview.frame =CGRectMake(0, _height-60, _width, 60);
            _tableview.frame = CGRectMake(0, 64, _width, _height-64-60);

        }

    }



}

-(void)zanbutton{

    NSLog(@"%@////%@////",self.modle.userId,self.modle.topicsId);

        if (USERID!=nil) {
//            NSDictionary*dic=[_dataArray objectAtIndex:button.tag];
//            //NSString*userId=[dic objectForKey:@"userId"];
//            NSString*storyId=[dic objectForKey:@"storyId"];


            [requestData getData:STORY_LIST_ZAN_URL(USERID, self.modle.topicsId) complete:^(NSDictionary *dic) {
                NSLog(@"%@",dic);
                MISSINGVIEW
                if ([[dic objectForKey:@"flag"] intValue]==0) {
                    missing_v.tishi=[NSString stringWithFormat:@"%@",@"已点赞"];
                    NSLog(@" miss");

                }else
                {
                    missing_v.tishi=[NSString stringWithFormat:@"%@",@"点赞成功"];
                    self.isdianzan=YES;
                    [self getData:self.topicsId];

                }

            }];
            
        }else
        {
            ALLOC(logInVC)
            [self presentViewController:vc animated:NO completion:^{

            }];
        }
        

}
//请求话题内容
-(void)getData:(NSString *)topicsId
{
    NSString *str = [NSString stringWithFormat:@"%@/topics/get.action?topicsId=%@",BASE_URLL,topicsId];

//    LOADVIEW
    [requestData getData:str complete:^(NSDictionary *dic) {
        NSDictionary *dict = [dic objectForKey:@"data"];
//        LOADREMOVE
//        NSLog(@"+++++%@",dic);

            self.modle =[[Modle alloc]init];

            _modle.typeName = dict[@"typeName"];//类别
            _modle.topicsTitle = dict[@"topicsTitle"];//主题
            _modle.topicsContent = dict[@"topicsContent"];//内容
            _modle.userId = dict[@"userId"];//用户账号
            _modle.topocImageList =dict[@"topocImageList"];//内容图片
            _modle.praiseCount = dict[@"praiseCount"];//点赞数
            _modle.commentCount=dict[@"commentCount"];//评论数
            _modle.topicsDate=dict[@"topicsDate"];//发表时间
            _modle.nickName=dict[@"nickName"];
            _modle.topicsId=dict[@"topicsId"];


            if ((NSNull*)_modle.topocImageList==[NSNull null]) {
            }
//        modle1Array =[NSArray arrayWithArray:array1];
        [_tableview reloadData];

    }];
}

//举报事件
-(void)jubao:(UIButton*)button{
    NSLog(@"举报");
    
    PUSH(jubaoVC)
    vc.userId =self.modle.userId;
    vc.topicsId = self.modle.topicsId;
}
//返回事件
-(void)backClick{
    //返回上一级VC
    NSLog(@"22");
    POP
}
//图片点击查看大图
-(void)ImageBtnClick:(UIButton*)button

{
  NSArray *imageListArray = self.modle.topocImageList;
    UIView*view1=(UIView*)[button superview];

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
//查看大图模式下，下标变化
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //NSLog(@"fchwoie");
    int currentPage=_imageScrollView.contentOffset.x/_width+1;
    _page_L.text=[NSString stringWithFormat:@"%d/%d",currentPage,_page_number];

//    _pc.currentPage=_smallScrollV.contentOffset.x/_width;

}
//双击
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
//单击事件
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

//插看大图模式下的返回
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
    NSLog(@"return");
    [textField resignFirstResponder];
    if (textField.tag==222) {
        [self plbutton];

    }else if (textField.tag==333){
        [self HFbutton];
    }
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

    
- (NSString *)changeTimeString:(NSString *)timestring
{
    NSDateFormatter *datef= [[NSDateFormatter alloc]init];
    [datef setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSDate *Date= [datef dateFromString:timestring];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [formatter stringFromDate:Date];
}

-(NSMutableAttributedString*)changColor:(NSString*)string  FirstName:(NSString*)first SecondName:(NSString*)second{

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:string];

    NSLog(@"first.length===%ld",first.length);
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, first.length+4)];

    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(first.length+2+4, second.length)];



    return str;
}

@end
