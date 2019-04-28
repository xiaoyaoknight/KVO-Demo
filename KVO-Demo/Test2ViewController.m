//
//  Test2ViewController.m
//  KVO-Demo
//
//  Created by 王泽龙 on 2019/4/28.
//  Copyright © 2019 王泽龙. All rights reserved.
//

#import "Test2ViewController.h"
#import "ZLPerson.h"
#import <objc/runtime.h>

@interface Test2ViewController ()
@property (nonatomic, strong) ZLPerson *person1;
@property (nonatomic, strong) ZLPerson *person2;
@end

@implementation Test2ViewController

/**
 既然person1和person2的本质都是在调用set方法，就一定都会走在DLPerson类中的setAge这个方法。
 那么问题来了，同样走的是DLPerson类中的setAge方法，为什么person1就会走到???
 
 当一个对象添加了KVO的监听时，当前对象的isa指针指向的就不是你原来的类，指向的是另外一个类对象:
 person1.isa == NSKVONotifying_ZLPerson
 */
- (void)viewDidLoad {
    
    self.title = @"kvo本质分析";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];

    
    self.person1 = [[ZLPerson alloc]init];
    self.person1.age = 1;
    
    self.person2 = [[ZLPerson alloc]init];
    self.person2.age = 2;
    
    
    NSLog(@"person1添加kvo监听之前 %@ %@",
          object_getClass(self.person1),
          object_getClass(self.person2));
    
    ///> person1添加kvo监听
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.person1 addObserver:self forKeyPath:@"age" options:options context:nil];
    
    NSLog(@"person1添加kvo监听之后 %@ %@",
          object_getClass(self.person1),
          object_getClass(self.person2));
    
    /*
     控制台查看一下person1的isa指针和person2的：
     (lldb) p _person1->isa
     (Class) $1 = NSKVONotifying_ZLPerson
     (lldb) p _person2->isa
     (Class) $2 = ZLPerson
     */
    
    /*
     2019-04-26 18:49:40.782626+0800 KVO-Demo[8187:345410] person1添加kvo监听之前 ZLPerson ZLPerson
     2019-04-26 18:49:40.783070+0800 KVO-Demo[8187:345410] person1添加kvo监听之后 NSKVONotifying_ZLPerson ZLPerson
     */
  
    /*
    NSKVONotifying_ZLPerson类是 Runtime动态创建的一个类，在程序运行的过程中产生的一个新的类。
    NSKVONotifying_ZLPerson类是ZLPerson的一个子类。
    NSKVONotifying_ZLPerson类存在自己的 setAge:、class、dealloc、isKVOA...方法。
    */
    
    // 推测伪代码实现 查看NSKVONotifying_ZLPerson内部
    
    // 获取方法列表 传递真正的类
    [self printMethodNameOfClass:object_getClass(self.person1)];
    [self printMethodNameOfClass:object_getClass(self.person2)];
    
    /*
     KVO-Demo[36595:1343023] NSKVONotifying_ZLPerson, setAge:,class,dealloc,_isKVOA,
     KVO-Demo[36595:1343023] ZLPerson, willChangeValueForKey:,didChangeValueForKey:,setAge:,age,
     */
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.person1 setAge:20]; ///> 等同于self.person1.age = 20;
    [self.person2 setAge:30];///> 等同于self.person2.age = 30;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"监听到了%@的%@属性发生了改变%@",object,keyPath,change);
}


- (void)printMethodNameOfClass:(Class)cls {
    unsigned int count;
    // 获得方法数组
    Method *methodList = class_copyMethodList(cls, &count);
    // 存储方法名
    NSMutableString *methodNames = [NSMutableString string];
    // 遍历所有方法
    for (int i = 0; i < count; i++) {
        // 获得方法
        Method method = methodList[i];
        
        // 获得方法名
        NSString *methodName = NSStringFromSelector(method_getName(method));
        
        // 拼接方法
        [methodNames appendString:methodName];
        [methodNames appendString:@","];
    }
    // 释放
    free(methodList);
    
    NSLog(@"%@, %@", cls, methodNames);
}

- (void)dealloc {
    ///> 使用结束后记得移除
    [self.person1 removeObserver:self forKeyPath:@"age"];
}


- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
