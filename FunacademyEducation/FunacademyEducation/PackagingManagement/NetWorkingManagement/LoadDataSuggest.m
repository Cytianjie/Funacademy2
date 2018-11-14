//
//  LoadDataSuggest.m
//  test
//
//  Created by ZQY on 16/6/24.
//  Copyright © 2016年 ZQY. All rights reserved.
//

#import "LoadDataSuggest.h"

@implementation LoadDataSuggest
static LoadDataSuggest *loadDataSuggest = nil;
#define loadHight 50
#define loadRisingHight 150
+(LoadDataSuggest *)shareLoadDataSuggest{
    
    if (loadDataSuggest == nil) {
        CGFloat scWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat scHeight = [UIScreen mainScreen].bounds.size.height;
        loadDataSuggest = [[LoadDataSuggest alloc] initWithFrame:CGRectMake(scWidth/3, scHeight, scWidth/3, loadHight)];
        loadDataSuggest.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        loadDataSuggest.layer.masksToBounds = YES;
        loadDataSuggest.layer.cornerRadius = 8;
        loadDataSuggest.textColor = [UIColor whiteColor];
        loadDataSuggest.textAlignment = NSTextAlignmentCenter;
        AppDelegate * app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [app.window addSubview:loadDataSuggest];
        
    }
    return loadDataSuggest;
    
}

+(void)showFailWith:(NSString *)text{

    LoadDataSuggest * suggest = [LoadDataSuggest shareLoadDataSuggest];
    
    suggest.text = text;
    
    
    
    [UIView animateWithDuration:0.1 animations:^{
        suggest.frame =   CGRectMake(suggest.frame.origin.x, [UIScreen mainScreen].bounds.size.height-loadRisingHight, suggest.frame.size.width, suggest.frame.size.height);
    } completion:^(BOOL finished) {
        
        
        
        
        
        
        [UIView animateWithDuration:0.1 animations:^{
            suggest.frame =   CGRectMake(suggest.frame.origin.x, [UIScreen mainScreen].bounds.size.height - loadRisingHight - 10, suggest.frame.size.width, suggest.frame.size.height);
        } completion:^(BOOL finished) {
            
            
            
            
            
            
            [UIView animateWithDuration:0.1 animations:^{
                suggest.frame =   CGRectMake(suggest.frame.origin.x, [UIScreen mainScreen].bounds.size.height-loadRisingHight, suggest.frame.size.width, suggest.frame.size.height);
            } completion:^(BOOL finished) {
                
                
                
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC));
                
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    
                    suggest.frame = CGRectMake(suggest.frame.origin.x, [UIScreen mainScreen].bounds.size.height, suggest.frame.size.width, suggest.frame.size.height);
                    
                });
                
            }];
            
            
            
            
            
            
        }];
        
        
        
        
        
        
        
        
    }];

    
    
    
    


}
@end
