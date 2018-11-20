//
//  PhotoBrowsingViewController.m
//  FunacademyEducation
//
//  Created by 清 on 2018/11/19.
//  Copyright © 2018 清. All rights reserved.
//

#import "PhotoBrowsingViewController.h"
#import "ChatPhotoBrowserView.h"

@interface PhotoBrowsingViewController ()<PhotoBrowserViewDelegate>
@property(nonatomic,strong)ChatPhotoBrowserView * photoView;
@end

@implementation PhotoBrowsingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.photoView = [[ChatPhotoBrowserView alloc]initWithFrame:self.view.bounds];
    [self.backView addSubview:self.photoView];
    self.photoView.imageDataArray = self.imageUrlArray;
    self.photoView.indexPage = self.selectIndex;
    [self.photoView createLayout];
    self.photoView.pBdelegate = self;
    self.countLabel.text = [NSString stringWithFormat:@"%ld/%lu",(long)self.selectIndex+1,(unsigned long)self.imageUrlArray.count];
}
/**
 *  当前出现分页的情况就会调用
 *
 *  @param index 当前第几页
 */
-(void)PhotoBrowserDelegate:(NSInteger)index{
    self.countLabel.text = [NSString stringWithFormat:@"%ld/%lu",(long)index+1,(unsigned long)self.imageUrlArray.count];
}
/**
 *  点击屏幕就会调用
 *
 *  @param index 当前第几页
 */
-(void)PhotoBrowserTapGestureRecognizerDelegate:(NSInteger)index{
    [self dismissViewControllerAnimated:NO completion:nil];
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
