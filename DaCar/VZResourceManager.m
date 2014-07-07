//
//  VZResourceManager.m
//  DaCar
//
//  Created by vad on Fri Dec 19 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "VZResourceManager.h"

static VZResourceManager* _instance=nil;

@implementation VZResourceManager
+(VZResourceManager*) sharedManager{
	if (!_instance) {
			_instance=[self new];
			[_instance setTablesForAngle: 256];
		
		
		}
	return _instance;
}
-(void) setTablesForAngle: (int) angle{
	int i;
	float t;
	
	//bgImage=[[[NSImage imageNamed: @"6"] TIFFRepresentation] retain];

	_maxAngle=angle;
	for (i=0; i<angle; i++) {
        t=i*(2*pi/angle);
        sintable[i]=sin(t);
		//NSLog(@"sin at%d = %f",i,sintable[i]);
        costable[i]=cos(t);
		//NSLog(@"cos at%d = %f",i,costable[i]);
	}
}
-(int) maxAngle{
	return _maxAngle;
}

-(NSImage*) imageNamed: (NSString*) name{
	return [NSImage imageNamed:name];
}
/*-(NSBitmapImageRep*) imRep{
	return bgImage;
}*/

-(NSSound*) soundNamed: (NSString*) name{
	return [NSSound soundNamed:name];
}
-(float) cosineForAngle: (int) index{
	int ind;
	if (index<0) ind+=_maxAngle; else
    if (index>=_maxAngle) ind=index%_maxAngle;
	else ind=index;
	return costable[ind];
}
-(float) sineForAngle: (int) index{
	int ind;
	if (index<0) ind+=_maxAngle; else
    if (index>=_maxAngle) ind=index%_maxAngle;
	else ind=index;
	return sintable[ind];
}

-(NSPoint) vectorForAngle: (int) index{
	int ind;
	if (index<0) ind+=_maxAngle; else
    if (index>=_maxAngle) ind=index%_maxAngle;
	else ind=index;
    return NSMakePoint(costable[ind],sintable[ind]);
}
- (NSPoint) vectorForAngle: (int) index ofSize: (float) size{
	int ind;
	if (index<0) ind+=_maxAngle; else
    if (index>=_maxAngle) ind=index%_maxAngle;
	else ind=index;
	//NSLog(@"vector requested %f, %f", costable[index], sintable[index]);
	return NSMakePoint(costable[ind]*size,sintable[ind]*size);
}
-(float)angleOfVector:(NSPoint)v{
	
    if ((v.x == 0.0) && (v.y == 0.0))
        return -1;
    if (v.x == 0.0)
        return ((v.y > 0.0) ? _maxAngle/4 : 3*_maxAngle/4);
    float theta = atan(v.y/v.x);                  
    theta *= _maxAngle / (2 * pi);           
    if (v.x > 0.0)                                 
        return ((v.y >= 0.0) ? theta : _maxAngle + theta);
    else                                       
        return _maxAngle/2.0 + theta;

}
-(float) convertedAngle: (float) angle {		//temp imp
	if (angle<0) return angle+_maxAngle; else
    if (angle>=_maxAngle) return angle-_maxAngle;
	else return angle; 
}
-(VZRotationMode) nearestRotationFromAngle: (float) ang1 to: (float) ang2{
	if (ang1==ang2) return VZnoRotate;
	else if ([self convertedAngle:(ang2-ang1)]>[self convertedAngle:(ang1-ang2)]) return  VZrotateClockwise;
	return VZrotateAntiClockwise;
}
@end
