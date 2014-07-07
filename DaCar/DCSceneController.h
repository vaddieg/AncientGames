//
//  DCSceneController.h
//  DaCar
//
//  Created by vad on Tue Dec 16 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "VZGameKit.h"
#import "DCAircraftObject.h"
#import "DCRadarObject.h"


@interface DCSceneController : VZSceneController {
	VZActiveObject* _centralObject;
	NSDate *tm1;
	DCRadarObject* _radar;

}

- (void) timerTick; 
- (void) setCentralObject: (VZActiveObject*) objt;
- (void) setRadarObject: (DCRadarObject*) rad;

@end
