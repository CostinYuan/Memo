//
//  NSArray+SafetyArray.h
//  Memo
//
//  Created by Jongkhurun on 2017/9/7.
//  Copyright © 2017年 Jongkhurun. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSMutableArray (SafetyArray)

- (id)New_objectAtIndex:(NSUInteger)index;

@end
