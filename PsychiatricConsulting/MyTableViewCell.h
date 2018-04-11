//
//  MyTableViewCell.h
//  logRegister
//
//  Created by apple on 15-1-4.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell
{
    CGFloat         _width;
    CGFloat         _height;

}
@property(nonatomic,retain)UIView       *myView;
@property(nonatomic,retain)UIButton     *imageV;
@property(nonatomic,retain)UILabel      *name;
@property(nonatomic,retain)UILabel      *shanchang;


@property(nonatomic,retain)UILabel      *price;
@property(nonatomic,retain)UILabel      *comment;
@property(nonatomic,retain)UILabel      *salesQuality;
@property(nonatomic,retain)UILabel      *distance;
@property(nonatomic,retain)UIImageView  *loca_IV;
@property(nonatomic,retain)UIView       *kuang;

@end
