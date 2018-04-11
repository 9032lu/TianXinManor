//
//  citySelectVC.h
//  logRegister
//
//  Created by apple on 15-3-3.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface citySelectVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    CGFloat         _width;
    CGFloat         _height;

    UITableView     *_tableView;


    NSArray         *_provinceArray;
    NSArray         *_cityArray;
    NSArray         *_distructArray;
    NSArray         *_currentArray;



    UILabel         *_address_L;

    NSString        *_province;
    NSString        *_city;
    NSString        *_distruct;
    UIButton        *_backUp;



    NSString        *_province_Id;
    NSString        *_city_Id;
    NSString        *_distruct_Id;





}
@property(nonatomic,copy)NSString* present;

@end
