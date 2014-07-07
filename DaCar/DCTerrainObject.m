//
//  DCTerrainObject.m
//  DaCar
//
//  Created by vad on Tue Jan 06 2004.
//  Copyright (c) 2004 __MyCompanyName__. All rights reserved.
//

#import "DCTerrainObject.h"

NSImage* buff;

@implementation DCTerrainObject

+(void)load {
	[VZGameObject registerSubclass:self];
}


-(id)initWithDictionary:(NSDictionary*)dic {
	self=[super initWithDictionary: dic];
	if (self) {
		_x=1000; _y=1000;
		_zoom=0.3;	//terrain motion should be visually slower depenly on height of viewpoint
		pat1=[NSImage imageNamed:@"water"];
		pat2=[NSImage imageNamed:@"grass"];
		pat3=[NSImage imageNamed:@"forest"];
		buff=[[NSImage alloc] initWithSize:NSMakeSize(3000,1600)];
		[buff setMatchesOnMultipleResolution:NO];
		[buff setPrefersColorMatch:NO];
		[buff setCacheMode:NSImageCacheAlways];
		[buff lockFocus];
		int i,j;
		srand(time(0));
		for (i=0; i<187; i++)
			for (j=0; j<100; j++) {
				int r=rand()%3;
				if (r==2) [pat1 compositeToPoint:NSMakePoint(i*16,j*16) operation:NSCompositeCopy];
				else 
				if (r==1) [pat2 compositeToPoint:NSMakePoint(i*16,j*16) operation:NSCompositeCopy];
				else
				 [pat3 compositeToPoint:NSMakePoint(i*16,j*16) operation:NSCompositeCopy];
			}
		[buff unlockFocus];
		[self setLayer: 0];
		
		
	}
	return self;
}
-(void)dealloc {
	[pat1 release];
	[pat2 release];
	[pat3 release];
	[buff release];
}
-(float)zoom {
	return _zoom;
}
-(void)setZoom:(float)level {
	_zoom=level;
}


-(NSPoint)zoomedPos{
	return NSMakePoint(_x*_zoom,_y*_zoom);
}

-(void)displayInWorldRect:(NSRect)rect {
	
	NSRect zoomedRect=NSMakeRect(rect.origin.x*_zoom,rect.origin.y*_zoom,rect.size.width,rect.size.height);
	zoomedRect=NSOffsetRect(zoomedRect,-_x*_zoom,-_y*_zoom);
	[buff compositeToPoint:NSZeroPoint fromRect:zoomedRect operation:NSCompositeCopy];
	
}

@end
