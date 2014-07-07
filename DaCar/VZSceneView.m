//
//  VZSceneView.m
//  DaCar
//
//  Created by vad on Mon Dec 15 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "VZSceneView.h"


@implementation VZSceneView

- (id)initWithFrame:(NSRect)frame {
    self=[super initWithFrame: frame];
    if (self) {
		_objectsToDisplay=nil;
		_worldRect=NSZeroRect;
		_absCoordinates=YES;
	}
    return self;
}

- (void) dealloc{
    NSLog(@"scene view dealloc");
	[_objectsToDisplay release];
    [super dealloc];
}

-(BOOL) isOpaque{
	return YES;
}
- (void) setUsesAbsCoordinates: (BOOL) flag{
	_absCoordinates=flag;
}
- (BOOL) usesAbsCoordinates{
	return _absCoordinates;
}

- (void) setWordRect: (NSRect) rect{
	_worldRect=rect;
}
- (NSRect) worldRect{
	return _worldRect;
}
- (void) setObjectsToDisplay: (NSArray*) objts{
	[_objectsToDisplay release];
	_objectsToDisplay = [objts mutableCopy];
	
}
- (void) setObjectsToDisplay: (NSArray*) objts inWorldRect: (NSRect) rect{
	[self setObjectsToDisplay: objts];
	_worldRect=rect;
}

- (void) displayInWorldRect:  (NSRect) rect{
	_worldRect=rect;
	[self display];
}

- (void) displayObjects: (NSArray*) objts inWorldRect: (NSRect) rect{
	[self setObjectsToDisplay: objts];
	_worldRect=rect;
	[self display];
}
- (void) displayObjects: (NSArray*) objts{
	[self setObjectsToDisplay: objts];
	[self display];
}

- (void)display {
	[self setNeedsDisplay:YES];	
}

- (void) drawRect: (NSRect) rect{
	// Drawing code here.
	//[[NSGraphicsContext currentContext] setShouldAntialias:NO];
	[(NSMutableArray*)_objectsToDisplay sortUsingSelector:@selector(compareLayers:)];
	if (_absCoordinates)
		[_objectsToDisplay makeObjectsPerformSelector: @selector(display)];
	else {
		int i;
		for (i=0; i<[_objectsToDisplay count]; i++)
			[[_objectsToDisplay objectAtIndex: i] displayInWorldRect:_worldRect];
		
	}
}

@end
