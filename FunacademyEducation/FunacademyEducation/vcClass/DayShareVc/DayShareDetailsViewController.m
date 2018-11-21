//
//  DayShareDetailsViewController.m
//  FunacademyEducation
//
//  Created by 清 on 2018/11/19.
//  Copyright © 2018 清. All rights reserved.
//

#import "DayShareDetailsViewController.h"
#import "PublicFistTableViewController.h"
#import "CommentsKeyWordView.h"
#import "ExpressionKeyWordView.h"

@interface DayShareDetailsViewController ()<UITableViewDelegate,UITableViewDataSource,CommentsKeyWordViewDelegate,ExpressionKeyWordViewDelegate>
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)CommentsKeyWordView * keyBoardView;
@property(nonatomic,strong)ExpressionKeyWordView * expressionView;
@end

@implementation DayShareDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"postDetails", nil);
    [self setDataConfiguration];
    [self getNetWorkData];
}
-(void)setDataConfiguration{
    self.dataArray = [[NSMutableArray alloc]init];
    self.page = 1;
//    self.tableView.mj_footer = [FAMJMJRefreshManagement faFooterWithRefreshingBlock:^{
//        [self loadingMoreData];
//    }];
    
    //设置底部评论
    self.keyBoardView = [[[NSBundle mainBundle] loadNibNamed:@"CommentsKeyWordView" owner:nil options:nil] lastObject];
    self.keyBoardView.frame = self.inpuView.bounds;
    [self.inpuView addSubview:self.keyBoardView];
    [self.keyBoardView creatLayout];
    self.keyBoardView.textViewLable.text = NSLocalizedString(@"enterComments", nil);
    self.keyBoardView.keyboardDelegate = self;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.keyBoardView.inPutChangeButton addTarget:self action:@selector(inPutChangeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)loadingMoreData{
    self.page++;
    [self getNetWorkData];
}
-(void)getNetWorkData{
   
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        DBShareMessage * model = self.dbModel;
        return model.cellHeightMax;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        PublicFistTableViewController * tabVc = [self.storyboard instantiateViewControllerWithIdentifier:@"PublicFistTableViewController"];
        ShareMessageTableViewCell * cell = [tabVc.tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.contentLabel.numberOfLines = 0;
        DBShareMessage * model = self.dbModel;
        [cell setLayoutData:model withIndePath:indexPath withViewSource:2];
        return cell;
    }else{
        
        return nil;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark 键盘回调
//实时监测j输入的高度
-(void)textViewDidChangeTextHeright:(CGFloat)textViewHeight{
    self.inputViewHeightValue.constant = textViewHeight;
}
//输入的文字
-(void)chatpageKeyboardDelegate:(NSString *)string{
    [self expressionSendButtonClick];
    
}
//监听键盘动作为抬起
- (void)keyBoardWillShow:(CGFloat)indexhight{
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.2 animations:^{
        // Make all constraint changes here
        self.inputViewBottomValue.constant = -indexhight;
    }];
}
//监听键盘动作为收回
- (void)keyBoardWillHide{
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        // Make all constraint changes here
        self.inputViewBottomValue.constant = 0;
    }];
}
-(void)inPutChangeButtonClick:(UIButton *)button{
    
    
    if (button.selected) {
        [self.keyBoardView.textView becomeFirstResponder];
        [UIView animateWithDuration:0.2 animations:^{
            self.expressionView.frame = CGRectMake(0, kScreen_Height, kScreen_Width, self.expressionView.frame.size.height);
        }];
    }else{
        [self.keyBoardView.textView resignFirstResponder];
        [self.view layoutIfNeeded];
        self.expressionView.hidden = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.expressionView.frame = CGRectMake(0, kScreen_Height - self.expressionView.frame.size.height - Height_BottomSafetyZone, kScreen_Width, self.expressionView.frame.size.height);
            self.inputViewBottomValue.constant = -self.expressionView.frame.size.height;
        }];
        
    }
    button.selected = !button.isSelected;
}
-(ExpressionKeyWordView *)expressionView{
    if (_expressionView == nil) {
        _expressionView = [[[NSBundle mainBundle] loadNibNamed:@"ExpressionKeyWordView" owner:nil options:nil] lastObject];
        [_expressionView creatLayout];
        CGFloat itemWidth = kScreen_Width/7;
        CGFloat viewHeight = 3*itemWidth + 41;
        _expressionView.frame = CGRectMake(0, kScreen_Height, kScreen_Width, viewHeight);
        _expressionView.hidden = YES;
        [self.view addSubview:_expressionView];
        [_expressionView.sendButton addTarget:self action:@selector(expressionSendButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _expressionView.delegate = self;
    }
    
    return _expressionView;
}
-(void)expressionSendButtonClick{
    if (self.keyBoardView.textView.text.length < 1) {
        [MyAlerView alterMessage:NSLocalizedString(@"inputNoEmpty", nil)];
        return;
    }
    [self.keyBoardView textViewChuShiStype];
    [self.keyBoardView.textView resignFirstResponder];
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.2 animations:^{
        self.expressionView.frame = CGRectMake(0, kScreen_Height, kScreen_Width, self.expressionView.frame.size.height);
        self.inputViewBottomValue.constant = 0;
    }];
}
#pragma mark 表情回调
-(void)expressionKeyWord:(NSString *)string{
    
    self.keyBoardView.textViewLable.hidden = YES;
    if ([string isEqualToString:@"!!del!!"]) {
        if (self.keyBoardView.textView.text.length != 0) {
            NSMutableString * textStr = [NSMutableString stringWithString:self.keyBoardView.textView.text];
            self.keyBoardView.textView.text = [textStr substringWithRange:NSMakeRange(0, textStr.length-2)];
        }
    }else{
        self.keyBoardView.textView.text = [NSString stringWithFormat:@"%@%@",self.keyBoardView.textView.text,string];
    }
}
@end
