//
//  VZResourceManager.h
//  DaCar
//
//  Created by vad on Fri Dec 19 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//
#import <Cocoa/Cocoa.h>

typedef enum {VZrotateClockwise=-1, VZnoRotate=0, VZrotateAntiClockwise=1}
 VZRotationMode;

@interface VZResourceManager : NSObject {
	float sintable[360], costable[360];
	int _maxAngle;
	//NSBitmapImageRep* bgImage;
}
+(VZResourceManager*) sharedManager;
-(void) setTablesForAngle: (int) angle;
-(int) maxAngle;
-(NSImage*) imageNamed: (NSString*) name;
-(NSBitmapImageRep*) imRep;
-(NSSound*) soundNamed: (NSString*) name;

-(float) cosineForAngle: (int) index;
-(float) sineForAngle: (int) index;
-(NSPoint) vectorForAngle: (int) agle;
-(NSPoint) vectorForAngle: (int) index ofSize: (float) size;
-(float) angleOfVector: (NSPoint) vectror;
-(VZRotationMode) nearestRotationFromAngle: (float) ang1 to: (float) ang2;
@end
