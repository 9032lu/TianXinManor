//
//  hospitalVC.h
//  PsychiatricConsulting
//
//  Created by apple on 15-5-6.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hospitalVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    SCREEN_WIDTH_AND_HEIGHT
    UITableView     *_tableView;

    NSArray         *_dataArray;
    UIScrollView    *_scrollView;

    UIButton        *_lastBtn;

    UIImageView     *_shopbg;
    UIImageView     *_shop_logo;
    UILabel         *_address_l;

    UILabel         *_shopPeoNum_L;
    UIButton         *_shopGrade;
    UILabel         *_shopAdress_L;

    UILabel         *_shopName_L;
    NSDictionary        *_dataDic;

    float           _descH;
    NSString        *_phoneNumber;
    NSString        *_shopDesc;
    NSString        *_shopAddress;
    NSString        *_shopName;

    UIButton*renzhengIV;
    UIButton*renzheng_L;


    UIView          *_moveView;
    UIButton        *_currentBTn;

}
@property(nonatomic,strong)NSString*shopId;
@property(nonatomic,strong)NSString*isSincerity;

@end
