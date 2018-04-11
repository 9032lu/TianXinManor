//
//  newsVC.h
//  ShengMengShangmao
//
//  Created by apple on 15-3-26.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newsVC : UIViewController<UITableViewDataSource,UITableViewDelegate
>
{
    SCREEN_WIDTH_AND_HEIGHT
    UITableView     *_tableView;
    NSTimer         *_timer;
    UIScrollView    *_smallScrollV;
    NSMutableArray  *_advistArray;
    UIPageControl   *_pc;
    UIButton        *_lastBtn;
    SDRefreshHeaderView*_refesh;
    SDRefreshFooterView*_refeshDown;

    


    NSArray         *_dataArray;
}
@end
