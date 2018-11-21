//
//  MyAlerView.m
//  FunacademyEducation
//
//  Created by 清 on 2018/11/14.
//  Copyright © 2018 清. All rights reserved.
//

#import "MyAlerView.h"
#import "AppDelegate.h"

@implementation MyAlerView

+(void)alterMessage:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:NSLocalizedString(@"alterCancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:action];
    [[AppDelegate getAppDelegate].window.rootViewController presentViewController:alert animated:YES completion:nil];
}
@end
