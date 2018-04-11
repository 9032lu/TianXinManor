//
//  notificationVCViewController.h
//  logRegister
//
//  Created by apple on 15-4-21.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface notificationVCViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{

    CGFloat         _width;
    CGFloat         _height;

    UITableView     *_tableView;

    NSArray         *_dataArray;
}
@property(nonatomic,copy)NSString*whoPush;
@end
