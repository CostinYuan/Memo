//
//  MemoModel.m
//  Memo
//
//  Created by Jongkhurun on 2017/9/3.
//  Copyright © 2017年 Jongkhurun. All rights reserved.
//

#import "MemoModel.h"

@implementation MemoModel

- (instancetype)init {
    
    if (self = [super init]) {
        // 初始化的时候，就创建时间和唯一标识
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.time = [formatter stringFromDate:[NSDate date]];
        self.identifier = self.time;
    }
    return self;
}

- (void)changeContentWithContent:(NSString *)content {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置时间格式
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 修改内容，同时也要修改时间
    self.time = [formatter stringFromDate:[NSDate date]];
    self.content = content;
    // 标题，截取内容中的前面一段字符串
    self.title = (content.length > 30) ? [content substringToIndex:30] : content;
}


@end
