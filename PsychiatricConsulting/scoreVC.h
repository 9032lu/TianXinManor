//
//  scoreVC.h
//  ShengMengShangmao
//
//  Created by apple on 15-3-27.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface scoreVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    SCREEN_WIDTH_AND_HEIGHT
    UITableView     *_tableView;
    NSTimer         *_timer;
    UIScrollView    *_smallScrollV;
    NSMutableArray  *_advistArray;
    UIPageControl   *_pc;
    UIButton        *_lastBtn;




    NSArray         *_dataArray;
    SDRefreshHeaderView*_refesh;
    SDRefreshFooterView*_refeshDown;
   
}

@end
