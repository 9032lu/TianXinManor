//
//  productCenterViewController.h
//  PsychiatricConsulting
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlanLine.h"
#import <QuartzCore/QuartzCore.h>
#import "classViewController.h"
#import "Modle.h"
#import "myButton.h"
@interface productCenterViewController : UIViewController<UIScrollViewDelegate,MakeLine>
{
    UIButton *yearbutton;
    NSArray *arrayYears;
    NSMutableArray*buttonArray;
    UIScrollView *bigScrol;
    NSArray*dataArray;
   NSMutableArray *_modleArray;
}
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *massageView;
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) NSMutableArray *array;
@property (strong, nonatomic) UIImageView *massageImageView;
@property (strong, nonatomic) UIImageView *imageView;






@end
