//
//  ShareMessageViewController.m
//  FunacademyEducation
//
//  Created by 清 on 2018/11/12.
//  Copyright © 2018 清. All rights reserved.
//

#import "ShareMessageViewController.h"
#import "PublicFistTableViewController.h"


@interface ShareMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,assign)NSInteger page;
@end

@implementation ShareMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"tab1NavTitle", nil);
    [self setDataConfiguration];
    [self getNetWorkData];
    
}
-(void)setDataConfiguration{
    self.dataArray = [[NSMutableArray alloc]init];
    self.page = 1;
    //http://v.juhe.cn/toutiao/index?type=&key=b8421e57e460addf33510c67277d45e6
    self.tableView.mj_header = [FAMJMJRefreshManagement faHeaderWithRefreshingBlock:^{
        [self pullRefreshData];
    }];
    self.tableView.mj_footer = [FAMJMJRefreshManagement faFooterWithRefreshingBlock:^{
        [self loadingMoreData];
    }];
}
-(void)pullRefreshData{
    self.page = 1;
    [self.tableView.mj_footer resetNoMoreData];
    [self getNetWorkData];
    
}
-(void)loadingMoreData{
    self.page++;
    [self getNetWorkData];
}
-(void)getNetWorkData{
    NSMutableDictionary * paramsDic = [[NSMutableDictionary alloc]init];
    [paramsDic setValue:[NSString stringWithFormat:@"%ld",(long)self.page] forKey:@"page"];
    [paramsDic setValue:@"1" forKey:@"uid"];
    [paramsDic setValue:@"1" forKey:@"classid"];
    [[NetworkRequestManager manager] POST_URL_HttpHeader:HTTPHEADER_URL url:HOME_DailyShare params:paramsDic withLoading:YES isFailureAlter:YES successBlock:^(NSURLSessionTask * _Nonnull task, id  _Nonnull dataSource) {
        NSLog(@"%@",dataSource);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failureBlock:^(NSURLSessionTask * _Nonnull task, NSString * _Nonnull errorMessage, NSError * _Nullable error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 650;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PublicFistTableViewController * tabVc = [self.storyboard instantiateViewControllerWithIdentifier:@"PublicFistTableViewController"];
    ShareMessageTableViewCell * cell = [tabVc.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
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
