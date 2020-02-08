//
//  ViewController.h
//  相册里添加照片
//
//  Created by cinderella on 2020/2/8.
//  Copyright © 2020 cinderella. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) UIImageView *picImageView;

-(PHAssetCollection*)createdCollection;

@end

