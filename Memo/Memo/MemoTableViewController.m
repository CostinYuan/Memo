//
//  MemoTableViewController.m
//  Memo
//
//  Created by Jongkhurun on 2017/9/3.
//  Copyright © 2017年 Jongkhurun. All rights reserved.
//

#import "MemoTableViewController.h"
#import "DetailViewController.h"
#import "MemoModel.h"
#import "NSArray+SafetyArray.h"

// 声明遵循协议的MemoTableViewController代理方
@interface MemoTableViewController () <DetailViewControllerDelegate>

// 没有数据提示的label
@property (weak, nonatomic) UILabel *noDataHintLb;
// 存放备忘录的可变数组
@property (strong, nonatomic) NSMutableArray *dataArr;

@end

@implementation MemoTableViewController

// 界面初始化/加载
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 导航栏 标题 为备忘录
    self.navigationItem.title = @"备忘录";
    // 导航栏 非默认颜色值：橘色
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    // 导航栏 创建右侧"新建"按钮 点击调用createBtnClick方法
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"新建" style:UIBarButtonItemStylePlain target:self action:@selector(createBtnClick)];
    
    // 创建无数据Label对象
    UILabel *nodataHintLb = [[UILabel alloc] init];
    // 文本字体 25号系统默认字体
    nodataHintLb.font = [UIFont systemFontOfSize:25.0f];
    // 文本颜色 暗灰色
    nodataHintLb.textColor = [UIColor darkGrayColor];
    // 文本内容 "您还未创建备忘录"
    nodataHintLb.text = @"您还未创建备忘录";
    // 根据内容自适应尺寸
    [nodataHintLb sizeToFit];
    
    // 获取屏幕长宽
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    // 获取nodataHintLb的相对长宽
    CGFloat lbW = nodataHintLb.frame.size.width;
    CGFloat lbH = nodataHintLb.frame.size.height;
    CGFloat lbX = (screenWidth - lbW) / 2;
    CGFloat lbY = (screenHeight - lbH) / 2;
    // 定位nodataHintLb
    nodataHintLb.frame = CGRectMake(lbX, lbY - 64, lbW, lbH);
    
    // 获取替换属性
    _noDataHintLb = nodataHintLb;
    //添加无数据label控件
    [self.view addSubview:_noDataHintLb];
    // dataArr初始化
    _dataArr = [NSMutableArray array];
    
    
    
    // 去除tableView多余的分割线
    self.tableView.tableFooterView = [[UIView alloc] init];
}


//界面显示内容
- (void)viewWillAppear:(BOOL)animated {
 
    /*遍历_dataArr数组 把content为@""都删掉
    for (int i=0 ; i < _dataArr.count ; i++) {
        MemoModel *dic = _dataArr[i];
        if([dic.content  isEqual: @""]){
            [_dataArr New_objectAtIndex:i];
                    }
    }
    */
    
    [super viewWillAppear:animated];
    // 如果备忘录里的数量为0 tableview不能滚动 隐藏分割线 不隐藏noDataHintLb
    if (_dataArr.count == 0) {
        self.tableView.scrollEnabled = NO;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _noDataHintLb.hidden = NO;
        
    } else {
        
    // 如果不为0 tableView可滚动 单行分割线 隐藏noDataHintLb
        self.tableView.scrollEnabled = YES;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _noDataHintLb.hidden = YES;
        
    }
}

// 点击“创建”按钮方法
- (void)createBtnClick {
    // 创建一个内容显示控制器detailViewCtrl
    DetailViewController *detailViewCtrl = [[DetailViewController alloc] init];
    // 代理
    detailViewCtrl.delegate = (id)self;
    // 导航栏跳转至detailViewCtrl
    [self.navigationController pushViewController:detailViewCtrl animated:YES];
}

#pragma mark - UITableViewDataSource
// 返回section行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArr.count;
}

// 设置单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 重用Cell
    static NSString *reuseId = @"MemoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
        
    }
    // 获取指定行的对象到memo
    MemoModel *memo = [_dataArr objectAtIndex:indexPath.row];
    // 获取memo标题到单元格文本框
    cell.textLabel.text = memo.title;
    // 获取memo时间到子单元格文本框
    cell.detailTextLabel.text = memo.time;
    // 在cell右边放置小箭头标记
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

// 进入编辑状态
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

// 选择删除模式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

//删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 删除行
    [_dataArr removeObjectAtIndex:indexPath.row];
    // 刷新局部cell
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 一点击cell，立马取消选中状态
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    //新建详细视图框
    DetailViewController *detailViewCtrl = [[DetailViewController alloc] init];
    //自代理
    detailViewCtrl.delegate = (id)self;
    // 使用KVC，在跳转到detailViewController之前，设置memo的值
    MemoModel *memo = [_dataArr objectAtIndex:indexPath.row];
    [detailViewCtrl setValue:memo forKey:@"memo"];
    [self.navigationController pushViewController:detailViewCtrl animated:YES];
}

#pragma mark - DetailViewControllerDelegate
- (void)didFinishEditMemo:(MemoModel *)memo {
    
    for (MemoModel *temp in _dataArr) {
        // 查找数组中是否存在旧的memo，存在删除旧的，再重新添加到数组中。
        if ([temp.identifier isEqualToString:memo.identifier]) {
            [_dataArr removeObject:temp];
            break;
        }
    }
    //在最上行插入新建的备忘录
    [_dataArr insertObject:memo atIndex:0];
    //刷新界面
    [self.tableView reloadData];
    
}

@end
