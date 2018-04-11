//
//  PostSaleCell.h
//  TianXinManor
//
//  Created by apple on 15/12/11.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostSaleCell : UITableViewCell

{
        CGFloat         _width;
        CGFloat         _height;
        
}

@property(nonatomic,strong)UILabel*RealPrice_La;

@property(nonatomic,strong)UILabel *stateLab;
@property(nonatomic,strong) UILabel*productName;
@property(nonatomic,strong) UIImageView*productIv;


@property(nonatomic, copy) NSString * productNames;

@property(nonatomic,copy)NSString*productImage;

@end
