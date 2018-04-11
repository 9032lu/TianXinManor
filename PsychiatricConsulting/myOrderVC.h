//
//  myOrderVC.h
//  PsychiatricConsulting
//
//  Created by apple on 15-5-7.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myOrderVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    SCREEN_WIDTH_AND_HEIGHT
    UITableView     *_tableView;

    NSArray         *_dataArray;

    NSString *oppoint;
}

@end
