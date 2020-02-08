//
//  TAYViewController.m
//  相册里添加照片
//
//  Created by cinderella on 2020/2/8.
//  Copyright © 2020 cinderella. All rights reserved.
//

#import "TAYViewController.h"

@interface TAYViewController ()

@end

@implementation TAYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:_picImageView];
    _saveButton = [[UIButton alloc] init];
    [self.view addSubview:_saveButton];
    _saveButton.frame = CGRectMake(100, 300, 100, 100) ;
    [_saveButton addTarget: self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    _saveButton.backgroundColor = [UIColor redColor];
    
}

-(void)openCamera {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.sourceType =
    UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    [self presentViewController:picker animated:NO completion:nil];
}

-(void)openAlbum {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.sourceType =
    UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:NO completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [picker dismissViewControllerAnimated:NO completion:nil];
    self.picImageView.image = info[UIImagePickerControllerOriginalImage];
}

-(void)show {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"选择方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openCamera];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openAlbum];
    }]];
    [self presentViewController:alert animated:NO completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
