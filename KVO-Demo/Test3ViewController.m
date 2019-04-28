//
//  Test3ViewController.m
//  KVO-Demo
//
//  Created by 王泽龙 on 2019/4/28.
//  Copyright © 2019 王泽龙. All rights reserved.
//

#import "Test3ViewController.h"

@interface Test3ViewController ()

@property (nonatomic, strong) UILabel *deslabel;
@end

@implementation Test3ViewController


/**
 查看person内部实现
 */
- (void)viewDidLoad {
    
    self.title = @"kvo调用顺序";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];

    self.deslabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 300, 600)];
    self.deslabel.font = [UIFont systemFontOfSize:14];
    self.deslabel.textColor = [UIColor redColor];
    self.deslabel.textAlignment = NSTextAlignmentLeft;
    self.deslabel.numberOfLines = 0;
    [self.view addSubview:self.deslabel];
    
    self.deslabel.text = @"willChangeValueForKey\ndidChangeValueForKey - begin\n监听到了<DLPerson: 0x60000041afe0>的age属性发生了改变{\nkind = 1;\nnew = 20;\nold = 10;\n}\ndidChangeValueForKey - end\n\n\n\n调用willChangeValueForKey:\n调用原来的setter实现\n调用didChangeValueForKey:";
    
    
    /*
     willChangeValueForKey
     didChangeValueForKey - begin
     监听到了<DLPerson: 0x60000041afe0>的age属性发生了改变{
     kind = 1;
     new = 20;
     old = 10;
     }
     didChangeValueForKey - end

     调用willChangeValueForKey:
     调用原来的setter实现
     调用didChangeValueForKey:

     */
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
