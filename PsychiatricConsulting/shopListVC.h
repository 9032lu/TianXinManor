//
//  shopListVC.h
//  logRegister
//
//  Created by apple on 15-1-12.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDRefresh.h"
@interface shopListVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    CGFloat         _width;
    CGFloat         _height;
    UIScrollView    *_scrollView;

    UITableView     *_tableView;

    NSMutableArray         *_shopArray;
    UIView          *_loadingView;

    SDRefreshHeaderView*_refesh;
    SDRefreshFooterView*_refeshDown;

    int            _currentId;

    int             count;

}
@property(nonatomic,copy)NSString*whoPush;
@property(nonatomic,copy)NSString *url;
@end
