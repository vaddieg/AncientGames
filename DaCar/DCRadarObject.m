//
//  DCRadarObject.m
//  DaCar
//
//  Created by vad on Thu Dec 25 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "DCRadarObject.h"
#import "DCAircraftObject.h"
#import "VZResourceManager.h"


@implementation DCRadarObject

NSRect bufRect;

+(void)load {
	[VZGameObject registerSubclass:self];
}

-(id) initWithDictionary: (NSDictionary*) dic{
	self=[super initWithDictionary: dic];
	if (self) {
		[self setKind: @"RadarObject"];
		[self setLayer: 99];
		_bufImage=[[NSImage alloc] initWithSize:NSMakeSize(70,70)];
		bufRect=NSMakeRect(0,0,70,70);
	}
	return self;
}
-(void) dealloc{
	[_bufImage release];
	[super dealloc];
}
-(void) move{
	int i;
	[_bufImage lockFocus];
	[[NSColor blackColor] set];
	NSRectFill(bufRect);
	NSPoint cp=[_centralObject pos];
	[[NSColor greenColor] set];
	NSRectFill(NSMakeRect(34,34,3,3));
	[[NSColor redColor] set];
	for (i=0; i<[_objs count]; i++) {
		VZActiveObject* targ=[_objs objectAtIndex: i];
		if ([[targ kind] isEqualTo:@"EnemyAircraft"]) {
			NSPoint targetP=NSMakePoint(([targ pos].x-cp.x)/100.0+35, ([targ pos].y-cp.y)/100.0+35);
			NSRectFill(NSMakeRect(targetP.x,targetP.y,2,2));
		}
	}
	DCAircraftObject* mainTarg=[_centralObject target];
	[[NSColor blueColor] set];
	if (mainTarg) {
		NSPoint targetP=NSMakePoint(([mainTarg pos].x-cp.x)/100.0+35, ([mainTarg pos].y-cp.y)/100.0+35);
		if (NSPointInRect(targetP,bufRect))
			NSRectFill(NSMakeRect(targetP.x,targetP.y,3,3));
		else {
			
			if (targetP.x>NSMaxX(bufRect)-3) targetP.x=NSMaxX(bufRect)-3;
			if (targetP.x<NSMinX(bufRect)) targetP.x=NSMinX(bufRect);
			
			if (targetP.y>NSMaxY(bufRect)-3) targetP.y=NSMaxY(bufRect)-3;
			if (targetP.y<NSMinY(bufRect)) targetP.y=NSMinY(bufRect);
			NSRectFill(NSMakeRect(targetP.x,targetP.y,3,3));
		}
	}
	[_bufImage unlockFocus];
	
}
-(void) setObjectsToDisplay: (NSMutableArray*) arr{
	_objs=arr;
}
-(void) setCentralObject: (VZActiveObject*) objt{
	_centralObject=objt;
}
-(void) displayInWorldRect: (NSRect) rect{
	[_bufImage compositeToPoint: NSZeroPoint operation: NSCompositeSourceOver fraction: 0.5];
}
/*-(NSString*) kind{
	return @"RadarObject";
} 
*/
@end
