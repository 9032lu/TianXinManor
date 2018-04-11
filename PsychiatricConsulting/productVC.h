//
//  productVC.h
//  ShengMengShangmao
//
//  Created by apple on 15-4-1.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocial.h"
#import "myButton.h"
@interface productVC : UIViewController
<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UITextFieldDelegate,UIWebViewDelegate,UMSocialUIDelegate>
{
    SCREEN_WIDTH_AND_HEIGHT

    UITableView     *_tableView;

    UIScrollView    *_smallScrollV;
    UIPageControl   *_pc;
    
    UILabel         *_productCode_L;
    UILabel         *_productName_L;
    UILabel         *_price_L;
    UILabel         *_ratePrice_L;
    UILabel         *_post_L;
    UILabel         *_saleQulity_L;
    UILabel         *_qulity_L;
    UILabel         *_clicks_L;

    UILabel         *_redNumber;
    NSTimer         *_timer;
    myButton*rightUpBtnBack;


    NSDictionary    *_dataDic;
    NSArray         *_productImageA;
    UITableView *smallTableView;
    NSMutableArray *_dataArray;
    NSMutableArray *_propertyArray;

    UIView          *BGView;

    UIView          *BGImageView;
    UIScrollView    *_imageScrollView;
    UILabel         *_page_L;
    UIScrollView    *_bigImageSvrollView;

    UIButton *oldbutton;
    float           _imageH;
    UIWebView*web;

    UIView          *_bgView;
     int        _page_number;

    NSString        *_count;

    int       number;
    BOOL markId;

    UILabel         *_missing_label;

    float           _webH;
    float           _webHight;

}
@property(nonatomic,copy)NSString*productId;
@property(nonatomic,copy)UIImage*imagepath;
@property(nonatomic,copy)NSString*producdesc;
@property(nonatomic,copy)NSString*productP;
@property(nonatomic,copy)NSString*shopId;
@property(nonatomic,assign)BOOL isSKU;

@property(nonatomic,copy)NSString*isWhoPush;

@end
