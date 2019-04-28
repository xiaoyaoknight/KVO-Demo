//
//  Test1ViewController.m
//  KVO-Demo
//
//  Created by 王泽龙 on 2019/4/28.
//  Copyright © 2019 王泽龙. All rights reserved.
//

#import "Test1ViewController.h"
#import "ZLPerson.h"
#import <objc/runtime.h>

@interface Test1ViewController ()
@property (nonatomic, strong) ZLPerson *person1;
@property (nonatomic, strong) ZLPerson *person2;
@end

@implementation Test1ViewController

/**
 kvo简单实现
 */
- (void)viewDidLoad {
    self.title = @"kvo简单实现";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];

    self.person1 = [[ZLPerson alloc]init];
    self.person1.age = 1;
    
    self.person2 = [[ZLPerson alloc]init];
    self.person2.age = 2;
    
    ///> person1添加kvo监听
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.person1 addObserver:self forKeyPath:@"age" options:options context:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.person1.age = 20;
    self.person2.age = 30;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"监听到了%@的%@属性发生了改变%@",object,keyPath,change);
}

- (void)dealloc {
    ///> 使用结束后记得移除
    [self.person1 removeObserver:self forKeyPath:@"age"];
}

/*
 输出结果：
 监听到了<ZLPerson: 0x6000033d4e40>的age属性发生了改变- {
 kind = 1;
 new = 20;
 old = 1;
 }
 ///>  因为我们只监听了person1  所以只会输出person1的改变。
 */


- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
