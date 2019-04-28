//
//  Test3ViewController.m
//  KVO-Demo
//
//  Created by 王泽龙 on 2019/4/28.
//  Copyright © 2019 王泽龙. All rights reserved.
//

#import "Test4ViewController.h"
#import "ZLPerson.h"
#import <objc/runtime.h>

@interface Test4ViewController ()

@property (nonatomic, strong) ZLPerson *person1;
@end

@implementation Test4ViewController


- (void)viewDidLoad {
    
    self.title = @"手动出发KVO";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    self.person1 = [[ZLPerson alloc]init];
    self.person1.age = 1;
    
    ///> person1添加kvo监听
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.person1 addObserver:self forKeyPath:@"age" options:options context:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    // 手动出发KVO
    [self.person1 willChangeValueForKey:@"age"];
    [self.person1 didChangeValueForKey:@"age"];
}

- (void)dealloc {
    ///> 使用结束后记得移除
    [self.person1 removeObserver:self forKeyPath:@"age"];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"监听到了%@的%@属性发生了改变%@",object,keyPath,change);
}


- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
