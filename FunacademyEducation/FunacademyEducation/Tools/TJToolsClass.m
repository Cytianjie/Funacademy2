//
//  TJToolsClass.m
//  CJGDShop
//
//  Created by ZQY on 16/11/23.
//  Copyright © 2016年 ZQY. All rights reserved.
//

#import "TJToolsClass.h"

@implementation TJToolsClass
+(UIImage *)getPlaceholderImage{
    return [UIImage imageNamed:@""];
}
+(CGSize)getLableSize:(NSString *)str withFont:(CGFloat)font CgSizemakeWhite:(CGFloat)white{
    
    NSMutableParagraphStyle *paragraphStyle           = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode                      = NSLineBreakByWordWrapping;
    NSDictionary *attributes                          = @{NSFontAttributeName:[UIFont systemFontOfSize:font], NSParagraphStyleAttributeName:paragraphStyle.copy};
    return [str boundingRectWithSize:CGSizeMake(white, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
}
@end
