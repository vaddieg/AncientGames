//
//  VNTIView.h
//  VNTI
//
//  Created by vad zimin on Fri Aug 29 2003.
//  Copyright (c) 2003, __MyCompanyName__. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>
#import <Cocoa/Cocoa.h>
#include <math.h>


@interface VNTIView : ScreenSaverView 
{
    NSImage* imgs[100];
    NSImage* obj, *buf;
    float x,y,z; //coordinates
    float xAmp,yAmp,zAmp; //amplitudes
    float step,t;
    int currentFrame;
    int mX,mY;
    BOOL prevMode;
    NSRect refr;
    
    NSMutableDictionary* txtAttr;
    NSImage* txtBuff;
    float tX,tY, tT;
}

@end
