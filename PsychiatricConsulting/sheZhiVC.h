//
//  sheZhiVC.h
//  logRegister
//
//  Created by apple on 15-1-14.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sheZhiVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    CGFloat         _width;
    CGFloat         _height;

    UITableView     *_tableView;
}
@property(nonatomic,copy)NSString*whoPush;
@end
