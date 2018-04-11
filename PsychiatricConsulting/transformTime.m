//
//  transformTime.m
//  PsychiatricConsulting
//
//  Created by apple on 15/9/6.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
// 装换时间，返回时间间隔。。

#import "transformTime.h"

@implementation transformTime
+ (NSString *)prettyDateWithReference:(NSString *)reference {
    NSString *suffix = @"前";
    NSDateFormatter *datef= [[NSDateFormatter alloc]init];
    if (reference.length==19) {
        [datef setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    }else if (reference.length==23){
        [datef setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];

    }else if (reference.length==22){
        [datef setDateFormat:@"yyyy-MM-dd HH:mm:ss.SS"];

    }else if (reference.length==21){
        [datef setDateFormat:@"yyyy-MM-dd HH:mm:ss.S"];

    }else if (reference.length==10){
        [datef setDateFormat:@"yyyy-MM-dd"];

    }



    NSDate *now = [NSDate date];
    NSDate *oldDate= [datef dateFromString:reference];
    float different = [oldDate timeIntervalSinceDate:now];

    if (different < 0) {
        different = -different;
        suffix = @"前";
    }

    // days = different / (24 * 60 * 60), take the floor value
    float dayDifferent = floor(different / 86400);

    int days   = (int)dayDifferent;
    int weeks  = (int)ceil(dayDifferent / 7);
    int months = (int)ceil(dayDifferent / 30);
    int years  = (int)ceil(dayDifferent / 365);

    // It belongs to today
    if (dayDifferent <= 0) {
        // lower than 60 seconds
        if (different < 60) {
            return @"刚刚";
        }

        // lower than 120 seconds => one minute and lower than 60 seconds
        if (different < 120) {
            return [NSString stringWithFormat:@"1分钟%@", suffix];
        }

        // lower than 60 minutes
        if (different < 60 * 60) {
            return [NSString stringWithFormat:@"%d分钟%@", (int)floor(different / 60), suffix];
        }

        // lower than 60 * 2 minutes => one hour and lower than 60 minutes
        if (different < 7200) {
            return [NSString stringWithFormat:@"1小时%@", suffix];
        }

        // lower than one day
        if (different < 86400) {
            return [NSString stringWithFormat:@"%d小时%@", (int)floor(different / 3600), suffix];
        }
    }
    // lower than one week
    else if (days < 7) {
        return [NSString stringWithFormat:@"%d天%@", days,  suffix];
    }
    // lager than one week but lower than a month
    else if (weeks < 4) {
        return [NSString stringWithFormat:@"%d周%@", weeks,  suffix];
    }
    // lager than a month and lower than a year
    else if (months < 12) {
        return [NSString stringWithFormat:@"%d月%@", months, suffix];
    }
    // lager than a year
    else {
        return [NSString stringWithFormat:@"%d年%@", years, suffix];
    }
    
    return self.description;
}

+(NSString *)transformtime:(NSString*)timeString{

    NSDateFormatter *dateFormatter0 = [[NSDateFormatter alloc]init];
    [dateFormatter0 setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSDate *startDat0=[dateFormatter0 dateFromString:timeString];

    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc]init];
    [dateFormatter1 setDateFormat:@"MM.dd"];
    NSString *ssssss= [dateFormatter1 stringFromDate:startDat0];
    return ssssss;
}



//+(NSString*)getLastTime:(NSString*)timeString{
//
//    BOOL timeStart = YES;
//    NSCalendar *cal = [NSCalendar currentCalendar];//定义一个NSCalendar对象
//    NSDateComponents *endTime = [[NSDateComponents alloc] init];    //初始化目标时间...
//    NSDate *today = [NSDate date];    //得到当前时间
//
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
//
//
//    NSDate *dateString = [dateFormatter dateFromString:timeString];
//    NSString *overdate = [dateFormatter stringFromDate:dateString];
//
////    CGFloat different = [dateString timeIntervalSinceDate:today];
////    if (different<0) {
////        return @"活动结束";
////    }
//
//    //    NSLog(@"overdate=%@",overdate);
//    static int year;
//    static int month;
//    static int day;
//    static int hour;
//    static int minute;
//    static int second;
//    if(timeStart) {//从NSDate中取出年月日，时分秒，但是只能取一次
//        year = [[overdate substringWithRange:NSMakeRange(0, 4)] intValue];
//        month = [[overdate substringWithRange:NSMakeRange(5, 2)] intValue];
//        day = [[overdate substringWithRange:NSMakeRange(8, 2)] intValue];
//        hour = [[overdate substringWithRange:NSMakeRange(11, 2)] intValue];
//        minute = [[overdate substringWithRange:NSMakeRange(14, 2)] intValue];
//        second = [[overdate substringWithRange:NSMakeRange(17, 2)] intValue];
//        timeStart= NO;
//    }
//
//    [endTime setYear:year];
//    [endTime setMonth:month];
//    [endTime setDay:day];
//    [endTime setHour:hour];
//    [endTime setMinute:minute];
//    [endTime setSecond:second];
//    NSDate *overTime = [cal dateFromComponents:endTime]; //把目标时间装载入date
//    //用来得到具体的时差，是为了统一成北京时间
//    unsigned int unitFlags = NSYearCalendarUnit| NSMonthCalendarUnit| NSDayCalendarUnit| NSHourCalendarUnit| NSMinuteCalendarUnit| NSSecondCalendarUnit;
//    NSDateComponents *d = [cal components:unitFlags fromDate:today toDate:overTime options:0];
//    NSString *t = [NSString stringWithFormat:@"%d", [d day]];
//    NSString *h = [NSString stringWithFormat:@"%d", [d hour]];
//    NSString *fen = [NSString stringWithFormat:@"%d", [d minute]];
//    if([d minute] < 10) {
//        fen = [NSString stringWithFormat:@"0%d",[d minute]];
//    }
//    NSString *miao = [NSString stringWithFormat:@"%d", [d second]];
//    if([d second] < 10) {
//        miao = [NSString stringWithFormat:@"0%d",[d second]];
//    }
//
//    return    [NSString stringWithFormat:@"还剩：%@天 %@:%@:%@",t,h,fen,miao];
//
//    //        [timeSting setText:[NSString stringWithFormat:@"距离开抢：%@天 %@:%@:%@",t,h,fen,miao]];
//    //        if([d second] > 0) {
//    //            //计时尚未结束，do_something
//    //            //        [_longtime setText:[NSString stringWithFormat:@"%@:%@:%@",d,fen,miao]];
//    //        } else if([d second] == 0) {
//    //            //计时结束 do_something
//    //
//    //        } else{
//    //            //计时器失效
//    //            [theTimer invalidate];
//    //        } 
//
//
//}

@end
