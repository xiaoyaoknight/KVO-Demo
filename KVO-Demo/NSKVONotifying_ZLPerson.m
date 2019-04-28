//
//  NSKVONotifying_ZLPerson.m
//  KVO-Demo
//
//  Created by 王泽龙 on 2019/4/28.
//  Copyright © 2019 王泽龙. All rights reserved.
//

#import "NSKVONotifying_ZLPerson.h"

@implementation NSKVONotifying_ZLPerson

- (void)setAge:(int)age{
    _NSSetIntValueAndNotify();// int类型  还存在_NSSetDoubleValueAndNotify 等等类型
}

/**
 内部可能是重写class方法，给开发者依然返回person类，屏蔽内部实现
 */
- (Class)class {
    return [ZLPerson class];
}

void _NSSetIntValueAndNotify(){
    [self willChangeValueForKey:@"age"];
    [super setAge:age];
    [self didChangeValueForKey:@"age"];
}

- (void)didChangeValueForKey:(NSString *)key{
    ///> 通知监听器 key发生了改变
    [observe observeValueForKeyPath:key ofObject:self change:nil context:nil];
}

@end
