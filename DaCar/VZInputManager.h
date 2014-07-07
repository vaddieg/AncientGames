//
//  VZUserInput.h
//  DaCar
//
//  Created by vad on Mon Dec 15 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum {
    leftKey=0, rightKey, upKey, downKey, fireKey, altFireKey, abortKey, pauseKey, otherKey,   lastUsedKey
} VZKeyType;

@interface VZInputManager : NSObject {
    
    /*
    id _target;
    SEL _action;
    BOOL sendsActionOnKeyDown;*/
}
+ (VZInputManager*) sharedManager;
- (void) keyDown: (NSEvent*) ev;
- (void) keyUp: (NSEvent*) ev;
- (void) mouseMoved: (NSEvent*) ev;
- (BOOL) isKeyDown: (VZKeyType) key;


- (void) setKeyForLeft: (char) key;
- (void) setKeyForRight: (char) key;
- (void) setKeyForUp: (char) key;
- (void) setKeyForDown: (char) key;
- (void) setKeyForFire: (char) key;
- (void) setKeyForAbort: (char) key;
- (void) setKeyForPause: (char) key;


@end
