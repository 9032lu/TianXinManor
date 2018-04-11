//
//  storyVC.h
//  logRegister
//
//  Created by apple on 15-3-14.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDRefresh.h"

@interface storyVC : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
{
    CGFloat         _width;
    CGFloat         _height;
    UIScrollView    *_scrollView;
    NSTimer         *_timer;

    UIScrollView    *_smallScrollV;
    UIPageControl   *_pc;

    SDRefreshHeaderView*_refesh;
    SDRefreshFooterView*_refeshDown;
    int             _number;

    NSArray         *_dataArray;
    NSArray         *_advistArray;

    UITableView     *_tableView;
    float           _tabH;


    NSMutableArray  *_imageArray;

    UIScrollView    *_imageScrollView;
    UILabel         *_page_L;
    int             _page_number;
    UIView          *_loadingView;



    UIView          *BGView;

    UIView          *BGImageView;

    UIScrollView      *_bigImageSvrollView;
    
    
    BOOL                success;

    int             _currentSize;


    int             _currentAdv;
    
    
}
@property(nonatomic,assign)BOOL  isdianzan;
@end
