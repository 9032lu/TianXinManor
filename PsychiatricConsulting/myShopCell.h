//
//  myShopCell.h
//  logRegister
//
//  Created by apple on 15-1-12.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myShopCell : UITableViewCell
{
    CGFloat         _width;
    CGFloat         _height;

}
@property(nonatomic,retain)UIView       *myView;
@property(nonatomic,retain)UIView       *shuview;
@property(nonatomic,retain)UIButton     *imageV;
@property(nonatomic,retain)UIButton     *shopBtn;
@property(nonatomic,retain)UILabel      *name;
@property(nonatomic,retain)UIImageView  *locaIV;
@property(nonatomic,retain)UILabel      *loca_distance;

@end
