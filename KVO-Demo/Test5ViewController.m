//
//  Test5ViewController.m
//  KVO-Demo
//
//  Created by 王泽龙 on 2019/4/28.
//  Copyright © 2019 王泽龙. All rights reserved.
//

#import "Test5ViewController.h"
#import "ZLPerson2.h"
#import <objc/runtime.h>

@interface Test5ViewController ()
@property (nonatomic, strong) ZLPerson2 *person;
@end

@implementation Test5ViewController

- (void)viewDidLoad {
    
    self.title = @"直接修改成员变量，不会触发kvo";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    self.person = [[ZLPerson2 alloc]init];
    self.person->_age = 1;
    
    ///> person1添加kvo监听
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.person addObserver:self forKeyPath:@"age" options:options context:nil];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    // 直接修改成员变量，不会触发kvo
    self.person->_age = 5;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"监听到了%@的%@属性发生了改变%@",object,keyPath,change);
}

- (void)dealloc {
    ///> 使用结束后记得移除
    [self.person removeObserver:self forKeyPath:@"age"];
}


- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
