//
//  LYTransparentViewController.m
//  Navigation
//
//  Created by chairman on 16/4/26.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import "LYTransparentViewController.h"
#import "LYTransparent2ViewController.h"
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
static NSString *cellIdentifier = @"cell";
@interface LYTransparentViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>

@end

@implementation LYTransparentViewController
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
#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"透明(文字消失)";
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    UIBarButtonItem *ringhtItem = [[UIBarButtonItem alloc] initWithTitle:@"透明文字不消失" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = ringhtItem;
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //*  [[weakSelf.navigationController.navigationBar subviews] objectAtIndex:0] UIBackdropEffectView(NavBar) */
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
}
#pragma mark - Item action
- (void)rightItemAction:(UIBarButtonItem *)sender {
    LYTransparent2ViewController *transpraent2VC = [[LYTransparent2ViewController alloc]
                                                init];
    transpraent2VC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:transpraent2VC animated:YES];
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
    return 50;
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
//* 动态隐藏Navi 文字消失 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y;
    NSLog(@"y= %f",y);
    if(y <= 0){
        //* 文字消失 */
        self.navigationController.navigationBar.alpha =1;
    } else {
        //* y/100 分母越大 就需要下拉越多 */
        self.navigationController.navigationBar.alpha = 1 - y/100;
    }
}
- (UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(255);
    CGFloat g = arc4random_uniform(255);
    CGFloat b = arc4random_uniform(255);
    
    return [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:1];
}
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
