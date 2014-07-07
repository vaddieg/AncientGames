//
//  DCRadarObject.h
//  DaCar
//
//  Created by vad on Thu Dec 25 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "VZActiveObject.h"
#import <Cocoa/Cocoa.h>

typedef enum {destroyedMode, damagedMode, passiveMode, activeMode
} DCRadarOperationMode;

@interface DCRadarObject : VZActiveObject {
	NSImage* _bufImage;
	NSMutableArray* _objs;
	VZActiveObject* _centralObject;
	float _radius;
	float _zoom;
	NSArray* _visibleClasses;
}
-(id) initWithDictionary: (NSDictionary*) dic;
-(void) setObjectsToDisplay: (NSMutableArray*) arr;
-(void) displayInWorldRect: (NSRect) rect;
-(void) setCentralObject: (VZActiveObject*) objt;
@end
