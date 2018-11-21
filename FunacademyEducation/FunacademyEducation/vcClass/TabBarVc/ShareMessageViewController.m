//
//  ShareMessageViewController.m
//  FunacademyEducation
//
//  Created by 清 on 2018/11/12.
//  Copyright © 2018 清. All rights reserved.
//

#import "ShareMessageViewController.h"
#import "PublicFistTableViewController.h"
#import "DayShareDetailsViewController.h"
#import "PhotoBrowsingViewController.h"
#import <UShareUI/UShareUI.h>


@interface ShareMessageViewController ()<UITableViewDelegate,UITableViewDataSource,ShareMessageTableViewCellDelegate>
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
        NSMutableArray * dataSourceArray = [AnalysisData getHomeDailyShare:dataSource];
        if (self.page == 1) {
            [self.dataArray removeAllObjects];
        }
        [self.dataArray addObjectsFromArray:dataSourceArray];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (dataSourceArray.count < 20) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.tableView reloadData];
    } failureBlock:^(NSURLSessionTask * _Nonnull task, NSString * _Nonnull errorMessage, NSError * _Nullable error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DBShareMessage * model = self.dataArray[indexPath.row];
    return model.cellHeight;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PublicFistTableViewController * tabVc = [self.storyboard instantiateViewControllerWithIdentifier:@"PublicFistTableViewController"];
    ShareMessageTableViewCell * cell = [tabVc.tableView dequeueReusableCellWithIdentifier:@"cell"];
    DBShareMessage * model = self.dataArray[indexPath.row];
    [cell setLayoutData:model withIndePath:indexPath withViewSource:1];
    cell.delegate = self;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DayShareDetailsViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DayShareDetailsViewController"];
    vc.dbModel = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)imageButtonClick:(NSInteger)buttomTag withIndexPath:(NSIndexPath *)indexPath{
    PhotoBrowsingViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PhotoBrowsingViewController"];
    NSMutableArray * array = [[NSMutableArray alloc]init];
    DBShareMessage * dbModel = self.dataArray[indexPath.row];
    for (DBShareMessage * model in dbModel.hasPostResource) {
        [array addObject:model.imageurl];
    }
    vc.imageUrlArray = array;
    vc.selectIndex = buttomTag;
    [self presentViewController:vc animated:NO completion:nil];
}
-(void)bottomViewButtonClick:(NSInteger)buttomTag withIndexPath:(NSIndexPath *)indexPath{
    DBShareMessage * dbModel = self.dataArray[indexPath.row];
    if (buttomTag == 0) {
        //显示分享面板
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            // 根据获取的platformType确定所选平台进行下一步操作
            if (platformType == UMSocialPlatformType_WechatSession || platformType == UMSocialPlatformType_WechatTimeLine) {
                
                 //创建分享消息对象
                 UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
                 //设置文本
                 messageObject.text = dbModel.postContent;
                 //调用分享接口
                 [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                 if (error) {
                 NSLog(@"************Share fail with error %@*********",error);
                 }else{
                 NSLog(@"response data is %@",data);
                 }
                 }];
            }
        }];
    }else if (buttomTag == 1){
        [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
    }else{
        NSMutableDictionary * paramsDic = [[NSMutableDictionary alloc]init];
        [paramsDic setValue:@"1" forKey:@"uid"];
        [paramsDic setValue:@"1" forKey:@"usertype"];
        [paramsDic setValue:@"1" forKey:@"postid"];
        [[NetworkRequestManager manager] POST_URL_HttpHeader:HTTPHEADER_URL url:HOME_UserClickLike params:paramsDic withLoading:NO isFailureAlter:YES successBlock:^(NSURLSessionTask * _Nonnull task, id  _Nonnull dataSource) {
            dbModel.isclicklike = @"1";
            [self.tableView reloadData];
        } failureBlock:^(NSURLSessionTask * _Nonnull task, NSString * _Nonnull errorMessage, NSError * _Nullable error) {
            
        }];
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
