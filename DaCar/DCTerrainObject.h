//
//  DCTerrainObject.h
//  DaCar
//
//  Created by vad on Tue Jan 06 2004.
//  Copyright (c) 2004 __MyCompanyName__. All rights reserved.
//

#import "VZActiveObject.h"


@interface DCTerrainObject : VZActiveObject {
	NSImage* pat1;
	NSImage* pat2;
	NSImage* pat3;
	float _zoom;
}

-(float)zoom;
-(void)setZoom:(float)level;
-(NSPoint)zoomedPos;

@end
