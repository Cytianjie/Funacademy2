//
//  ShareMessageViewController.m
//  FunacademyEducation
//
//  Created by 清 on 2018/11/12.
//  Copyright © 2018 清. All rights reserved.
//

#import "ShareMessageViewController.h"
#import "ShareMessageTableViewCell.h"


@interface ShareMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation ShareMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"tab1NavTitle", nil);
    [self setDataConfiguration];
    
}
-(void)setDataConfiguration{
    //http://v.juhe.cn/toutiao/index?type=&key=b8421e57e460addf33510c67277d45e6
//    [[NetworkRequestManager manager] GET_URL:@"http://v.juhe.cn/toutiao/index?type=&key=b8421e57e460addf33510c67277d45e6" withLoading:YES Success:^(NSURLSessionTask * _Nonnull task, id  _Nonnull dataSource, id  _Nullable loadingview) {
//         
//    } Failure:^(NSURLSessionTask * _Nonnull task, NSError * _Nonnull error) {
//        
//    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 650;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShareMessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    return cell;
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
