//
//  cockSaverView.h
//  cockSaver
//
//  Created by vad zimin on Fri Jul 11 2003.
//  Copyright (c) 2003, __MyCompanyName__. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>
#import <Cocoa/Cocoa.h>


@interface cockSaverView : ScreenSaverView 
{
    NSImage* flyingCock, *flyingChicken, *rabbit, *igel, *frog;
    NSSound* snd, *frogSnd;
    NSWindow* confWin;
    NSWindowController* winCont;
	// cock params
    int x,y,spx,spy,mX,mY;
    int rabX, rabMov, igelX,igelMov, frogX, frogMov;
    int curFrame,curRabFrame,curIgelFrame,curFrogFrame;
    BOOL prevMode;
    int odd;// divider of framerate
    NSRect igelRect, rabRect, cockRect, frogRect;
	
	// baloon
	NSImage* _baloon;
	NSPoint _balPos;
	NSArray* _phrases;
	int baloonLife, baloonDuration;
	NSRect _balRect;
}

@end
