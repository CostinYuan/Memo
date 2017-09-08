//
//  DetailViewController.h
//  Memo
//
//  Created by Jongkhurun on 2017/9/3.
//  Copyright © 2017年 Jongkhurun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MemoModel;

// 声明协议
@protocol DetailViewControllerDelegate <NSObject>
// 声明 完成编辑备忘录后的回调函数 的方法
- (void)didFinishEditMemo:(MemoModel *)memo;

@end

@interface DetailViewController : UIViewController
// 委托方DetailViewController声明一个代理方delegate 遵守协议DetailViewControllerDelegate
@property (weak, nonatomic) id<DetailViewControllerDelegate> delegate;

@end

