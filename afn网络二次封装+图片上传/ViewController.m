//
//  ViewController.m
//  afn网络二次封装+图片上传
//
//  Created by zjwang on 16/3/25.
//  Copyright © 2016年 Xsummerybc. All rights reserved.
//

#import "ViewController.h"
#import "XTNetworking.h"
//#import <JSONKit.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 一般的网络请求
    NSString *url = @"http://60.18.250.166:8066/youme/service1.asmx/GetUserCashTradeDetail2Apple?U_ID=A00000119";
//    NSString *url = @"http://60.18.250.166:8066/youme/service1.asmx/ItemsTradeALL2Apple?";
    [XTNetworking XSNetworkRequestWithURL:url parameter:nil methods:GETMethodsType successResult:^(id result) {
//        NSAssert([result isKindOfClass:[NSArray class]], @"allData is not an array");
        
        NSLog(@"%@", result);
    } failResult:^(id error) {
        
        NSLog(@"error  === %@", error);
    }];
    
    // 这里接口就不提供了
    // 上传图片
//    XSNetworking XSUploadImageNetworkRequestWithURL:<#(NSString *)#> parameter:<#(NSDictionary *)#> images:<#(NSMutableArray *)#> name:<#(NSString *)#> compressionType:<#(ImageCompressionType)#> mimeType:<#(NSString *)#> imageSize:<#(CGSize)#> imageIdentifier:<#(NSString *)#> successResult:<#^(id)successBlock#> failResult:<#^(id)failBlock#>
    
//    NSURL * URL = [NSURL URLWithString:url];
//    NSURLRequest * request = [NSURLRequest requestWithURL:URL];
//    NSURLSession * session = [NSURLSession sharedSession];
//    NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//        NSString * str2 = [str stringByReplacingOccurrencesOfString:@"\t" withString:@""];
//        str2 = [str2 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//        str2 = [str2 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
////        str2 = [str2 stringByReplacingOccurrencesOfString:@"\" withString:@""];
//        
//        NSLog(@"data ====== %@", [str2 JSONString]);
//        NSData *jsonData = [[str2 JSONString] dataUsingEncoding:NSUTF8StringEncoding];
//        NSArray *arr = (NSArray *)[jsonData mutableObjectFromJSONData];
//        NSLog(@"count=%d",arr.count);
//    }];
//        
//    [dataTask resume];
//    
//    UIStackView *stack = [[UIStackView alloc] init];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
