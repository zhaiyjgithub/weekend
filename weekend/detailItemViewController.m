//
//  detailItemViewController.m
//  POPping
//
//  Created by admin on 15/12/5.
//  Copyright © 2015年 ZK. All rights reserved.
//

#import "detailItemViewController.h"
#import "animationObjcet.h"

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

@interface detailItemViewController ()<UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)animationObjcet * animaObj;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,assign)CGFloat yOffset;
@property(nonatomic,strong)UIImage * headerImage;

@property(nonatomic,strong)UIVisualEffectView * visualEffectView;
@property(nonatomic,strong)UILabel * contentLabel;

@end

const CGFloat middleInsertHeight = 320.0;
const CGFloat imageHeight = 180.0;
const CGFloat bottomInsertHeight = 280.0;
const CGFloat imageScale = 16.0f/9;

@implementation detailItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"summer";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self.view addSubview:self.bottomImageView];
    [self.view addSubview:self.visualEffectView];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];

    [self.tableView addSubview:self.contentLabel];
}

- (UIImage *)imageFromView: (UIView *) theView size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
//获得某个范围内的屏幕图像
- (UIImage *)imageFromView: (UIView *) theView   atFrame:(CGRect)r
{
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(r);
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return  theImage;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:(UIBarMetricsDefault)];
    self.navigationController.navigationBar.clipsToBounds = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.delegate = nil;
    self.navigationController.navigationBar.clipsToBounds = NO;
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[kColor(211, 40, 61) colorWithAlphaComponent:0.99]] forBarMetrics:UIBarMetricsDefault];
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
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //避免与下面的代理方法冲突，直接设置到400
    self.tableView.contentInset = UIEdgeInsetsMake(400-64, 0, 0, 0);
    self.yOffset = scrollView.contentOffset.y;
    
    if (self.yOffset >= 0.0) {//blur=1.0+大小不变
        self.contentLabel.alpha = 0.0f;
        CGFloat x2 = (180 + 64)*imageScale;
        CGFloat originX = -((x2 - kScreenWidth)/2);
        CGRect rect = CGRectMake(originX, 0, x2, 180);
        self.bottomImageView.frame = rect;
        self.visualEffectView.frame = rect;
        self.visualEffectView.alpha = 1.0;
        
    }else if (self.yOffset < -0.0 && self.yOffset >= -120.0){//blur*radius + 偏移速度较慢()
        self.contentLabel.alpha = 0.0f;
        CGFloat radius = (self.yOffset - (-120.0))*1.0/(120);
        CGFloat originYoffset = radius * 40;
        CGFloat x2 = (180+64)*imageScale;
        CGFloat originX = -((x2 - kScreenWidth)/2);
        CGRect rect = CGRectMake(originX, -originYoffset, x2, 180+64);
        self.bottomImageView.frame = rect;
        self.visualEffectView.frame = rect;
        self.visualEffectView.alpha = radius;
    }else if (self.yOffset < -120.0 && self.yOffset >= -180.0){//blur=0.0,保持
        self.contentLabel.alpha = 0.0f;
        CGFloat x2 = (180+64)*imageScale;
        CGFloat originX = -((x2 - kScreenWidth)/2);
        CGRect rect = CGRectMake(originX, 0, x2, 180+64);
        self.bottomImageView.frame = rect;
        self.visualEffectView.frame = rect;
        self.visualEffectView.alpha = 0.0;
    }else if ((self.yOffset >= -180.0) && (self.yOffset < 280.0f)) {//320->180 变小
        self.contentLabel.alpha = 0.0f;
        self.visualEffectView.alpha = 0.0f;
        CGFloat x2 = (-self.yOffset + 64)*imageScale;
        CGFloat originX = -((x2 - kScreenWidth)/2);
        CGRect rect = CGRectMake(originX, 0, x2, - self.yOffset + 64);
        self.bottomImageView.frame = rect;
        self.visualEffectView.frame = rect;
    }else{// >336  变大 + 继续blur
        CGFloat radius = (fabsf(self.yOffset) - (280))*1.0/(336 - 280);
        self.visualEffectView.alpha = radius - 0.1;
        self.contentLabel.alpha = radius;
        CGFloat x2 = (-self.yOffset + 64)*imageScale;
        CGFloat originX = -((x2 - kScreenWidth)/2);
        CGRect rect = CGRectMake(originX, 0, x2, - self.yOffset + 64);
        self.bottomImageView.frame = rect;
        self.visualEffectView.frame = rect;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (self.yOffset > (-320.0 + 64)) {
        targetContentOffset->x = 0.0f;
        if (targetContentOffset->y >= (-400.0f+64) && targetContentOffset->y <= (-320.0 + 64)) {
            targetContentOffset->y = -320.0f + 64;
        }
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return self.animaObj;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 568-64) style:(UITableViewStyleGrouped)];
        _tableView.contentInset = UIEdgeInsetsMake(kScreenWidth - 64, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (animationObjcet *)animaObj{
    if (!_animaObj) {
        _animaObj = [[animationObjcet alloc] init];
    }
    return _animaObj;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -((400)/2 - 30), kScreenWidth, 60)];
        _contentLabel.text = @"happy,weekend";
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.font = [UIFont systemFontOfSize:28.0f];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.alpha = 0.0f;
    }
    return _contentLabel;
}

- (UIImageView *)bottomImageView{
    if (!_bottomImageView) {
        
        int x2 = kScreenWidth*imageScale;
        int originX = -((x2 - kScreenWidth)/2);
        _bottomImageView = [[UIImageView alloc] init];
        _bottomImageView.frame = CGRectMake(originX, 0, x2, kScreenWidth);
    }
    return _bottomImageView;
}

- (UIVisualEffectView *)visualEffectView{
    if (!_visualEffectView) {
        UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _visualEffectView = [[UIVisualEffectView alloc]initWithEffect:beffect];
        _visualEffectView.frame = self.bottomImageView.frame;
        _visualEffectView.alpha = 0.01;
        [self.view addSubview:_visualEffectView];
    }
    return _visualEffectView;
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
@end
