//
//  ZSPopMenu.m
//  weibo
//
//  Created by ZhuiYi on 14/12/10.
//  Copyright (c) 2014年 ZhuiYi. All rights reserved.
//

#import "ZSPopMenu.h"
@interface ZSPopMenu()

@end

@implementation ZSPopMenu
// 如果不加static修饰的话,外部可以通过extern来访问这个变量
// 加了static修饰后,只能本文件内使用
static UIButton *_cover;
static UIImageView *_imageView;
static UIViewController *_contentVc;
static UIWindow *_window;
// block定义全局变量
static DismissBlock _dismiss;

#pragma mark - 传入一个区域,坐标系和显示内容,弹出一个指向rect的菜单
+ (void)popFromRect:(CGRect)rect inView:(UIView *)view contentView:(UIView *)contentView dismiss:(DismissBlock)dismiss
{
    // block一般都要copy一下,内存管理问题
    // block不是OC对象,所以不能通过用强指针引用来保住他的生命周期
    // copy之后,会将block移动到堆区,就不会被释放掉
    _dismiss = [dismiss copy];
    // 自己创建一个最前面的window
    _window = [[UIWindow alloc] init];
    _window.frame = [UIScreen mainScreen].bounds;
    _window.hidden = NO;
    // 将窗口级别调到最高
    _window.windowLevel = UIWindowLevelAlert;
    // 转换坐标系
    CGPoint center = CGPointMake(rect.size.width / 2 + rect.origin.x, rect.size.height / 2 + rect.origin.y);
    CGPoint point = [_window convertPoint:center fromView:view];
    // 添加模板
    UIButton *cover = [UIButton buttonWithType:UIButtonTypeCustom];
    [cover setBackgroundColor:[UIColor blackColor]];
    [cover setAlpha:0.3];
    cover.frame = [UIScreen mainScreen].bounds;
    [cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
    _cover = cover;
    [_window addSubview:cover];
    // 添加背景图片
    CGFloat space = 10;
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"popover_background"];
    imageView.width = contentView.width + 2 * space;
    imageView.height = contentView.height + 3 * space;
    // 根据传进来的view的位置来计算弹窗的位置
    imageView.x = point.x - imageView.width / 2;
    imageView.y = point.y + rect.size.height / 2;
    imageView.userInteractionEnabled = YES;
    _imageView = imageView;
    [_window addSubview:imageView];
    // 在view中添加内容View,并计算好位置
    contentView.x = space;
    contentView.y = space + 5;
    [imageView addSubview:contentView];
}

#pragma mark - 传入一个View和显示内容,弹出一个指向View的菜单
+ (void)popFromView:(UIView *)view contentView:(UIView *)contentView dismiss:(DismissBlock)dismiss
{
    [self popFromRect:view.bounds inView:view contentView:contentView dismiss:dismiss];
}

#pragma mark - 传入一个区域,坐标系和控制器,弹出一个指向rect的菜单
+ (void)popFromRect:(CGRect)rect inView:(UIView *)view contentVc:(UIViewController *)contentVc dismiss:(DismissBlock)dismiss
{
    _contentVc = contentVc;
    
    [self popFromRect:rect inView:view contentView:contentVc.view dismiss:dismiss];
}

#pragma mark - 传入一个View和控制器,弹出一个指向View的菜单
+ (void)popFromView:(UIView *)view contentVc:(UIViewController *)contentVc dismiss:(DismissBlock)dismiss
{
    _contentVc = contentVc;
    
    [self popFromView:view contentView:contentVc.view dismiss:dismiss];
}


#pragma mark - 蒙板点击事件
+ (void)coverClick
{
    [_cover removeFromSuperview];
    _cover = nil;
    [_imageView removeFromSuperview];
    _imageView = nil;
    // block要先判断是否为空
    // 如果不判断的话,相当于nil();会直接报错
    if (_dismiss)
    {
        _dismiss();
    }
    _dismiss = nil;
    _contentVc = nil;
    _window.hidden = YES;
    _window = nil;
}

@end
