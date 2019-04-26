//
//  ViewController.m
//  KVO-Demo
//
//  Created by 王泽龙 on 2019/4/26.
//  Copyright © 2019 王泽龙. All rights reserved.
//

#import "ViewController.h"
#import "ZLPerson.h"
#import <objc/runtime.h>

@interface ViewController ()
@property (nonatomic, strong) ZLPerson *person1;
@property (nonatomic, strong) ZLPerson *person2;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.person1 = [[ZLPerson alloc]init];
    self.person1.age = 1;
    
    self.person2 = [[ZLPerson alloc]init];
    self.person2.age = 2;
    
    
    NSLog(@"person1添加kvo监听之前 %@ %@",
          object_getClass(self.person1),
          object_getClass(self.person2));
    
//    NSLog(@"person1添加kvo监听之前 %@ %@",
//          [self.person1 methodForSelector:@selector(setAge:)],
//          [self.person2 methodForSelector:@selector(setAge:)]);
    
    
    ///> person1添加kvo监听
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.person1 addObserver:self forKeyPath:@"age" options:options context:nil];
    
    NSLog(@"person1添加kvo监听之后 %@ %@",
          object_getClass(self.person1),
          object_getClass(self.person2));
    
//    NSLog(@"person1添加kvo监听之后 %@ %@",
//          [self.person1 methodForSelector:@selector(setAge:)],
//          [self.person2 methodForSelector:@selector(setAge:)]);
    
    /*
    2019-04-26 18:49:40.782626+0800 KVO-Demo[8187:345410] person1添加kvo监听之前 ZLPerson ZLPerson
    2019-04-26 18:49:40.783070+0800 KVO-Demo[8187:345410] person1添加kvo监听之后 NSKVONotifying_ZLPerson ZLPerson
     */
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.person1.age = 20;
//    [self.person1 setAge:20];
    
    self.person2.age = 30;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"监听到了%@的%@属性发生了改变%@",object,keyPath,change);
}

- (void)dealloc{
    ///> 使用结束后记得移除
    [self.person1 removeObserver:self forKeyPath:@"age"];
}

@end
