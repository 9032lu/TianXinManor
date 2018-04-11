//
//  comentCell.h
//  logRegister
//
//  Created by apple on 15-1-22.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface comentCell : UITableViewCell
{
    CGFloat         _width;
    CGFloat         _height;
}
@property(nonatomic,strong)UIButton*productBrn;
@property(nonatomic,strong)UIImageView*productIv;
@property(nonatomic,strong)UILabel*productName;
@property(nonatomic,strong)UILabel*price;
@property(nonatomic,strong)UILabel*number_L;
@property(nonatomic,strong)UIButton*selectBtn1;
@property(nonatomic,strong)UIButton*selectBtn2;
@property(nonatomic,strong)UIButton*selectBtn3;
@property(nonatomic,strong)UITextField*coment_tf;
@property(nonatomic,strong)UIButton*coment_B;

@end
