//
//  mystoryVC.h
//  logRegister
//
//  Created by apple on 15-1-29.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDRefresh.h"
#import "Modle.h"

@interface mystoryVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIAlertViewDelegate>
{
    CGFloat         _width;
    CGFloat         _height;
//    NSArray         *_dataArray;
    UITableView     *_tableView;
    CGFloat         _tabH;
    UIScrollView    *_scrollView;
    NSMutableArray  *_imageArray;

    SDRefreshHeaderView*_refesh;
    SDRefreshFooterView*_refeshDown;


    NSMutableArray *listArray;
    NSString            *_currentId;

    NSArray *modle1Array;

    //NSMutableArray  *_imageArray;

    UIScrollView    *_imageScrollView;
    UILabel         *_page_L;
    int             _page_number;
    float           HH;
    UIView          *_loadingView;

    UIImageView    *_smallView;


    UIView          *BGView;

    UIView          *_imagePickView;


    UIScrollView        *_bigImageSvrollView;
}

@property(nonatomic,copy)NSString*whoPush;
@property(nonatomic,strong)Modle*modle;

@property(nonatomic,strong)UIView*lowView;
@property(nonatomic,strong)UIView*zan_ju_view;
@property(nonatomic,strong)UILabel*collectNum;
@property(nonatomic,strong)UIButton*zanBtn;
@property(nonatomic,strong)UIButton*typen;
@property(nonatomic,strong)UIButton*pinglun;
@property(nonatomic,strong)UILabel*zanlab;
@property(nonatomic,strong)UILabel*PLlab;

@end
