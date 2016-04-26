//
//  LYHidenNavBarViewController.m
//  Navigation
//
//  Created by chairman on 16/4/26.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import "LYHidenNavBarViewController.h"

@interface LYHidenNavBarViewController ()

@end

@implementation LYHidenNavBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"隐藏NavBar";
    self.navigationItem.rightBarButtonItem = nil;
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

}
#pragma mark - 滑动隐藏导航栏
//* 并且手指离开时执行。一次有效滑动，只执行一次。当pagingEnabled属性为YES时，不调用，该方法 */
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{

    NSLog(@"======== %lf", velocity.y);

    if(velocity.y > 0) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    else {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
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
