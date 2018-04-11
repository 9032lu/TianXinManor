//
//  danli.m
//  PsychiatricConsulting
//
//  Created by apple on 15/6/4.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "danli.h"

@implementation danli
+(danli*)shareClient
{
    static danli*_myapp=nil;
    static dispatch_once_t onceTocken;
    dispatch_once(&onceTocken, ^{
        _myapp=[[danli alloc]init];
    });
    return _myapp;

}
@end
