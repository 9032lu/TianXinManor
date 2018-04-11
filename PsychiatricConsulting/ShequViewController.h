//
//  ShequViewController.h
//  PsychiatricConsulting
//
//  Created by apple on 15/8/27.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShequViewController : UIViewController
@property(nonatomic,strong)UIView*lowView;
@property(nonatomic,strong)UIView*zan_ju_view;
@property(nonatomic,strong)UILabel*collectNum;
@property(nonatomic,strong)UIButton*zanBtn;
@property(nonatomic,strong)UIButton*typen;
@property(nonatomic,strong)UIButton*pinglun;
@property(nonatomic,strong)UILabel*zanlab;
@property(nonatomic,strong)UILabel*PLlab;
@property(nonatomic,assign)BOOL  isdianzan;


@end
