//
//  Goods.h
//  logRegister
//
//  Created by apple on 14-12-29.
//  Copyright (c) 2014年 LiZhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Goods : NSObject

@property(nonatomic,copy)NSString*advId;
@property(nonatomic,copy)NSString*advImage;
@property(nonatomic,copy)NSString*advUrl;


@property(nonatomic,copy)NSString*categoryId;
@property(nonatomic,copy)NSString*categoryName;
@property(nonatomic,copy)NSString*picPath;
@property(nonatomic,copy)NSString*isSub;
@property(nonatomic,copy)NSString*parentId;


@property(nonatomic,copy)NSString*productId;
@property(nonatomic,copy)NSString*distance;
@property(nonatomic,copy)NSString*productImage;
@property(nonatomic,copy)NSString*productName;
@property(nonatomic,copy)NSString*ratePrice;
@property(nonatomic,copy)NSString*showClicks;
@property(nonatomic,copy)NSString*salesQuality;
@property(nonatomic,copy)NSString*productQuantity;
@property(nonatomic,copy)NSString*userScore;


@property(nonatomic,copy)NSString*shopId;
@property(nonatomic,copy)NSString*shopLogo;
@property(nonatomic,copy)NSString*shopName;

@property(nonatomic,copy)NSString*userId;
@property(nonatomic,copy)NSString*regDate;
@property(nonatomic,copy)NSString*face;
@property(nonatomic,copy)NSString*score;
@property(nonatomic,copy)NSString*states;


@property(nonatomic,copy)NSString*manageId;
@property(nonatomic,copy)NSString*createTime;
@property(nonatomic,copy)NSString*root;
@property(nonatomic,copy)NSString*userName;
@property(nonatomic,copy)NSString*shopSiteName;
@property(nonatomic,copy)NSString*qRcode;
@property(nonatomic,copy)NSString*grade;


@property(nonatomic,copy)NSString*count;
@property(nonatomic,copy)NSString*cartid;
@property(nonatomic,copy)NSString*skuId;
@property(nonatomic,copy)NSString*skuName;


@property(nonatomic,copy)NSString*groupName;
@property(nonatomic,copy)NSString*groupCount;
@property(nonatomic,strong)NSString*groupImage;


@property(nonatomic,strong)NSString*add_original_p;
@property(nonatomic,strong)NSString*add_now_p;
@property(nonatomic,strong)NSString*add_name;
@property(nonatomic,strong)NSString*add_count;
@property(nonatomic,strong)NSString*add_valueId;


@property(nonatomic,strong)NSString*cityId;
@property(nonatomic,strong)NSString*cityName;
@property(nonatomic,strong)NSString*firstChar;
@property(nonatomic,strong)NSString*isPass;

@property(nonatomic,assign)BOOL isSelected;


@end
