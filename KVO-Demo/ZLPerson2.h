//
//  ZLPerson2.h
//  KVO-Demo
//
//  Created by 王泽龙 on 2019/4/28.
//  Copyright © 2019 王泽龙. All rights reserved.
//

#import <Foundation/Foundation.h>

//直接修改成员变量，不会触发kvo 本质是对set方法进行重写
@interface ZLPerson2 : NSObject {
    @public
    int _age;
}

@end

