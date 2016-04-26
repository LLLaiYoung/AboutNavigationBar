//
//  LYTransparent2ViewController.m
//  Navigation
//
//  Created by chairman on 16/4/26.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import "LYTransparent2ViewController.h"
#import "LYTransparent3ViewController.h"

@interface LYTransparent2ViewController ()

@end

@implementation LYTransparent2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"文字不消失(up)";
    UIBarButtonItem *ringhtItem = [[UIBarButtonItem alloc] initWithTitle:@"文字不消失(down)" style:UIBarButtonItemStylePlain target:self action:@selector(ringhtItemAction:)];
    self.navigationItem.rightBarButtonItem = ringhtItem;
}
#pragma mark - item Action
- (void)ringhtItemAction:(UIBarButtonItem *)sender {
    LYTransparent3ViewController *transparent3VC = [[LYTransparent3ViewController alloc] init];
    [self.navigationController pushViewController:transparent3VC animated:YES];
}
#pragma mark - ScrollViewDelegate
//* 动态隐藏Navi 文字不消失 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y;
    NSLog(@"y= %f",y);
    if(y <= 0){
        //* 文字不消失 */
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    } else {
        //* y/100 分母越大 就需要下拉越多 */
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1-y/100];
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
