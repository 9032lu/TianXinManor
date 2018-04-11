//
//  productCollectVC.h
//  logRegister
//
//  Created by apple on 15-1-14.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDRefresh.h"
@interface productCollectVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    CGFloat         _width;
    CGFloat         _height;

    UIScrollView    *_scrollView;


    UITableView     *_tabView;
    NSMutableArray  *_array;
    UIView          *_loadingView;

    SDRefreshHeaderView*_refesh;
    SDRefreshFooterView*_refeshDown;
    NSArray        *_dataArray;

}
@property(nonatomic,assign)NSString*productId;
@end
