//
//  ViewController.m
//  afn网络二次封装+图片上传
//
//  Created by zjwang on 16/3/25.
//  Copyright © 2016年 Xsummerybc. All rights reserved.
//

#import "ViewController.h"
#import "XSNetworking.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 一般的网路请求
    NSString *url = @"http://api.app.happyjuzi.com/v2.4/article/list/home?&page=1";
    [XSNetworking XSNetworkRequestWithURL:url parameter:nil methods:GETMethodsType successResult:^(id result) {
        NSLog(@"result === %@", result);
    } failResult:^(id error) {
        NSLog(@"error  === %@", error);
    }];
    // 这里接口就不提供了
    // 上传图片
//    [XSNetworking XSUploadImageNetworkRequestWithURL:@"" parameter:nil image:image name:@"icon" mimeType:@"image/jpeg" imageSize:CGSizeMake(55, 55) imageIdentifier:@"146456154" successResult:^(id result) {
//        //
//    } failResult:^(id error) {
//        //
//    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
