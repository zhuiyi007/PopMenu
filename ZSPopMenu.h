//
//  ZSPopMenu.h
//  weibo
//
//  Created by ZhuiYi on 14/12/10.
//  Copyright (c) 2014年 ZhuiYi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^DismissBlock)();

@interface ZSPopMenu : NSObject
/**
 *  创建一个弹出菜单,指向view,内容为contentView,点击屏幕其他地方销毁菜单
 *
 *  @param view        指向的控件
 *  @param contentView 菜单中显示的内容
 *  @param dismiss     弹出菜单销毁时做的事情
 */
+ (void)popFromView:(UIView *)view contentView:(UIView *)contentView dismiss:(DismissBlock)dismiss;
/**
 *  创建一个弹出菜单,指向rect,坐标系为view,内容为contentView,点击屏幕其他地方销毁菜单
 *
 *  @param rect        指向的区域
 *  @param view        参照系
 *  @param contentView 菜单中显示的内容
 *  @param dismiss     弹出菜单销毁时做的事情
 */
+ (void)popFromRect:(CGRect)rect inView:(UIView *)view contentView:(UIView *)contentView dismiss:(DismissBlock)dismiss;

/**
 *  创建一个弹出菜单,指向view,内容为contentVC控制器,点击屏幕其他地方销毁菜单
 *
 *  @param view    菜单的箭头指向谁
 *  @param contentVc 菜单里面的内容
 *  @param dismiss 菜单销毁的时候想做的事情
 */
+ (void)popFromView:(UIView *)view contentVc:(UIViewController *)contentVc dismiss:(DismissBlock)dismiss;

/**
 *  创建一个弹出菜单,指向rect,坐标系为View,内容为contentVc控制器,点击屏幕其他地方销毁菜单
 *
 *  @param rect    菜单的箭头指向的矩形框
 *  @param view    参照系
 *  @param contentVc 菜单里面的内容
 *  @param dismiss 菜单销毁的时候想做的事情
 */
+ (void)popFromRect:(CGRect)rect inView:(UIView *)view contentVc:(UIViewController *)contentVc dismiss:(DismissBlock)dismiss;

@end
