//
//  ViewController.m
//  POPping
//
//  Created by chuck on 15-6-9.
//  Copyright (c) 2015年 ZK. All rights reserved.
//

#import "ViewController.h"
#import "animationObjcet.h"
#import "detailItemViewController.h"
#import "springViewController.h"

@interface ViewController () <UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)animationObjcet * animaObj;
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"season";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID;
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1) {
        self.navigationController.delegate = self;
        detailItemViewController *detailItemVC  = [[detailItemViewController alloc] init];
        [self.navigationController pushViewController:detailItemVC animated:YES];
    }else{
        springViewController * springVC = [[springViewController alloc] init];
        springVC.title = @"spring";
        [self.navigationController pushViewController:springVC animated:YES];
    }
    
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStyleGrouped)];
        // _tableView.contentInset = UIEdgeInsetsMake(middleInsertHeight, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = nil;
    
    ////改变bar的背景颜色
    //[[UINavigationBar appearance] setBarTintColor:kColor(53, 184, 174)];
    ////改变bar上面的按钮的颜
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.delegate = nil;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return self.animaObj;
}

- (animationObjcet *)animaObj{
    if (!_animaObj) {
        _animaObj = [[animationObjcet alloc] init];
    }
    return _animaObj;
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

@end
