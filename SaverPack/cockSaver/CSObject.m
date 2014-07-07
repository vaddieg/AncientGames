//
//  CSObject.m
//  cockSaver
//
//  Created by vad zimin on Mon Jul 14 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "CSObject.h"


@implementation CSObject

+(void) initRes{
    [images addObject:[[NSImage alloc] initWithContentsOfFile:@"/Library/Screen Savers/cockSaver.saver/Contents/Resources/cockLeft.tiff"]];
    [images addObject:[[NSImage alloc] initWithContentsOfFile:@"/Library/Screen Savers/cockSaver.saver/Contents/Resources/cockRight.tiff"]];

}
-(CSObject*) initWithType:(CSObjectType)type{
    [super init];
    objType=type;
    spv.x=-5;spv.y=0;
    pos.x=NSMaxX([view bounds]);
    pos.y=NSMidY([view bounds]);
    return self;
}
-(void) move{
    pos.x+=spv.x;
    pos.y+=spv.y;
    if (animated)
      if (curFrame<framesCount) {
         curFrame++;
         if (stopping&(curFrame==stopFrame)) animated=NO;
      }
      
}
-(void) display{
    [[images objectAtIndex:objType] compositeToPoint:pos fromRect:NSMakeRect(0,2020-(curFrame+1)*101,107,101) operation:NSCompositeSourceOver];

}
-(void) startAnimation{
    animated=YES;
    stopping=NO;
}
-(void) stopAnimationAt:(int)frame{
    stopping=YES;
    stopFrame=frame;
}

-(void) setFrameSize:(NSPoint)size Count:(int) count; 
-(void) setState:(int) state;
-(void) setSpeed:(NSPoint) speed;
-(CSObjectState) state;
-(NSPoint) position;
@end
