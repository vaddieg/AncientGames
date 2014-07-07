//
//  DCBackroundObject.m
//  DaCar
//
//  Created by vad on Thu Dec 18 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "DCBackroundObject.h"
#import "VZGameKit.h"

@implementation DCBackroundObject

+(void)load {
	[VZGameObject registerSubclass:self];
}

- (id) initWithTileImage: (NSString*) name{
	self=[super init];
	if (self) {
		_fillColor=[[NSColor colorWithPatternImage:[[VZResourceManager sharedManager] imageNamed: name]] retain];
		//_fillColor=[[NSColor blueColor]retain];
		_layer=5;
	}
	return self;
}
- (void) dealloc{
	[_fillColor release];
	[super dealloc];
}

- (void) move{
	[super move];
	//_x+=_spx;
	//_y+=_spy;
		
}
- (void) display{
	[[NSGraphicsContext currentContext] setPatternPhase: NSMakePoint(_x,_y)];
	[_fillColor  set];
	NSRectFillUsingOperation([self margines], NSCompositeSourceOver);
	[[NSGraphicsContext currentContext] setPatternPhase: NSZeroPoint];

}
- (void) displayInWorldRect: (NSRect) rect {
	//if (!NSPointInRect(NSMakePoint(_x,_y), rect)) return;
	[[NSGraphicsContext currentContext] setPatternPhase: NSMakePoint(_x-NSMinX(rect), _y-NSMinY(rect))];
	
	[_fillColor  set];
	NSRectFillUsingOperation([self margines], NSCompositeSourceOver);
	[[NSGraphicsContext currentContext] setPatternPhase: NSZeroPoint];

}

@end
