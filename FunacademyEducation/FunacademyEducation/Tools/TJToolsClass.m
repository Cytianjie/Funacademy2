//
//  TJToolsClass.m
//  CJGDShop
//
//  Created by ZQY on 16/11/23.
//  Copyright © 2016年 ZQY. All rights reserved.
//

#import "TJToolsClass.h"

@implementation TJToolsClass
//返回默认图片
+(UIImage *)getPlaceholderImage{
    return [UIImage imageNamed:@""];
}
//返回一段文字的size
+(CGSize)getTextSize:(NSString *)string withFont:(CGFloat)font withWidth:(CGFloat)width{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:font], NSParagraphStyleAttributeName:paragraphStyle.copy};
    return [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;    
}
@end
