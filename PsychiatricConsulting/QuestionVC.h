//
//  QuestionVC.h
//  TianXinManor
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myButton.h"
@interface QuestionVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    SCREEN_WIDTH_AND_HEIGHT
    UITableView*_tableView;
    SDRefreshFooterView *_refeshDown;
    SDRefreshHeaderView *_refesh;
    NSString *_currentId;
    NSString *_moreId;

    NSMutableArray             *_dataArray;
    UIButton *oldbutton;
    myButton*rightUpBtnBack;

}

@property(nonatomic,copy)NSString*productId;

@end
