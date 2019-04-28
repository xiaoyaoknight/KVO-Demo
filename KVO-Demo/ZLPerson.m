//
//  ZLPerson.m
//  KVO-Demo
//
//  Created by 王泽龙 on 2019/4/26.
//  Copyright © 2019 王泽龙. All rights reserved.
//

#import "ZLPerson.h"

@implementation ZLPerson

- (void)setAge:(int)age {
    _age = age;
}

#pragma mark kvo调用方法
- (void)willChangeValueForKey:(NSString *)key{
    [super willChangeValueForKey:key];
    NSLog(@"willChangeValueForKey");
}


/**
 总结：didChangeValueForKey:内部会调用observer的observeValueForKeyPath:ofObject:change:context:方法
 */
- (void)didChangeValueForKey:(NSString *)key{
    NSLog(@"didChangeValueForKey - begin");
    [super didChangeValueForKey:key];
    NSLog(@"didChangeValueForKey - end");
}

@end
