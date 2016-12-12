//
//  XSNetworking.h
//  NewStart
//
//  Created by zjwang on 16/3/25.
//  Copyright © 2016年 夏天. All rights reserved.
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

@interface XTNetworking : NSObject
/**
 *  网络请求
 *
 *  @param url          url
 *  @param parameter    Body体
 *  @param methods      POST / GET
 *  @param SuccessBlock 成功回调的结果
 *  @param failBlock    失败回调的结果
 */
+ (void)XTNetworkRequestWithURL:(NSString *)url
                      parameter:(NSDictionary *)parameter
                        methods:(MethodsType)methods
                  successResult:(void (^)(id result))successBlock
                     failResult:(void (^)(id error))failBlock;
/****************************************************************************/
        /*************具体图片上传的方法还是要看后台怎么给说明**************/
/****************************************************************************/
/**
 *  以文件流形式上传图片
 *
 *  @param url              后台提供的url
 *  @param parameter        body
 *  @param images           图片数组
 *  @param name             后台提供的字段
 *  @param mimeType         图片的类型
 *  @param compressionType  图片压缩类型
 *  @param imageSize        图片的size
 *  @param imageIdentifier  图片的唯一标识(例如是头像: 可以传一个用户ID)
 *  @param failBlock        失败的回调
 @  @param successBlock     成功的回调
 */
+ (void)XTUploadImageNetworkRequestWithURL:(NSString *)url
                                 parameter:(NSDictionary *)parameter
                                    images:(NSMutableArray *)images
                                      name:(NSString *)name
                           compressionType:(ImageCompressionType)compressionType
                                  mimeType:(NSString *)mimeType
                                 imageSize:(CGSize)imageSize
                           imageIdentifier:(NSString *)imageIdentifier
                             successResult:(void (^)(id result))successBlock
                                failResult:(void (^)(id error))failBlock;

@end
