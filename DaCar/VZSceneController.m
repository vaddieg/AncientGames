//
//  VZSceneController.m
//  DaCar
//
//  Created by vad on Mon Dec 15 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "VZSceneController.h"
#import "VZActiveObject.h"

#define kObjectsArrayKey @"kObjectsArrayKey"

// subclasses should import all used game objects

@implementation VZSceneController

- (id) initWithDictionary: (NSDictionary*) dic superview: (NSView*) view inRect: (NSRect) rect {
    self = [super init];
    if (self) {
        _objects=[[NSMutableArray array] retain];
		_sceneView=[[VZSceneView alloc] initWithFrame: ((NSEqualRects(rect, NSZeroRect)) ? [view bounds] : rect) ];
		[view addSubview: _sceneView];
		[_sceneView setObjectsToDisplay: _objects];
		if (dic) {
			int i;
			NSArray* objArray=[dic objectForKey:kObjectsArrayKey];
			int objCount=[objArray count];
			for (i=0; i<objCount; i++) {
				NSDictionary* objDescriptor=[objArray objectAtIndex:i];
				VZGameObject* obj=[[NSClassFromString([objDescriptor objectForKey:kObjectClassKey]) alloc] initWithDictionary: objDescriptor];
				[_objects addObject: obj];
			}
		}
		_worldWindow=rect;
		_absCoordinates=YES;
		[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(objectShouldRemove:) name:kVZObjectShouldDieNotification object:nil];
		
    }
    return self;
}
- (void) dealloc {
	[_sceneView removeFromSuperview];
	[_sceneView release];
	[_objects release];
	[[NSNotificationCenter defaultCenter] removeObserver: self];
    NSLog(@"VZScenecontroller dealloc");
    [super dealloc];
}

- (id)init {
	return
		[self initWithDictionary:nil superview: nil inRect:NSZeroRect];
}
-(NSDictionary*)properties {
	NSMutableDictionary* ret=[NSMutableDictionary dictionary];
	NSMutableArray* arr=[NSMutableArray array];
	int i;
	for (i=0;i<[_objects count];i++) 
		[arr addObject:[[_objects objectAtIndex:i] properties]];
	[ret setObject:arr forKey:kObjectsArrayKey];
	return ret;
}


- (VZSceneView*) view{
	return _sceneView;
}

- (NSMutableArray*) objects{
    return _objects;
}

- (void) setUsesAbsCoordinates: (BOOL) flag{
	_absCoordinates=flag;
	[[self view] setUsesAbsCoordinates: flag];
}

- (BOOL) usesAbsCoordinates{
	return _absCoordinates;
}

- (void) setWorldWindow: (NSRect) rect{
	_worldWindow=rect;
}

- (NSRect) worldWindow{
	return _worldWindow;
}

- (BOOL) isStarted {
	return _started;
}

- (void) startWithFPS: (float) fps{
	if (!_timer)
		_timer=[NSTimer scheduledTimerWithTimeInterval:1.0/fps target: self selector:@selector(timerTick) userInfo:nil repeats:YES];
	_fps=fps;
    _started=YES;
	_paused=NO;
}
#pragma mark -
- (void) objectShouldRemove: (NSNotification*) aNotification{
	//NSLog(@"VZSceneContr : obj should remove is received");
    [self removeObject: [aNotification object]];
}

- (void) addObject: (VZGameObject*) obj{
    [_objects addObject: obj];
}
- (void) removeObject: (VZGameObject*) obj{
    [_objects removeObject: obj];
}

- (void) stop{
	if (!_timer) return;
	_started=NO;
	[_timer invalidate];
	_timer=nil;
}

- (void) setPaused: (BOOL) flag {
	_paused=flag;
}

- (void) finish{
    [[NSNotificationCenter defaultCenter] postNotificationName:kVZSceneFinishedNotification object: self userInfo: [self resultDictionary]];
}

- (NSDictionary*) resultDictionary{
    return nil;
}

- (void) timerTick{
    if (!_started) return;
	if (_paused) return;
    //NSLog(@"Scene timer tik-tak");
    [_objects makeObjectsPerformSelector: @selector(move)];
    //if ([self isSceneFinished]) [self finish];
	if (_absCoordinates)
		[_sceneView display];
	else [_sceneView displayInWorldRect: _worldWindow];
    
}
@end
