//
//  setUserInfoVC.h
//  logRegister
//
//  Created by apple on 15-1-26.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface setUserInfoVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate,UIScrollViewDelegate>
{
    CGFloat         _width;
    CGFloat         _height;

    UITableView     *_tableView;
    NSString        *_userFace;
    NSString        *_userNickName;

    UITextField     *_nickName_tf;
    UITextField     *_email_tf;
    UILabel     *_sex_tf;
    UILabel     *_identityCard_tf;
    UILabel     *_birthDay_tf;
    UILabel     *_maritalStatus_tf;

    NSDictionary *marDic;
    NSDictionary *sexDic;
    NSDictionary *fanmarDic;
    NSDictionary *fansexDic;

    NSString *idString;
    NSString        *_imageDataStr;
    UIImage         *_image;
    NSDictionary    *_dataDic;
}
@property(nonatomic,copy)NSString*whoPush;
@end
