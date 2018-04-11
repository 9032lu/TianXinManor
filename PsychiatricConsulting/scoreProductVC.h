//
//  scoreProductVC.h
//  ShengMengShangmao
//
//  Created by apple on 15-4-1.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface scoreProductVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UITextFieldDelegate,UIWebViewDelegate>
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


    NSDictionary    *_dataDic;
    NSArray         *_productImageA;


    UIView          *BGView;

    float           _webH;

    UIView          *BGImageView;
    UIScrollView    *_imageScrollView;
    UILabel         *_page_L;
    UIScrollView    *_bigImageSvrollView;

    int        _page_number;
}
@property(nonatomic,copy)NSString*productId;

@end
