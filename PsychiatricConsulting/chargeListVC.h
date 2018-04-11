//
//  chargeListVC.h
//  logRegister
//
//  Created by apple on 15-1-27.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDRefresh.h"
@interface chargeListVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    CGFloat         _width;
    CGFloat         _height;
    UITableView     *_tableView;
    NSMutableArray  *_basedataArray;

    NSMutableArray  *use_dataArray;
    NSMutableArray  *notuse_dataArray;
    NSMutableArray  *_dataArray;

    UIView          *_loadingView;
    UIButton        *_lastBtn;
    BOOL isuser;


    NSIndexPath     *_currentPath;

    SDRefreshHeaderView*_refesh;
    SDRefreshFooterView*_refeshDown;


    float           desc_H;
}
@property(nonatomic,copy)NSString*whoPush;
@property(nonatomic,copy)NSString*shopId;
@property(nonatomic,copy)NSString*totalPrice;
@end
