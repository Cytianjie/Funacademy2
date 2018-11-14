//
//  MainTabBarViewController.m
//  FunacademyEducation
//
//  Created by 清 on 2018/11/12.
//  Copyright © 2018 清. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "ShareMessageViewController.h"
#import "MessageViewController.h"
#import "ContactViewController.h"
#import "MyViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTabBarItemTile];
}
-(void)setTabBarItemTile{
    for (UINavigationController * vc in self.viewControllers) {
        if ([vc.topViewController isKindOfClass:[ShareMessageViewController class]]) {
           vc.topViewController.title = NSLocalizedString(@"tab1Title", nil);
        }else if ([vc.topViewController isKindOfClass:[MessageViewController class]]) {
            vc.topViewController.title = NSLocalizedString(@"tab2Title", nil);
        }else if ([vc.topViewController isKindOfClass:[ContactViewController class]]) {
            vc.topViewController.title = NSLocalizedString(@"tab3Title", nil);
        }else if ([vc.topViewController isKindOfClass:[MyViewController class]]) {
            vc.topViewController.title = NSLocalizedString(@"tab4Title", nil);
        }
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
