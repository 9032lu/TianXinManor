//
//  sureOrderVC.h
//  ShengMengShangmao
//
//  Created by apple on 15-3-31.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "payRequsestHandler.h"

@interface sureOrderVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>

{
    SCREEN_WIDTH_AND_HEIGHT
    UIButton        *_lastBtn;
    UITableView     *_tableView;
    NSArray         *_dataArray;


    UILabel         *_totalLabel;

    double          _totalprice;
    NSMutableArray  *_countArray;
    NSString        *_shopId;






    NSDictionary    *_defaultAddressDic;
    NSDictionary    *_currentAddress;
    NSDictionary    *_currentCoup;
    NSString        *_currentPayWay;
    NSString        *_currentRemark;

    UILabel         *_missing_label;

    NSMutableArray         *_paymentA;

    NSString        *_currentPayMent;

}
@property(nonatomic,strong)NSDictionary*InfoArray;
@property(nonatomic,strong)NSString*whoPush;
@end
