//
//  orderDetailVC.h
//  logRegister
//
//  Created by apple on 15-1-20.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface orderDetailVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    CGFloat         _width;
    CGFloat         _height;
    UIScrollView    *_scrollView;
    UITableView     *_tableView;
    myView          *_myView;

    UIAlertView     *_alert;

    NSArray         *_orderStateArray;
    NSArray         *_goodsArray;

    NSDictionary         *_dataDic;
    int orderS;
    int orderPayMent;

    int   shopid;
//    UIButton        *_changeBtn;
    UIView          *_loadingView;
}
@property(nonatomic,copy)NSString*orderNo;
@end
