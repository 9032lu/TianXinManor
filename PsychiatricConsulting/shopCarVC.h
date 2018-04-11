//
//  shopCarVC.h
//  ShengMengShangmao
//
//  Created by apple on 15-3-26.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface shopCarVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    SCREEN_WIDTH_AND_HEIGHT
    UITableView     *_tableView;
    NSArray         *_dataArray;

    BOOL            sectionSelected;
    BOOL            allSelected;
    SDRefreshHeaderView*_refesh;
    SDRefreshFooterView*_refeshDown;



    NSMutableArray         *_currentCarId;
   
}
@property(nonatomic,copy)NSString*whoPush;
@end
