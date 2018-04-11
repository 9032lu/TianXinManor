//
//  jifenListVC.h
//  PsychiatricConsulting
//
//  Created by apple on 15/5/14.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface jifenListVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

{
    SCREEN_WIDTH_AND_HEIGHT
    UIButton        *_lastBtn;
    UITableView     *_tableView;
    NSArray         *_dataArray;

    NSArray         *_testA;
    SDRefreshHeaderView*_refesh;
    SDRefreshFooterView*_refeshDown;

}
@property(nonatomic,copy)NSString*orders;


@end
