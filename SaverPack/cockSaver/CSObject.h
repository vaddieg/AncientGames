//
//  CSObject.h
//  cockSaver
//
//  Created by vad zimin on Mon Jul 14 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CSResMan.h>
@class cockSaverView;
typedef enum {norm=0, crazy=1, die=2, dead=3} CSObjectState;
typedef enum {cock=0, cousine=1, rabbit=2, hhog=3} CSObjectType;
static NSMtableArray* images;
static cockSaverView* view;

@interface CSObject : NSObject {
    NSPoint pos,spv;
    //float speed;
    //int direction;
    CSObjectState objState;
    CSObjectType objType;
    int curFrame,framesCount,stopFrame;
    int w,h;
    BOOL animated, stopping;
}

+(void) initRes;
-(CSObject*) initWithType:(CSObjectType)type;
-(void) move;
-(void) display;
-(void) startAnimation;
-(void) stopAnimationAt:(int)frame;

-(void) setFrameSize:(NSPoint)size Count:(int) count; 
-(void) setState:(int) state;
-(void) setSpeed:(NSPoint) speed;
-(CSObjectState) state;
-(NSPoint) position;

@end
