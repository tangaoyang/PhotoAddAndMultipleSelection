//
//  TAYViewController.h
//  相册里添加照片
//
//  Created by cinderella on 2020/2/8.
//  Copyright © 2020 cinderella. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TAYViewController : UIViewController
<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong)UIButton * saveButton;
@property (nonatomic, strong)UIImageView * picImageView;

@end

NS_ASSUME_NONNULL_END
