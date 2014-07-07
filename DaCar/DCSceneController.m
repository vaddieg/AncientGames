//
//  DCSceneController.m
//  DaCar
//
//  Created by vad on Tue Dec 16 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "DCSceneController.h"
#include <math.h>
#define kCentralObjectKey @"kCentralObjectKey"

static NSTimeInterval timeMark1=0;
static int frameCount=0;

@implementation DCSceneController

int _enTO;
- (id) initWithDictionary: (NSDictionary*) dic superview: (NSView*) view inRect: (NSRect) rect  {
	self=[super initWithDictionary:  dic superview: view inRect: rect];
	[self setUsesAbsCoordinates: NO];
	if (self) {
		NSLog(@"Init scene...");
		_centralObject=nil;
		_radar=nil;
		_enTO=300;
		//tm1=[[NSDate dateWithTimeIntervalSinceReferenceDate:0] retain];
		timeMark1=[NSDate timeIntervalSinceReferenceDate];
		[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(objectShoot:) name:@"VZObjectShootNotification" object:nil];
		NSLog(@"scen initialized");
	}
	return self;
}
- (void) dealloc{
	//[_centralObject release];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[tm1 release];
	[_radar release];
}
- (void) setCentralObject: (VZActiveObject*) objt{
	if (_centralObject==objt) return;
	//[_centralObject release];
	_centralObject=objt;// retain];
	[_radar setCentralObject: objt];
	
}
- (void) setRadarObject: (DCRadarObject*) rad{
	_radar=rad;
	[_radar setCentralObject: _centralObject];
	[_radar setObjectsToDisplay: _objects];
}

- (void) enemyAdd{
	DCAircraftObject* ob=[[[DCAircraftObject alloc] init] autorelease];
	
	float ex=3000.0-random()%6000;
	float ey=3000.0-random()%6000;
	NSPoint v=NSMakePoint([_centralObject pos].x+ex ,[_centralObject pos].y+ey);
	
	/*[[VZResourceManager sharedManager] vectorForAngle: [_centralObject direction] ofSize: 800.0];
	[ob setPos: NSMakePoint([_centralObject pos].x + v.x ,[_centralObject pos].y + v.y)];*/
	[ob setPos: v];
	[ob setDirection: rand()%64];
	[ob setSpeedModule: 4+random()%11];
	//[ob setSpeed: NSMakePoint([_centralObject speed].x ,[_centralObject speed].y*1.3)];
	[ob setLayer:4];
	[ob setLifeTime: _fps*30.0];
	[ob setKind: @"EnemyAircraft"];
	[ob setTarget: _centralObject];
	//[ob setMargines: [_view bounds]
	[self addObject:ob];
}
- (void) objectShoot: (NSNotification*)not{
	//NSLog(@"contr did receive shoot request");
	VZActiveObject* ob=[[VZActiveObject new] autorelease];
	VZActiveObject* act=[not object];
	[ob setPos: NSMakePoint([act pos].x+50, [act pos].y+50)];
	[ob setLayer: [act layer]-0.1];
	[ob setDirection: [act direction]];
	[ob setSpeedModule: 20];
	[ob setLifeTime: _fps*2.0];
	[ob setKind: [NSString stringWithFormat: @"BulletBy%@",[act kind]]];
	[self addObject: ob];
}
- (void) checkCollisions{
	int i,j,k;
	k=[_objects count];
	for (i=0; i<k; i++)
		for (j=0; j<k; j++) {
			if ([[[_objects objectAtIndex:i] kind] isEqualTo:@"BulletByMyAircraft"])
				if ([[[_objects objectAtIndex:j] kind] isEqualTo:@"EnemyAircraft"])
					if(NSIntersectsRect([[_objects objectAtIndex:i] damRect],[[_objects objectAtIndex:j] damRect]) ) {
						VZActiveObject* bull=[_objects objectAtIndex:i];
						VZActiveObject* airc=[_objects objectAtIndex:j];
							NSLog(@"BOOOOM!!!");
							[bull setLifeTime:1];
							[airc hitWithDamage:1];
							
					}
			if ([[[_objects objectAtIndex:i] kind] isEqualTo:@"BulletByEnemyAircraft"])
				if ([[[_objects objectAtIndex:j] kind] isEqualTo:@"MyAircraft"])
					if(NSIntersectsRect([[_objects objectAtIndex:i] damRect],[[_objects objectAtIndex:j] damRect]) ) {
						VZActiveObject* ob1=[_objects objectAtIndex:j];
						VZActiveObject* ob2=[_objects objectAtIndex:i];
							NSLog(@"YOU HIT!!!");
							//[ob1 setLifeTime:1];
							[ob2 setLifeTime:1];
							
					}
											
	}

}
- (void) timerTick {
	if (!_started) return; 
	if (_paused) return;
	frameCount++;
	if ([NSDate timeIntervalSinceReferenceDate]-timeMark1>4.0) {
		timeMark1=[NSDate timeIntervalSinceReferenceDate];
		NSLog(@"Current FPS: %f Objects On scene: %d", frameCount/4.0, [_objects count]);
		frameCount=0;
	}
	
	
	
	if (_enTO==0) {
		NSLog(@"add enemy");
		[self enemyAdd];
		_enTO=150+rand()%200;
	} else _enTO--;
    //NSLog(@"Scene timer tik-tak");
    [_objects makeObjectsPerformSelector: @selector(move)];
	[_sceneView setObjectsToDisplay:_objects];
	//[_radar move];
	[self checkCollisions];
	[self setWorldWindow: NSMakeRect([_centralObject pos].x-220, [_centralObject pos].y-190, 640,480)];
    //if ([self isSceneFinished]) [self finish]; else 
	[_sceneView displayInWorldRect: _worldWindow];
}
@end
