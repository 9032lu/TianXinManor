//
//  requestData.m
//  ShengMengShangmao
//
//  Created by apple on 15-3-30.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "requestData.h"

@implementation requestData

+(void)PostData:(NSString*)urlString Parameters:(NSDictionary*)parameter Completion:(block)completion{
    AFHTTPRequestOperationManager*manger=[AFHTTPRequestOperationManager manager];
    manger.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];

    [manger POST:urlString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion) {
            NSLog(@"responseObject===%@",responseObject);
            completion(nil,(NSDictionary *)responseObject);

        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        completion(error,nil);
        
        
    }];
    
    
}



+(void)getData:(NSString*)urlString complete:(void(^)(NSDictionary*dic))block;
{
    NSURL*url=[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

    NSURLRequest*request=[NSURLRequest requestWithURL:url];

    AFHTTPRequestOperation*operation=[[AFHTTPRequestOperation alloc]initWithRequest:request];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary*dic=[NSJSONSerialization JSONObjectWithData:[operation.responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];

        block(dic);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        NSDictionary*dic=@{};
        block(dic);
        ALERT(@"网络繁忙，请稍后再试")

    }];

    NSOperationQueue*queue=[[NSOperationQueue alloc]init];
    [queue addOperation:operation];


}
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL) validateMobile:(NSString *)mobile
{

    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{17})(\\d|[xX])$";

    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
+ (BOOL) validateBusinessId:(NSString *)businessId
{

    NSString *businessIdRegex = @"^(\\d{15})";
    NSPredicate *businessIdTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",businessIdRegex];
    return [businessIdTest evaluateWithObject:businessId];
}
+(void)cancelLonIn
{
    NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
    NSLog(@"注销");
    [defaults removeObjectForKey:@"userId"];

}


+(NSString *)GetBrithdayFromIdCard:(NSString*)IdCard{
    NSMutableString *string;
    NSString *IDstr;
    if (IdCard.length == 15)
    {
       IDstr = [IdCard substringWithRange:NSMakeRange(6,6)];
        string = [NSMutableString stringWithString:IDstr];
        [string insertString:@"19" atIndex:0];
        [string insertString:@"-" atIndex:4];
        [string insertString:@"-" atIndex:7];


    }
    else if (IdCard.length == 18)
    {
        IDstr = [IdCard substringWithRange:NSMakeRange(6,8)];
        string = [NSMutableString stringWithString:IDstr];
        [string insertString:@"-" atIndex:4];
        [string insertString:@"-" atIndex:7];



    }
    return string;

}
+(NSString *)compareDate:(NSDate *)date{

    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *tomorrow, *yesterday;

    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];

    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * tomorrowString = [[tomorrow description] substringToIndex:10];

    NSString * dateString = [[date description] substringToIndex:10];

    if ([dateString isEqualToString:todayString])
    {
        return @"今天";
    } else if ([dateString isEqualToString:yesterdayString])
    {
        return @"昨天";
    }else if ([dateString isEqualToString:tomorrowString])
    {
        return @"明天";
    }
    else
    {
        return dateString;
    }
}



+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {

    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];

    [calendar setTimeZone: timeZone];

    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;

    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];

    return [weekdays objectAtIndex:theComponents.weekday];
    
}
@end
