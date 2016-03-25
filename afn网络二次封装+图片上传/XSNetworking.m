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
    //stringByAddingPercentEscapesUsingEncoding
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
             // Request the corresponding format
             manager.requestSerializer = [AFJSONRequestSerializer serializer];
             manager.responseSerializer = [AFJSONResponseSerializer serializer];
             // Request type
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

+ (void)XSUploadImageNetworkRequestWithURL:(NSString *)url parameter:(NSDictionary *)parameter image:(UIImage *)image name:(NSString *)name compressionType:(ImageCompressionType)compressionType mimeType:(NSString *)mimeType imageSize:(CGSize)imageSize imageIdentifier:(NSString *)imageIdentifier successResult:(void (^)(id))successBlock failResult:(void (^)(id))failBlock
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
             NSData *imageData;
             // enum pic type
             ImageCompressionType type = compressionType;
             switch (type) {
                 case JPGType:
                    imageData = UIImageJPEGRepresentation([self imageWithImageSimple:image scaledToSize:imageSize], 1.0);
                     break;
                 case PNGType:
                     imageData = UIImagePNGRepresentation([self imageWithImageSimple:image scaledToSize:imageSize]);
                 default:
                     break;
             }
             
             AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
             [manager POST:encodingStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                 // Named for the timestamp
                 NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                 formatter.dateFormat = @"yyyyMMddHHmmss";
                 NSString *str = [formatter stringFromDate:[NSDate date]];
                 // Respectively named after PNG and JPG
                 switch (type) {
                     case PNGType: {
                         NSString *fileName = [NSString stringWithFormat:@"%@%@.png", str,imageIdentifier];
                         [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:mimeType];
                         break;
                     }
                     case JPGType: {
                         NSString *fileName = [NSString stringWithFormat:@"%@%@.jpg", str,imageIdentifier];
                         [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:mimeType];
                         break;
                     }
                 }
                 
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
+ (void)XSUploadManyImagesNetworkRequestWithURL:(NSString *)url parameter:(NSMutableDictionary *)parameter imageSize:(CGSize)imageSize compressionType:(ImageCompressionType)compressionType imageIdentifier:(NSString *)imageIdentifier images:(NSMutableArray *)images successResult:(void (^)(id))successBlock failResult:(void (^)(id))failBlock
{
    NSData *imageData;
    NSMutableArray *arrayImages;
    for (UIImage *image in images) {
        ImageCompressionType type = compressionType;
        switch (type) {
            case PNGType: {
                imageData = UIImagePNGRepresentation([self imageWithImageSimple:image scaledToSize:imageSize]);
                break;
            }
            case JPGType: {
                imageData = UIImageJPEGRepresentation([self imageWithImageSimple:image scaledToSize:imageSize], 1.0);
                break;
            }
        }
        NSString *encodeResult = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        [arrayImages addObject:encodeResult];
    }
    [parameter setValue:[self JSONString:arrayImages] forKey:imageIdentifier];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
    [manager POST:url parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        failBlock(error);
    }];
    
}
// JSON转化为字符串
+ (NSString *)JSONString:(id)src
{
    NSData *d = [NSJSONSerialization dataWithJSONObject:src options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
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
