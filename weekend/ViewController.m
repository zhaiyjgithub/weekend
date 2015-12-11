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

@interface ViewController () <UINavigationControllerDelegate>
@property(nonatomic,strong)animationObjcet * animaObj;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"season";
    self.view.backgroundColor = [UIColor whiteColor];
    
   
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 100 ,160, 90)];
    imageView.image = [UIImage imageNamed:@"tower.png"];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
    
    [imageView addGestureRecognizer:gesture];
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 250, 100, 64)];
    [btn setTitle:@"next" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    btn.backgroundColor = [UIColor redColor];
   // [btn setBackgroundColor:[UIColor colorWithRed:68 green:131 blue:204 alpha:0]];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];

}

- (void)tapImageView:(UITapGestureRecognizer *)gesture{
    self.navigationController.delegate = self;
    detailItemViewController * detailItemVC = [[detailItemViewController alloc] init];
    detailItemVC.imageViewOriginRect = gesture.view.frame;
    detailItemVC.bottomImageView.image = ((UIImageView *)gesture.view).image;
    [self.navigationController pushViewController:detailItemVC animated:YES];
}

- (void)clickBtn{
    springViewController * springVC = [[springViewController alloc] init];
    [self.navigationController pushViewController:springVC animated:YES];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = nil;
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

@end
