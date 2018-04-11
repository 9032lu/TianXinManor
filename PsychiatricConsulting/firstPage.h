//
//  firstPage.h
//  ShengMengShangmao
//
//  Created by apple on 15-3-26.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface firstPage : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UITextFieldDelegate,CLLocationManagerDelegate,MKMapViewDelegate>
{
    SCREEN_WIDTH_AND_HEIGHT

    UITableView     *_tableView;

    UITextField     *_text_f;
//    UITextField     *_text_no;

    NSTimer         *_timer;
    UIScrollView    *_smallScrollV;
    NSArray         *_advistArray;
    UIPageControl   *_pc;

    NSArray         *_shopA;
    NSArray         *_productA;
    NSArray         *_categoryA;
    NSArray         *_proListA;
    NSArray         *_shopListA;

    UILabel         *_city_L;


    CLLocationManager    *_locationManger;

    UIView              *_redView;

    
}
@end
