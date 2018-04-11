//
//  myOrderDetailVC.h
//  PsychiatricConsulting
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myOrderDetailVC : UIViewController
@property(nonatomic,copy)NSString*appointmentId;
@property(nonatomic,copy)NSString*whoPush;
@property(assign,nonatomic)BOOL IsEnd;

@end
