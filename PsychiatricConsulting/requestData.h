//
//  requestData.h
//  ShengMengShangmao
//
//  Created by apple on 15-3-30.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^block)(NSError* error,NSDictionary* resultDict);

@interface requestData : NSObject

+(void)PostData:(NSString*)urlString Parameters:(NSDictionary*)parameter Completion:(block)completion;

+ (void)getData:(NSString*)urlString complete:(void(^)(NSDictionary*dic))block;
+ (BOOL) validateEmail:(NSString *)email;
+ (BOOL) validateMobile:(NSString *)mobile;
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
+ (BOOL) validateBusinessId:(NSString *)businessId;
+ (void)cancelLonIn;

+(NSString *)GetBrithdayFromIdCard:(NSString*) IdCard;


+(NSString *)compareDate:(NSDate *)date;


+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;
@end
