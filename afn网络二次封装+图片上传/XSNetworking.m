//
//  XSNetworking.m
//  NewStart
//
//  Created by zjwang on 16/3/25.
//  Copyright © 2016年 Xsummerybc. All rights reserved.
//

#import "XSNetworking.h"
#import <AFNetworking.h>
#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>
@interface XSNetworking ()

@property (nonatomic,  assign) NSInteger networkStatus;

@end

@implementation XSNetworking
+ (void)XSNetworkRequestWithURL:(NSString *)url parameter:(NSDictionary *)parameter methods:(MethodsType)methods successResult:(void (^)(id))successBlock failResult:(void (^)(id))failBlock
{
    NSString *encodingStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         if (status == 0)
         {
             [self showHint:@"无网络连接"];
         }
         else
         {
             AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
             // 设置请求格式
             manager.requestSerializer = [AFJSONRequestSerializer serializer];
             manager.responseSerializer = [AFJSONResponseSerializer serializer];
             // 请求相应格式
             [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain",@"application/x-javascript", nil]];
             MethodsType type = methods;
             switch (type) {
                     // POST
                 case POSTMethodsType: {
                     {
                         [manager POST:encodingStr parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                             successBlock(responseObject);
                         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                             failBlock(error);
                         }];
                     }
                     break;
                 }
                     // GET
                 case GETMethodsType: {
                     {
                         [manager GET:encodingStr parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                             successBlock(responseObject);
                         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                             failBlock(error);
                         }];
                     }
                     break;
                 }
             }
         }
     }];
}

+ (void)XSUploadImageNetworkRequestWithURL:(NSString *)url parameter:(NSDictionary *)parameter image:(UIImage *)image name:(NSString *)name mimeType:(NSString *)mimeType imageSize:(CGSize)imageSize imageIdentifier:(NSString *)imageIdentifier successResult:(void (^)(id))successBlock failResult:(void (^)(id))failBlock
{
    NSString *encodingStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         if (status == 0)
         {
             [self showHint:@"无网络连接"];
         }
         else
         {
             // 压缩
             NSData *imageData = UIImageJPEGRepresentation([self imageWithImageSimple:image scaledToSize:imageSize], 1.0);
             
             AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
             [manager POST:encodingStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                 // 以时间戳为命名
                 NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                 formatter.dateFormat = @"yyyyMMddHHmmss";
                 NSString *str = [formatter stringFromDate:[NSDate date]];
                 NSString *fileName = [NSString stringWithFormat:@"%@%@.jpg", str,imageIdentifier];
                 [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:mimeType];
                 
             } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 //
                 successBlock(responseObject);
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 //
                 failBlock(error);
             }];
         }
     }];
}
/**
 *  提示信息
 *
 *  @param hint "提示内容"
 */
+ (void)showHint:(NSString *)hint
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *xsHud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    xsHud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    xsHud.mode = MBProgressHUDModeText;
    xsHud.labelText = hint;
    xsHud.margin = 10.f;
    xsHud.yOffset = 200.f;
    xsHud.removeFromSuperViewOnHide = YES;
    [xsHud hide:YES afterDelay:2];
}

/**
 *  图片压缩
 */
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

@end
