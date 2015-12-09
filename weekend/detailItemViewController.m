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
@property(nonatomic,strong)UIImage * blurHeigestImage;
@property(nonatomic,strong)CIContext * context;
@property(nonatomic,strong)CIImage * ciImage;
@property(nonatomic,strong)UIView * stausBackgroundView;
@property(nonatomic,strong)UIVisualEffectView * visualEffectView;
@property(nonatomic,weak)UIVisualEffectView * navigationVisualView;

@property(nonatomic,strong)UIImage * stautsImage;

@property(nonatomic,strong)UIImageView * bottomImageView;


@end

const CGFloat middleInsertHeight = 320.0;
const CGFloat imageHeight = 180.0;
const CGFloat bottomInsertHeight = 280.0;
const CGFloat imageScale = 16.0f/9;

@implementation detailItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"summer";
    self.view.backgroundColor = [UIColor yellowColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"tower" ofType:@"png"];
    self.headerImage =[UIImage imageWithContentsOfFile:path];
    
    int x2 = 320*imageScale;
    int originX = -((x2 - 320.0)/2);
    self.bottomImageView = [[UIImageView alloc] init];
    self.bottomImageView.frame = CGRectMake(originX, 0, x2, 320);
    self.bottomImageView.image = self.headerImage;
    [self.view addSubview:self.bottomImageView];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    
//    UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    UIVisualEffectView * visualView = [[UIVisualEffectView alloc]initWithEffect:beffect];
//    visualView.frame = self.headImageView.frame;
//    visualView.alpha = 1.0;
//    self.visualEffectView = visualView;
//    [self.tableView addSubview:visualView];
    
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
    NSLog(@"offset:%f",scrollView.contentOffset.y);
    //避免与下面的代理方法冲突，直接设置到400
    self.tableView.contentInset = UIEdgeInsetsMake(400-64, 0, 0, 0);
    self.yOffset = scrollView.contentOffset.y;
    
    if (self.yOffset >=  - 180.0 ) {//180->0
        self.headImageView.frame = CGRectMake(0, -180, 320, 180);
        self.visualEffectView.frame = self.headImageView.frame;
        if (self.yOffset > - 150.0) {
            CGFloat radius = 0.0f;
            if (self.yOffset > -64.0) {
                radius = 0.0f;
            }else{
                radius = (150.0 - (-self.yOffset))*1.0/(150 - 64)*1.0f;
            }
            self.visualEffectView.alpha = radius;
            if (self.yOffset > - 64.0f) {
                
            }else{
                
            }
        }
    }else if ((self.yOffset >= -320.0) && (self.yOffset < 180.0f)) {//320->180
        CGFloat x2 = (-self.yOffset)*imageScale;
        CGFloat originX = -((x2 - 320.0)/2);
        self.headImageView.frame = CGRectMake(originX, self.yOffset, x2, - self.yOffset);
        self.visualEffectView.frame = self.headImageView.frame;
        self.visualEffectView.alpha = 0.0;
        self.headImageView.image = self.headerImage;
        
    }else{// >320
        CGFloat x2 = (-self.yOffset)*imageScale;
        CGFloat originX = -((x2 - 320.0)/2);
        self.headImageView.frame = CGRectMake(originX, self.yOffset, x2, - self.yOffset);
        self.headImageView.image = self.headerImage;
        self.visualEffectView.frame = self.headImageView.frame;
        self.visualEffectView.alpha = 0.0;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSLog(@"end yoffset:%f",targetContentOffset->y);
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, 568-64) style:(UITableViewStyleGrouped)];
        _tableView.contentInset = UIEdgeInsetsMake(320-64, 0, 0, 0);
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

- (UIView *)stausBackgroundView{
    if (!_stausBackgroundView) {
        _stausBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        _stausBackgroundView.backgroundColor = [UIColor redColor];
        
        UIImageView * statusBarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
       // [_stausBackgroundView addSubview:statusBarImageView];
        statusBarImageView.image = self.stautsImage;
    }
    return _stausBackgroundView;
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
