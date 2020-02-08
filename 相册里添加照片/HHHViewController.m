//
//  HHHViewController.m
//  相册里添加照片
//
//  Created by cinderella on 2020/2/8.
//  Copyright © 2020 cinderella. All rights reserved.
//

#import "HHHViewController.h"
#import <CTAssetsPickerController.h>

@interface HHHViewController ()
<CTAssetsPickerControllerDelegate>

@end

@implementation HHHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _saveButton = [[UIButton alloc] init];
    [self.view addSubview:_saveButton];
    _saveButton.frame = CGRectMake(100, 300, 100, 100) ;
    //  [_saveButton addTarget: self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    _saveButton.backgroundColor = [UIColor redColor];
    [_saveButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}

-(void)click {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            CTAssetsPickerController * picker =
            [[CTAssetsPickerController alloc]init];
            picker.delegate = self;
            //是否展示空相册
            picker.showsEmptyAlbums = NO;
            //显示图片索引
            picker.showsSelectionIndex = YES;
            
            //选择需要的相册
            // PHAssetCollectionSubtypeAlbumRegular 系统自带相册
            // PHAssetCollectionSubtypeSmartAlbumUserLibrary app相册
            picker.assetCollectionSubtypes =@[@(PHAssetCollectionSubtypeAlbumRegular),@(PHAssetCollectionSubtypeSmartAlbumUserLibrary)];
            
            //
            [self presentViewController:picker animated:NO completion:nil];
        });
    }];
}

- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    //关闭图片选择界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    //选择图片时的配置
    PHImageRequestOptions * options = [[PHImageRequestOptions alloc] init];
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    options.deliveryMode  = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    //显示图片
    for (NSInteger i = 0; i <assets.count ; i++) {
        PHAsset * asset =assets[i];
        CGSize size = CGSizeMake(asset.pixelWidth, asset.pixelHeight);
        // 请求图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            //添加图片
            UIImageView * imageView = [[UIImageView alloc] init];
            imageView.image = result;
            [self.view addSubview:imageView];
            imageView.frame = CGRectMake((i%3)*(120+10), (i/3)*(120+10), 120, 120);
        }];
    }
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(PHAsset *)asset {
    NSInteger max = 9;
    
    // show alert gracefully
    if (picker.selectedAssets.count >= max) {
        UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:@"Attention"
                                            message:[NSString stringWithFormat:@"Please select not more than %ld assets", (long)max]
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action =
        [UIAlertAction actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                               handler:nil];
        
        [alert addAction:action];
        
        [picker presentViewController:alert animated:YES completion:nil];
    }
    
    // limit selection to max
    return (picker.selectedAssets.count < max);
    
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
