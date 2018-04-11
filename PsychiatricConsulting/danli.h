//
//  danli.h
//  PsychiatricConsulting
//
//  Created by apple on 15/6/4.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface danli : NSObject
+(danli*)shareClient;
@property(nonatomic,assign)BOOL isremember;
@property(nonatomic,assign)BOOL cityIsChange;
@property(nonatomic,assign)BOOL isread;


@property(nonatomic,copy)NSString   *loca_city;
@property(nonatomic,copy)NSString   *log;
@property(nonatomic,copy)NSString   *lat;
@end
