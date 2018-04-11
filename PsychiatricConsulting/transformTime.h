//
//  transformTime.h
//  PsychiatricConsulting
//
//  Created by apple on 15/9/6.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface transformTime : NSObject
+(NSString *)prettyDateWithReference:(NSString *)reference ;
+(NSString *)transformtime:(NSString*)timeString;
//+(NSString*)getLastTime:(NSString*)timeString;

@end
