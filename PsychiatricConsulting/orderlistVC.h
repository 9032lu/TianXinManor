//
//  orderlistVC.h
//  ShengMengShangmao
//
//  Created by apple on 15-3-27.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface orderlistVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

{
    SCREEN_WIDTH_AND_HEIGHT
    UIButton        *_lastBtn;
    UITableView     *_tableView;
    NSArray         *_dataArray;

    NSArray         *_testA;
    SDRefreshHeaderView*_refesh;
    SDRefreshFooterView*_refeshDown;

    UIButton *daipinglunBtn;

    NSInteger indexData;

   
}
@property(nonatomic,copy)NSString*orders;
@property(nonatomic,copy)NSString *woPush;
@end
