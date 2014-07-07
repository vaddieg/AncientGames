//
//  VZGameController.m
//  DaCar
//
//  Created by vad on Mon Dec 15 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "VZGameController.h"
#import "VZSceneController.h"
#import "VZGameObject.h"
#import "VZInputManager.h"

@implementation VZGameController

- (id) initWithWindow: (NSWindow*) window{
    self=[super initWithWindow: window];
    if (self) {
		[[self window] setAcceptsMouseMovedEvents:YES];
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(sceneFinished:) name:kVZSceneFinishedNotification object:nil];
        _currentScene=nil;
    }
    return self;

}
- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    if (_currentScene) [_currentScene release];
    [super dealloc];
}

-(void)awakeFromNib {
	[[self window] setAcceptsMouseMovedEvents:YES];
	[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(sceneFinished:) name:kVZSceneFinishedNotification object:nil];

}
#pragma mark -

- (void) keyDown: (NSEvent*) ev {
   // NSLog(@"kdown");
    [[VZInputManager sharedManager] keyDown: ev];
}
- (void) keyUp: (NSEvent*) ev {
    [[VZInputManager sharedManager] keyUp: ev];
}
-(void)mouseMoved:(NSEvent*) ev {
	[[VZInputManager sharedManager] mouseMoved: ev];
}
/*
-(void)mouseUp:(NSEvent*) ev {
	[[VZInputManager sharedManager] mouseUp: ev];
}
-(void)mouseDown:(NSEvent*) ev {
	[[VZInputManager sharedManager] mouseDown: ev];
}*/

#pragma mark -
- (void) setScene: (VZSceneController*) scene{
    if (_currentScene==scene) return;
    if (_currentScene) {
		[_currentScene stop];
        [_currentScene release];
	}
    //_currentScene=[scene retain];
	_currentScene=[scene retain];
}

- (void) sceneFinished: (NSNotification*) not{
        
}
- (void) addScene: (id) sender{

}
@end
