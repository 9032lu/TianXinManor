//
//  personCenter.h
//  ShengMengShangmao
//
//  Created by apple on 15-3-26.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface personCenter : UIViewController
<UITableViewDataSource,UITableViewDelegate>

{
     SCREEN_WIDTH_AND_HEIGHT

    UIScrollView    *_scrollView;

    UIImageView     *_bg;
    UIButton        *_userHead;
    UILabel         *_userName;
    UILabel         *_userScore;
    UILabel         *_userRank;
    UITableView     *_tableView;
    UIView          *_loadingView;
    UILabel         *_dengji;

    UIScrollView            *_downwardView;
    UIButton *selectImg;

    NSDictionary *signDic;
    NSDictionary *SignedOrNot;

    NSString*fukuan;
    NSString*fahuo;
    NSString*pinglun;
    NSString*tuikuang;

}

@end
