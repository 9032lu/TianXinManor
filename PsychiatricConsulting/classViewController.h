//
//  classViewController.h
//  meishi
//
//  Created by apple on 15/6/2.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "shopCarVC.h"
#import "productVC.h"
#import "searchViewController.h"
#import "transformTime.h"
#import "MZTimerLabel.h"
@interface classViewController : UIViewController

@property(nonatomic ,copy)NSString *categoryId;
@property(nonatomic ,copy)NSString *categoryName;


@property(nonatomic,copy)NSString*kw;
@property(nonatomic,copy)NSString*whoPush;


@end
