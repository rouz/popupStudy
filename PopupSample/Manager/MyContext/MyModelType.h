
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MyModelState) {
    MyModelStateNone,
    MyModelStateSetuped,
    MyModelStateStarting,
    MyModelStateRunning
};


@class MyState;

@interface MyModelTypes : NSObject

+ (MyModelState)convertToModelState:(MyState*)state;

@end