//
//  VZUserInput.m
//  DaCar
//
//  Created by vad on Mon Dec 15 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "VZInputManager.h"

static BOOL keyFlags[lastUsedKey];
static unsigned short keySet[lastUsedKey];
static NSPoint _mouseLoc;
static VZInputManager* sharedInstance=nil;
    
@implementation VZInputManager

+ (void) initClass{

    keySet[leftKey]=NSLeftArrowFunctionKey;
    keySet[rightKey]=NSRightArrowFunctionKey;
    keySet[upKey]=NSUpArrowFunctionKey;
    keySet[downKey]=NSDownArrowFunctionKey;
    keySet[fireKey]=' ';
    keySet[altFireKey]=13;
    keySet[abortKey]=27;
    keySet[pauseKey]='p';
    
}
+ (VZInputManager*) sharedManager{
    if (!sharedInstance) {
        NSLog(@"key man initialize");
        sharedInstance=[self new];
        keySet[leftKey]=NSLeftArrowFunctionKey;
        keySet[rightKey]=NSRightArrowFunctionKey;
        keySet[upKey]=NSUpArrowFunctionKey;
        keySet[downKey]=NSDownArrowFunctionKey;
        keySet[fireKey]=' ';
        keySet[altFireKey]=13;
        keySet[abortKey]=27;
        keySet[pauseKey]='p';
    }
    return sharedInstance;
}

//**********************************************
- (void) keyDown: (NSEvent*) ev{
    unsigned short kc, i;
    NSString* unic;
    if ([ev isARepeat]) return;
    
    //kc=[ev keyCode];
    unic=[ev characters];

    kc=[unic characterAtIndex:[unic length]-1];
    for (i=0; i<lastUsedKey; i++) 
        if (keySet[i]==kc) keyFlags[i]=YES;

}
- (void) keyUp: (NSEvent*) ev{
    unsigned short kc, i;
    NSString* unic;
    //kc=[ev keyCode];
    unic=[ev characters];
    kc=[unic characterAtIndex:[unic length]-1];
    for (i=0; i<lastUsedKey; i++) 
        if (keySet[i]==kc) keyFlags[i]=NO;
}
- (void) mouseMoved: (NSEvent*) ev {
	_mouseLoc = [ev locationInWindow];
}
//**********************************************
-(BOOL) isKeyDown: (VZKeyType) key{
    return keyFlags[key];
}

- (void) setKeyForLeft: (char) key{
    keySet[leftKey]=key;
}
- (void) setKeyForRight: (char) key{
    keySet[rightKey]=key;
}
- (void) setKeyForUp: (char) key{
    keySet[upKey]=key;
}
- (void) setKeyForDown: (char) key{
    keySet[downKey]=key;
}
- (void) setKeyForFire: (char) key{
    keySet[fireKey]=key;
}
- (void) setKeyForAbort: (char) key{
    keySet[abortKey]=key;
}
- (void) setKeyForPause: (char) key{
    keySet[pauseKey]=key;
}


@end
