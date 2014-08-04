
#import "MyContext.h"
#import "MyState.h"
#import "MyStateNone.h"
#import "MyStateSetuped.h"
#import "MyStateStarting.h"
#import "MyStateRunning.h"
#import "MyStub1.h"
#import "MyPlayApi.h"

@interface MyContext ()
@property (nonatomic,strong) MyState *currentState;
@end

@implementation MyContext

static MyContext* sharedData_ = nil;

+ (MyContext*)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedData_ = [[MyContext alloc] init];
    });
    return sharedData_;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.currentState = [MyStateNone sharedManager];
    
    return self;
}


#pragma mark - Private

- (void)setCurrentState:(MyState *)currentState
{
    _currentState = currentState;
    
    [self.delegate didChangePlayState:[MyModelTypes convertToModelState:_currentState]];
}


#pragma mark - Public Method

- (bool)canSetupPlayer
{
    if (![[MyStateNone sharedManager] isMemberOfClass:[MyStateNone class]]) {;
        return false;
    }
    return true;
}

- (void)setupPlayer:(void (^)(bool success))completion
{
    __weak MyContext *weakSelf = self;
    
    [self.currentState setupPlayer:^(bool success) {
     
        if (success) {
            weakSelf.currentState = [MyStateSetuped sharedManager];
            completion(true);
        } else {
            self.currentState = [MyStateNone sharedManager];
            completion(false);
        }
    }];
}

- (bool)canStartPlayer
{
    if ([self.currentState isMemberOfClass:[MyStateStarting class]]) {
        return false;
    }
    
    self.currentState = [MyStateStarting sharedManager];
    return true;
}

- (void)startPlaying:(void (^)(bool success))completion
{
    __weak MyContext *weakSelf = self;
    
    [self.currentState startPlaying:^(bool success) {
        
        if (success) {
            [[MyPlayApi sharedManager] registSHListener];
            weakSelf.currentState = [MyStateRunning sharedManager];
            completion(true);
        } else {
            weakSelf.currentState = [MyStateNone sharedManager];
            completion(false);
        }
    }];
}

- (void)checkPlayState:(void (^)(bool isCanceled))completion
{
    [self.currentState checkPlayState:completion];
}

- (void)cancelPlaying
{
    [self.currentState cancelPlaying];
    
    self.currentState = [MyStateNone sharedManager];
}

- (void)resetState
{
    [[MyPlayApi sharedManager] unRegistSHListener];
    self.currentState = [MyStateNone sharedManager];
}

@end
