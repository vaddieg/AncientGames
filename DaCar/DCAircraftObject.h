//
//  DCAircraftObject.h
//  DaCar
//
//  Created by vad on Mon Dec 22 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "VZActiveObject.h"

@interface DCAircraftObject : VZActiveObject {
	int _shootTimeOut;
	int _bullets;
	float _fuel;
	int _hp;
	float _maxSpeed;
	VZActiveObject* _target;
	float _safeDistance;
	BOOL _kami;
	BOOL _moveOn;
	BOOL _dying;
	float _dieFrameNum;
}
-(float)maxSpeed;
-(void)setMaxSpeed:(float)spd;
-(void) attackTarget;
-(void) setTarget: (VZActiveObject*) target;
-(void) hitWithDamage:(int)dam;
-(void) startDying;
-(BOOL)dying;
-(VZActiveObject*) target;
@end
