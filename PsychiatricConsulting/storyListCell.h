//
//  storyListCell.h
//  logRegister
//
//  Created by apple on 15-1-23.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface storyListCell : UITableViewCell

{
    CGFloat     _width;
    CGFloat     _height;
    
}

@property(nonatomic,strong)UIImageView*userFace;
@property(nonatomic,strong)UIImageView*timeIV;
@property(nonatomic,strong)UILabel*userName;
@property(nonatomic,strong)UILabel*pubTime;
@property(nonatomic,strong)UILabel*pubContent;
@property(nonatomic,strong)UILabel*topicsTitle;
@property(nonatomic,strong)UILabel*detailContent;


@property(nonatomic,strong)UIView*manyImageV;

@property(nonatomic,strong)UIView*lowView;
@property(nonatomic,strong)UIView*zan_ju_view;
@property(nonatomic,strong)UILabel*collectNum;
@property(nonatomic,strong)UIButton*zanBtn;
@property(nonatomic,strong)UIButton*jubao;
@property(nonatomic,strong)UIButton*pinglun;
@property(nonatomic,strong)UILabel*pinglunLab;
@property(nonatomic,strong) UILabel *repalyLab;




@end
