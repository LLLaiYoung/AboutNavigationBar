//
//  LYTransparent3ViewController.m
//  Navigation
//
//  Created by chairman on 16/4/26.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import "LYTransparent3ViewController.h"
#import "LYTransparent4ViewController.h"
@interface LYTransparent3ViewController ()

@end

@implementation LYTransparent3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"文字不消失(down)";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"仿简书Nav" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}
#pragma mark - item action
- (void)rightItemAction:(UIBarButtonItem *)sender {
    LYTransparent4ViewController *transparent4VC = [[LYTransparent4ViewController alloc] init];
    [self.navigationController pushViewController:transparent4VC animated:YES];
}

#pragma mark - life
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
}
#pragma mark - ScrollViewDelegate
//* 动态隐藏Navi 文字不消失 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y;
    NSLog(@"y= %f",y);
    if(y <= 0){
        //* 文字不消失 */
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    } else {
        //* y/100 分母越大 就需要下拉越多 */
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:y/100];
    }
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
