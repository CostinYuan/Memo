//
//  NSArray+SafetyArray.m
//  Memo
//
//  Created by Jongkhurun on 2017/9/7.
//  Copyright © 2017年 Jongkhurun. All rights reserved.
//

#import "NSArray+SafetyArray.h"


@implementation NSMutableArray (SafetyArray)

- (id)New_objectAtIndex:(NSUInteger)index{
    
    [super objectAtIndex:index];
    if (index < self.count)
    {
        return self[index];
    }
    else
    {
        return nil;
    }
    
}

@end
