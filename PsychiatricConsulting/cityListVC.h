//
//  cityListVC.h
//  logRegister
//
//  Created by apple on 15-2-2.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cityListVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    CGFloat         _width;
    CGFloat         _height;
    UITableView     *_tableView;
    NSDictionary    *_citysDic;
    NSMutableDictionary         *_keysArray;
    UIImageView     *_selectImage;

    UILabel         *_currentCity;
    NSString        *_currentRow;

    UITableViewCell *_currentCell;
    NSArray         *_zimuArray;

    NSString        *_lastChar;



    NSMutableArray         *_cityArrar;
}

@end

