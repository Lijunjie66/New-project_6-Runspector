//
//  main.m
//  New-project_6-Runspector
//
//  Created by Geraint on 2018/4/7.
//  Copyright © 2018年 kilolumen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <objc/runtime.h>// 必须导入这条语句才能将运行时系统库的API包含到这个文件中


// 创建测试类
@interface TestClass1 : NSObject
{@public int myInt;} //全局实例变量
@end
@implementation TestClass1
@end

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        // 为测试类创建几个实例并显示其数据
        TestClass1 *tc1A = [[TestClass1 alloc] init];
        tc1A->myInt = 0xa5a5a5a5;
        TestClass1 *tc1B = [[TestClass1 alloc] init];
        tc1B->myInt = 0xc3c3c3;
        long tc1Size = class_getInstanceSize([TestClass1 class]);
        NSData *obj1Data = [NSData dataWithBytes:(__bridge const void *)(tc1A) length:tc1Size];
        NSData *obj2Data = [NSData dataWithBytes:(__bridge const void *)(tc1B) length:tc1Size];
        NSLog(@"TestClass1 object tc1 contains %@",obj1Data);
        NSLog(@"TestClass1 object tc2 contains %@",obj2Data);
        NSLog(@"TestClass1 memory address = %p",[TestClass1 class]);
        
        
        // 获取并显示 TestClass 类实例的数据
        id testClz = objc_getClass("TestClass1");
        long tcSize = class_getInstanceSize([TestClass1 class]);
        NSData *tcData = [NSData dataWithBytes:(__bridge const void *)(testClz)
                                          length:tcSize];
        NSLog(@"TestClass1 class contains %@",tcData);
        NSLog(@"TestClass1 superclass memory address = %p",[TestClass1 superclass]);
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
