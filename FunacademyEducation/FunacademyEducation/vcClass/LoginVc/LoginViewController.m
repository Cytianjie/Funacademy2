//
//  LoginViewController.m
//  FunacademyEducation
//
//  Created by 清 on 2018/11/13.
//  Copyright © 2018 清. All rights reserved.
//

#import "LoginViewController.h"
#import "MainTabBarViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.logInButton.backgroundColor = [UIColor grayColor];
    self.logInButton.userInteractionEnabled = NO;
    [self.phoneTextField addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    
}
-(void)textField1TextChange:(UITextField *)textField{
    if (textField.text.length == 11) {
        self.logInButton.backgroundColor = [UIColor blueColor];
        self.logInButton.userInteractionEnabled = YES;
       
    }else{
        self.logInButton.backgroundColor = [UIColor grayColor];
        self.logInButton.userInteractionEnabled = NO;
        
    }
    
}
- (IBAction)logInAction:(id)sender {
    if (self.codeTextField.text.length <= 0) {
        [self presentViewController:[MyAlerView message:@"密码不能为空"] animated:YES completion:nil];
        return;
    }else{
       
        MainTabBarViewController * tabVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTabBarViewController"];
        [self presentViewController:tabVC animated:NO completion:nil];
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
