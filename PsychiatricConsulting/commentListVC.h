//
//  commentListVC.h
//  logRegister
//
//  Created by apple on 15-1-22.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commentListVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    CGFloat         _width;
    CGFloat         _height;
    UIScrollView    *_scrollView;
    UIButton        *_lastBtn;
    UIView          *_moveView;

    UITableView     *_tableview;

    NSArray         *_commentArray;
    UIView          *_loadingView;
    UILabel*tishi;
}
@property(nonatomic,strong)NSString*productId;
@end
