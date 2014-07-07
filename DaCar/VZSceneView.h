//
//  VZSceneView.h
//  DaCar
//
//  Created by vad on Mon Dec 15 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//	View and object container role

#import <Cocoa/Cocoa.h>

@class VZGameObject;

@interface VZSceneView : NSView {
	BOOL _absCoordinates;
	NSRect _worldRect;
	NSMutableArray* _objectsToDisplay;
	
	
}
- (id)initWithFrame:(NSRect)frame;

// configuring view
- (void) setUsesAbsCoordinates: (BOOL) flag;
- (BOOL) usesAbsCoordinates;

- (void) setWordRect: (NSRect) rect;
- (NSRect) worldRect;
- (void) setObjectsToDisplay: (NSArray*) objts;
- (void) setObjectsToDisplay: (NSArray*) objts inWorldRect: (NSRect) rect;
// displaying
- (void) displayInWorldRect:  (NSRect) rect;
- (void) displayObjects: (NSArray*) objts inWorldRect: (NSRect) rect;
- (void) displayObjects: (NSArray*) objts;
- (void) display;

@end
