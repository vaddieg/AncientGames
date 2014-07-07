//
//  VZSceneController.h
//  DaCar
//
//  Created by vad on Mon Dec 15 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "VZSceneView.h"

#define kVZSceneFinishedNotification @"kVZSceneFinishedNotification"


@interface VZSceneController: NSObject {
    NSMutableArray* _objects;
	NSTimer* _timer;
	VZSceneView* _sceneView;
	NSRect _worldWindow;		//visible area of game world, can be moved
	BOOL _started;
	BOOL _paused;
	BOOL _absCoordinates;		//all objects globally positioned, world window is static 
	float _fps;
}

- (id) initWithDictionary: (NSDictionary*) dic superview: (NSView*) view inRect: (NSRect) rect;
- (id) init;
// if Rect = zerorect  all view space used
// Notifications
-(NSDictionary*)properties;
- (void) objectShouldRemove: (NSNotification*) aNotification;

//Accessing attrs
- (VZSceneView*) view;
- (void) setUsesAbsCoordinates: (BOOL) flag;
- (BOOL) usesAbsCoordinates;
- (void) setWorldWindow: (NSRect) rect;
- (NSRect) worldWindow;

- (BOOL) isStarted;
- (void) startWithFPS: (float) fps;
- (void) stop;
- (void) setPaused: (BOOL)flag;

- (void) addObject: (VZGameObject*) obj;
- (void) removeObject: (VZGameObject*) obj;
- (NSMutableArray*) objects;

- (void) finish;
- (NSDictionary*) resultDictionary; // should return info about why scene is finished

- (void) timerTick;
@end
