//
//  XSNetworking.h
//  NewStart
//
//  Created by zjwang on 16/3/25.
//  Copyright © 2016年 Xsummerybc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MethodsType) {
    POSTMethodsType     = 0,
    GETMethodsType      = 1,
};

typedef NS_ENUM(NSInteger, ImageCompressionType) {
    PNGType     = 0,
    JPGType     = 1,
};

@interface XSNetworking : NSObject
/**
 *  网络请求
 *
 *  @param url          url
 *  @param parameter    Body体
 *  @param methods      POST / GET
 *  @param SuccessBlock 成功回调的结果
 *  @param failBlock    失败回调的结果
 */
+ (void)XSNetworkRequestWithURL:(NSString *)url
                      parameter:(NSDictionary *)parameter
                        methods:(MethodsType)methods
                  successResult:(void (^)(id result))successBlock
                     failResult:(void (^)(id error))failBlock;

/**
 *  以文件流形式上传图片
 *
 *  @param url              后台提供的url
 *  @param parameter        body
 *  @param imageData        图片(NSData)
 *  @param name             后台提供的字段
 *  @param mimeType         图片的类型
 *  @param compressionType  图片压缩类型
 *  @param imageSize        图片的size
 *  @param imageIdentifier  图片的唯一标识(例如是头像: 可以传一个用户ID)
 *  @param failBlock        失败的回调
 @  @param successBlock     成功的回调
 */
+ (void)XSUploadImageNetworkRequestWithURL:(NSString *)url
                      parameter:(NSDictionary *)parameter
                          image:(UIImage *)image
                           name:(NSString *)name
                compressionType:(ImageCompressionType)compressionType
                       mimeType:(NSString  *)mimeType
                      imageSize:(CGSize)imageSize
                imageIdentifier:(NSString *)imageIdentifier
                  successResult:(void (^)(id result))successBlock
                     failResult:(void (^)(id error))failBlock;
/**
 *  多张图片上传
 *
 *  @param url       url
 *  @param parameter dic(body)
 *  @param imageSize 图片的尺寸
 *  @param images    图片数组
 *  @param compressionType png / jpg
 *  @param imageIdentifier 后台给的标识
 */
+ (void)XSUploadManyImagesNetworkRequestWithURL:(NSString *)url
                                      parameter:(NSMutableDictionary *)parameter
                                      imageSize:(CGSize)imageSize
                                compressionType:(ImageCompressionType)compressionType
                                      imageIdentifier:(NSString *)imageIdentifier
                                         images:(NSMutableArray *)images
                                  successResult:(void (^)(id result))successBlock
                                     failResult:(void (^)(id error))failBlock;
@end
