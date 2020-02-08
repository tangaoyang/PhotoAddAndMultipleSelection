//
//  ViewController.m
//  相册里添加照片
//
//  Created by cinderella on 2020/2/8.
//  Copyright © 2020 cinderella. All rights reserved.
//

#import "ViewController.h"
#import "TAYViewController.h"
#import "HHHViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.picImageView = [[UIImageView alloc] init];
    [_picImageView setImage:[UIImage imageNamed:@"123.jpg"]];
    [self save];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    TAYViewController *tay = [[TAYViewController alloc] init];
    [self presentViewController:tay animated:NO completion:nil];
}


- (PHAssetCollection *)createdCollection {
    //获得APP名称 CFBundleName
    NSString * title = [NSBundle mainBundle].infoDictionary[@"CFBundleName"];
    //抓取所有自定义相册
    PHFetchResult<PHAssetCollection*>*collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    //查找当前的app的自定义相册
    for (PHAssetCollection * collection in collections) {
        if([collection.localizedTitle isEqualToString:title])
        {
            return collection;
        }
    }
    //当前对象没有被创建过
    NSError * error = nil;
    __block  NSString *    creatCollectionID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary]performChangesAndWait:^{
        //创建一个自定义字典
        creatCollectionID =[PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
        
    } error:&error];
    if(error){
        NSLog(@"error == %@", error);
        NSLog(@"创建相册失败");
        return nil;
    }
    else {
        NSLog(@"创建相册成功");
    }
    
    //根据唯一标识创建相册
    return  [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[creatCollectionID] options:nil].firstObject;
}

-(void)save {
    
    //保存函数到相机胶卷
    // 同步
    __block PHObjectPlaceholder * placeholder = nil;
    NSError * error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary]performChangesAndWait:^{
        placeholder = [PHAssetChangeRequest creationRequestForAssetFromImage:self->_picImageView.image].placeholderForCreatedAsset;
    } error:&error];
    if (error) {
        NSLog(@"保存失败");
    }else{
        NSLog(@"保存成功");
    }
    //获得相册
    PHAssetCollection * createdCollection = self.createdCollection;
    //添加图片到指定相册
//    PHAsset : 一个PHAsset对象就代表相册中的一张图片或者一个视频
//    PHAssetCollection : 一个PHAssetCollection 对象就代表一个相册
//    凡是涉及增删改的操作，均需要放在performChanges里面执行。
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest * request =  [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdCollection];
        [request insertAssets:@[placeholder] atIndexes:[NSIndexSet indexSetWithIndex:0]];
        
    } error:&error];
}


@end
