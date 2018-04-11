//
//  Modle.h
//  PsychiatricConsulting
//
//  Created by apple on 15/9/1.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <Foundation/Foundation.h>
//社区大的分类
@interface Modle : NSObject
@property(nonatomic,copy)NSString *typeName;
@property(nonatomic,copy)NSURL *typeBackground;
@property(nonatomic,copy)NSURL *smallIcon;
@property(nonatomic,copy)NSString *typeOrder;
@property(nonatomic,copy)NSString *interactiveId;
@property(nonatomic,copy)NSString *Remarks;


//社区话题
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *topicsTitle;
@property(nonatomic,copy)NSString *topicsContent;
@property(nonatomic,strong)NSArray *topocImageList;
@property(nonatomic,copy)NSString *rowNumber;
@property(nonatomic,copy)NSString *praiseCount;
@property(nonatomic,copy)NSString *nickName;
@property(nonatomic,assign)NSString *isTop;
@property(nonatomic,copy)NSString *commentCount;
@property(nonatomic,copy)NSString *topicsDate;
@property(nonatomic,copy)NSString *topicsId;

//评论区
@property(nonatomic,copy)NSString *face;
@property(nonatomic,copy)NSString *replayContent;
@property(nonatomic,copy)NSString *commentDate;
@property(nonatomic,copy)NSString *replayDate;
@property(nonatomic,copy)NSString *commentContent;
@property(nonatomic,copy)NSString *topicCommentId;
@property(nonatomic,copy)NSString *exp;



//时光轴，产品
@property(nonatomic,copy)NSString *categoryName;
@property(nonatomic,copy)NSString *ldescription;
@property(nonatomic,copy)NSString *categoryId;





@end
