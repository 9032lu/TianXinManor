//
//  myAdressVC.h
//  logRegister
//
//  Created by apple on 15-1-12.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDRefresh.h"
@interface myAdressVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UITextFieldDelegate>
{
    CGFloat         _width;
    CGFloat         _height;

    UIScrollView    *_scrollView;
    UIView          *_alpaView;


    UITextField     *_adress_tf;
    UITextField     *_detailA_tf;
    UITextField     *_name_tf;
    UITextField     *_phone_tf;
    UITextField     *_email_tf;


    UITableView     *_tableView;
    NSMutableArray  *_adressArray;

    SDRefreshHeaderView*_refesh;
    SDRefreshFooterView*_refeshDown;


    UIButton        *_lastButton;


    int             _addressId;
    int             _isdefault;
    UIView          *_loadingView;

    UIButton        *_provice_B;
    NSString        *_ssq_str;

}
@property(nonatomic,copy)NSString*whoPush;
@property(nonatomic,copy)NSString*orders;

@end
