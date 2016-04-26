//
//  LYScaleViewController.m
//  Navigation
//
//  Created by chairman on 16/4/26.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import "LYScaleViewController.h"
#import "LYHidenNavBarViewController.h"
#import "LYTransparentViewController.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

static NSString *cellIdentifier = @"cell";
@interface LYScaleViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *topScaleIconImageView;
@end

@implementation LYScaleViewController

#pragma mark - View init
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        //* 内容与外边界之间的内间距 */
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        //* 指定滚动条在scrollerView中的位置 */
        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}
/**
 *  设置contentInset带来的小问题
 *  1.webView初始加载时底部的黑条 解决方案－>WebView初始化时设置opaque=NO，也就是使得view透明，但是在加载之后，要设置opaque=YES
 *  2.滑动偏移量改变
 */
#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self createScaleHeaderView];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"NavBar隐藏" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIBarButtonItem *ringhtItem = [[UIBarButtonItem alloc] initWithTitle:@"NavBar透明" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = ringhtItem;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //*  [[weakSelf.navigationController.navigationBar subviews] objectAtIndex:0] UIBackdropEffectView(NavBar) */
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    //* 设置navBar的颜色 */
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}
#pragma mark - Item Action
- (void)leftItemAction:(UIBarButtonItem *)sender {
    LYHidenNavBarViewController *hidenVC = [[LYHidenNavBarViewController alloc] init];
    hidenVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:hidenVC animated:YES];
}
- (void)rightItemAction:(UIBarButtonItem *)sender {
    LYTransparentViewController *transparentVC = [[LYTransparentViewController alloc] init];
    transparentVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:transparentVC animated:YES];
}

#pragma mark - 头部缩放icon
- (void)createScaleHeaderView {
    UIView *topContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 78, 44)];
    topContainerView.backgroundColor = [UIColor clearColor];
    self.topScaleIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 78, 78)];
    self.topScaleIconImageView.backgroundColor = [UIColor whiteColor];
    self.topScaleIconImageView.layer.cornerRadius = self.topScaleIconImageView.bounds.size.height/2;
    self.topScaleIconImageView.layer.masksToBounds = YES;
    //* 设置锚点 anchorPoint显示的位置是根据bounds来的。 anchorPoint点是相对layer的 */
    self.topScaleIconImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    self.topScaleIconImageView.image = [UIImage imageNamed:@"head"];
    [topContainerView addSubview:self.topScaleIconImageView];
    self.navigationItem.titleView = topContainerView;
}
#pragma mark - 设置分割线顶头
//* 在tableView willDisplayCell 中也要实现cell的setSeparatorInset、setLayoutMargins */
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [self randomColor];
    return cell;
}
#pragma mark - UITableViewDelegate 
//* 配合viewDidLayoutSubviews 设置分割线顶头 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}
#pragma mark - ScrollViewDelegate
//* NavTitleView 缩放 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{    
    
    //* self.tableView.contentInset.top == 64 */
    CGFloat offsetY = scrollView.contentOffset.y +  self.tableView.contentInset.top;//注意
    NSLog(@"_tableView.contentInset.top = %f",offsetY);
    /**
     1 - offsetY/num1 = 0.45;
     0.45 为最终缩小倍率
     offsetY 为纵偏移量
     num1=300 为要计算的值
     150/165  就是滑动多少距离后，完成缩放
     */
    if (offsetY < 0 && offsetY >= -150) {
        self.topScaleIconImageView.transform = CGAffineTransformMakeScale(1 + offsetY/(-300), 1 + offsetY/(-300));
//        self.topScaleIconImageView.layer.anchorPoint = CGPointMake(0.5, offsetY/600. + 0.5);
        //        NSLog(@"%lf - %lf", offsetY, 1 + offsetY/(-300));
    }
    else if (offsetY >= 0 && offsetY <= 165) {
        self.topScaleIconImageView.transform = CGAffineTransformMakeScale(1 - offsetY/300, 1 - offsetY/300);
//        self.topScaleIconImageView.layer.anchorPoint = CGPointMake(0.5, 0.5 + offsetY/600.);
    }
    else if (offsetY > 165) {
        self.topScaleIconImageView.transform = CGAffineTransformMakeScale(0.45, 0.45);
//        self.topScaleIconImageView.layer.anchorPoint = CGPointMake(0.5, 1);
    }
    else if (offsetY < -150) {
        self.topScaleIconImageView.transform = CGAffineTransformMakeScale(1.5, 1.5);
//        self.topScaleIconImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    }
    
    CGRect frame = self.topScaleIconImageView.frame;
    frame.origin.y = 5;
    self.topScaleIconImageView.frame = frame;
}
- (UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(255);
    CGFloat g = arc4random_uniform(255);
    CGFloat b = arc4random_uniform(255);
    
    return [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:1];
}
#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
