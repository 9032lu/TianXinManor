//
//  PostSale.h
//  TianXinManor
//
//  Created by apple on 15/12/10.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "productVC.h"
#import "PostSaleCell.h"
@interface PostSale : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    SCREEN_WIDTH_AND_HEIGHT
    UITableView *_tableView;
    NSMutableArray *dataArray;
    NSArray *StateArray;
    NSArray *typeArray;
    SDRefreshHeaderView*_refesh;

}
@end
