//
//  TJToolsClass.h
//  CJGDShop
//
//  Created by ZQY on 16/11/23.
//  Copyright © 2016年 ZQY. All rights reserved.
//
/**
 工具类
 */
#import <Foundation/Foundation.h>
@interface TJToolsClass : NSObject

/**
 <#Description#>

 @return 返回默认图片
 */
+(UIImage *)getPlaceholderImage;

/**
 <#Description#>

 @param string <#str description#>
 @param font <#font description#>
 @param width <#white description#>
 @return 返回一段文字的size
 */
+(CGSize)getTextSize:(NSString *)string withFont:(UIFont *)font withWidth:(CGFloat)width;
@end
