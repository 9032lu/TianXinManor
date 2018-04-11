//
//  detailViewController.h
//  PsychiatricConsulting
//
//  Created by apple on 15/8/28.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Modle.h"
@interface detailViewController : UIViewController

{
    int             _page_number;
    UIView          *BGView;

    UIView          *BGImageView;
    UILabel         *_page_L;

    UIScrollView      *_bigImageSvrollView;
    UIScrollView    *_imageScrollView;
NSString *topicCommentIdSSS;



}
@property(nonatomic,copy)NSString*whoPush;

@property(nonatomic,strong)UIImageView*userFace;
@property(nonatomic,strong)UIImageView*timeIV;
@property(nonatomic,strong)UILabel*userName;
@property(nonatomic,strong)UILabel*pubTime;
@property(nonatomic,strong)UILabel*pubContent;
@property(nonatomic,strong)UIView*manyImageV;
@property(nonatomic,strong)UILabel *topictitle;

@property(nonatomic,strong)UIView*lowView;
@property(nonatomic,strong)UIView*zan_ju_view;
@property(nonatomic,strong)UILabel*collectNum;
@property(nonatomic,strong)UIButton*zanBtn;
@property(nonatomic,strong)UIButton*jubao;
@property(nonatomic,strong)UIButton*pinglun;
@property(nonatomic,strong)UILabel*zanlab;
@property(nonatomic,strong)UILabel*PLlab;

@property(nonatomic,copy)NSString*topicsId;
@property(nonatomic,strong)Modle *modle;

@property(nonatomic,assign)BOOL  isdianzan;





@end
