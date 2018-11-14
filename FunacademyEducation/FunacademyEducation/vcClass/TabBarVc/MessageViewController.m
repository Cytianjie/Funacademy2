//
//  MessageViewController.m
//  FunacademyEducation
//
//  Created by 清 on 2018/11/12.
//  Copyright © 2018 清. All rights reserved.
//

#import "MessageViewController.h"
#import "EaseMessageViewController.h"
#import "EaseConversationListViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"tab2NavTitle", nil);
    
    [[EMClient sharedClient] loginWithUsername:@"8002"
                                      password:@"123456"
                                    completion:^(NSString *aUsername, EMError *aError) {
                                        if (!aError) {
                                            NSLog(@"登录成功");
                                            EaseConversationListViewController * vc = [[EaseConversationListViewController alloc]init];
                                            [self addChildViewController:vc];
                                            [self.view addSubview:vc.view];
                                        } else {
                                            NSLog(@"登录失败");
                                        }
                                    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)action:(id)sender {
//    EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:@"8001" conversationType:EMConversationTypeChat];
//    chatController.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:chatController animated:YES];
    
    
}

@end
