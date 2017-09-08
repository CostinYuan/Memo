//
//  MemoModel.h
//  Memo
//
//  Created by Jongkhurun on 2017/9/3.
//  Copyright © 2017年 Jongkhurun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemoModel : NSObject


@property (nonatomic, strong) NSString *content;  //内容
@property (nonatomic, strong) NSString *title;  //标题
@property (nonatomic, strong) NSString *time;   //时间
@property (nonatomic, strong) NSString *identifier;  //标识

//更改备忘录中的内容
- (void)changeContentWithContent:(NSString *)content;

@end
