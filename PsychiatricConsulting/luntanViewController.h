//
//  luntanViewController.h
//  PsychiatricConsulting
//
//  Created by mac on 15-8-30.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface luntanViewController : UIViewController

@property(nonatomic,strong)UIView*lowView;
@property(nonatomic,strong)UIView*zan_ju_view;
@property(nonatomic,strong)UILabel*collectNum;
@property(nonatomic,strong)UIButton*zanBtn;
@property(nonatomic,strong)UIButton*jubao;
@property(nonatomic,strong)UIButton*pinglun;
@property(nonatomic,strong)UILabel*zanlab;
@property(nonatomic,strong)UILabel*PLlab;
@property(nonatomic,copy)NSString *interactiveId;
@property(nonatomic,copy)NSString*titleName;
@property(nonatomic,strong)UIButton*typen;

@property(nonatomic,assign)BOOL  isdianzan;

@end
