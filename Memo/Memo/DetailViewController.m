//
//  DetailViewController.m
//  Memo
//
//  Created by Jongkhurun on 2017/9/3.
//  Copyright © 2017年 Jongkhurun. All rights reserved.
//

#import "DetailViewController.h"
#import "MemoModel.h"

@interface DetailViewController () <UITextViewDelegate>

@property (weak, nonatomic) UITextView *textView;  // 文本框

@property (nonatomic, strong) MemoModel *memo;  // 备忘录

@end

@implementation DetailViewController

// 界面初始化/加载
- (void)viewDidLoad {
    [super viewDidLoad];
    // 导航栏 设置右上角按键为完成 点击可调用completeBtnClick方法
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(completeBtnClick)];
    // 右上按钮不可使用
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    //导航栏 设置左上角按键为返回 点击也可保存
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"备忘录" style:UIBarButtonItemStylePlain target:self action:@selector(completeBtnClick)];
    
    // 界面背景图 白色
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 屏幕 获取屏幕长宽
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    // 文本框 创建文本框对象 并输入屏幕属性
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight * 1)];
    // 文本框 边框宽度为1 颜色为浅灰色
    textView.layer.borderWidth = 1;
    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    // 文本框 字体为16号系统字体
    textView.font = [UIFont systemFontOfSize:16.0f];
    // 键盘 拖动时消失
    textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    // 代理为自身
    textView.delegate = (id)self;
    // 获取替换属性
    _textView = textView;
    //添加文本框控件
    [self.view addSubview:_textView];
    
    // 判断memo是否存在，如果存在，则是通过行点击进入当前的界面，将memo的内容显示出来。
    if (_memo == nil) {
        _memo = [[MemoModel alloc] init];
    } else {
        _textView.text = _memo.content;
    }
}

//编辑完成
- (void)completeBtnClick {
    
    // 文本框取消第一响应者状态（键盘隐藏）
    [_textView resignFirstResponder];
   
    if(_textView.text != nil){
    // 调用方法changeContentWithContent更改内容和时间
    [_memo changeContentWithContent:_textView.text];
    
    // 判断是否有didFinishEditMemo方法 有则调用 无则直接跳回之前界面
    if ([self.delegate respondsToSelector:@selector(didFinishEditMemo:)]) {
        [self.delegate didFinishEditMemo:_memo];
    }
    [self.navigationController popViewControllerAnimated:YES];
    }
    
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    // 右上按钮可用
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

@end
