//
//  ZJTabBarController.m
//  BuldingMall
//
//  Created by Jion on 16/9/5.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "ZJTabBarController.h"
#import "ZJNavigationController.h"
#import "ZJTabBar.h"

@interface ZJTabBarController ()<UITabBarControllerDelegate>


@end

@implementation ZJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    ZJTabBar *tabBar = [[ZJTabBar alloc]init];
    tabBar.centerBulge = YES;
    tabBar.backgroundImage = [UIImage imageNamed:@"sy_tab_bj_png"];
    [self setValue:tabBar forKey:@"tabBar"];
    
    [self buildTabBarView];

}


- (void)buildTabBarView{


    NSArray *titleArray = @[@"首页",@"分类",@"提问",@"品牌",@"我的"];
    
    NSArray *imageArray = @[@"homepage_table_zx_wxz_icon.png",@"homepage_table_jcjj_wxz_icon.png",@"sy_tab_wzj_icon.png",@"homepage_sy_tab_zjwd_icon.png",@"homepage_table_wd_wxz_icon.png"];
    NSArray *imageSelectArray =@[@"homepage_table_zx_xz_icon.png",@"homepage_table_jcjj_xz_icon.png",@"sy_tab_wzj_xz_icon.png",@"homepage_sy_tab_zjwd_xz_icon.png",@"homepage_table_wd_xz_icon.png"];
    NSArray *classNames = @[@"ViewController",@"UIViewController",@"UIViewController",@"UIViewController", @"UIViewController"];

    for (int j=0;j<classNames.count;j++) {
        NSString *className = classNames[j];
        UIViewController *vc = [(UIViewController*)[NSClassFromString(className) alloc] init];
        vc.view.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 ) saturation:( arc4random() % 128 / 256.0 ) + 0.5 brightness:( arc4random() % 128 / 256.0 ) + 0.5 alpha:1];
        vc.tabBarItem.image = [[UIImage imageNamed:imageArray[j]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        vc.tabBarItem.selectedImage = [[UIImage imageNamed:imageSelectArray[j]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.title = titleArray[j];

        //设置tabbar的title的颜色，字体大小，阴影
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:10],NSFontAttributeName, nil];
        [vc.tabBarItem setTitleTextAttributes:dic forState:UIControlStateNormal];

        NSShadow *shad = [[NSShadow alloc] init];
        shad.shadowColor = [UIColor whiteColor];
       // NSDictionary *selectDic = [NSDictionary dictionaryWithObjectsAndKeys:kGlobalColor,NSForegroundColorAttributeName,shad,NSShadowAttributeName,[UIFont boldSystemFontOfSize:10],NSFontAttributeName, nil];
        NSDictionary *selectDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],NSForegroundColorAttributeName,shad,NSShadowAttributeName,[UIFont boldSystemFontOfSize:10],NSFontAttributeName, nil];
        [vc.tabBarItem setTitleTextAttributes:selectDic forState:UIControlStateSelected];
        ZJNavigationController *navi = [[ZJNavigationController alloc] initWithRootViewController:vc];

       [self addChildViewController:navi];
    }


}

#pragma mark- TabBar Delegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    NSInteger index = [tabBarController.childViewControllers indexOfObject:viewController];
    
    if (index == 3) {
        
    }
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
