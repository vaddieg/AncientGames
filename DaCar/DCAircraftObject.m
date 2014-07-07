//
//  DCAircraftObject.m
//  DaCar
//
//  Created by vad on Mon Dec 22 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "DCAircraftObject.h"
#import "VZInputManager.h"
#import "VZResourceManager.h"
#import "constants.h"

@implementation DCAircraftObject

+(void)load {
	[VZGameObject registerSubclass:self];
}

-(id) initWithDictionary: (NSDictionary*) dic{
	self=[super initWithDictionary: dic];
	if (self) {
		_target=nil;
		_hp=6;
		_maxSpeed=10.0; //pxls per tick
		[self setDirection: NORTH_ANGLE];
		//[self setSpeedModule: 5];
	}
	return self;
}
-(float)maxSpeed {
	return _maxSpeed;
}

-(void)setMaxSpeed:(float)spd {
	_maxSpeed=spd;
	if ([self speedModule]>spd)
		[self setSpeedModule:spd];
}
-(void)setSpeedModule:(float)spd{
	if (spd>_maxSpeed) [super setSpeedModule:_maxSpeed];
	else [super setSpeedModule:spd];
}
-(void) attackTarget{
	_moveOn=YES;
}
-(void) setTarget: (VZActiveObject*) target{
	_target=target;
	_moveOn=YES;
}
-(VZActiveObject*) target{
	return _target;
}

-(void) shoot{
	//NSLog(@"airc req shoot");
	if (!_shootTimeOut) {
	[[NSNotificationCenter defaultCenter] postNotificationName: @"VZObjectShootNotification" object: self ];
	_shootTimeOut=4;
	}

}

-(BOOL)dying {
	return _dying;
}

-(void)startDying {
	_dying=YES;
	[self setLifeTime:60];
	[self setSpeedModule:1];
}
-(void)hitWithDamage:(int)dam {
	if (_dying) return;
	_hp=_hp-dam;
	if (_hp<=0) [self startDying];
}

- (NSRect) damRect{
	return NSMakeRect(_x+10,_y+10, 80, 80);
}
-(void) move{ ///temporaty impl
	if (_shootTimeOut) _shootTimeOut--;
    if (_userControlled) {
        if ([[VZInputManager sharedManager] isKeyDown: leftKey]) [self setDirection: _direction+4];
        if ([[VZInputManager sharedManager] isKeyDown: rightKey]) [self setDirection: _direction-4];
        if ([[VZInputManager sharedManager] isKeyDown: upKey]) [self setSpeedModule: [self speedModule]+1];
        if ([[VZInputManager sharedManager] isKeyDown: downKey]) [self setSpeedModule: [self speedModule]-1];
		if ([[VZInputManager sharedManager] isKeyDown: fireKey]) [self shoot];
    } else if ((_target)&&(!_dying)) {
		if ([_target dying]) 
			[self setTarget:nil];
		else {
			NSPoint v2target;
			if (_moveOn) // from self to target
				v2target=NSMakePoint([_target pos].x-_x, [_target pos].y-_y);
			else // from target to self
				v2target=NSMakePoint(_x-[_target pos].x, _y-[_target pos].y);
			int a2target=[[VZResourceManager sharedManager] angleOfVector: v2target];
			int rot2target=[[VZResourceManager sharedManager] nearestRotationFromAngle:_direction to:a2target];	
			[self setDirection: _direction+rot2target*3];
			//NSLog(@"direction %d",_direction);
			float dist2=(v2target.x*v2target.x+v2target.y*v2target.y);
			if ((dist2 < 300*300)&&_moveOn) [self shoot];
			if (dist2 > 400*400) _moveOn=YES;
			if (dist2 < 150*150) _moveOn=NO;
		}
	}
	[super move];	
       
}

-(void) displayInWorldRect: (NSRect) rect{
	//NSLog([self description]);
	//if (!NSPointInRect(NSMakePoint(_x,_y), rect)) return;
	//[[NSColor yellowColor] set];
	NSPoint outPoint=NSMakePoint(_x-NSMinX(rect),_y-NSMinY(rect));
    //NSRectFill(NSMakeRect(_x-NSMinX(rect),_y-NSMinY(rect),10,10));
	if (_dying) {
		if (_dieFrameNum > 60) return; 
		[[[VZResourceManager sharedManager] imageNamed: @"blow100x100row"] compositeToPoint: outPoint fromRect: NSMakeRect(0, 100*(int)_dieFrameNum, 100,100) operation: NSCompositeSourceOver];
		_dieFrameNum+=0.7;
	}
	else {
		int spriteN=(_direction/4>=16)? _direction/4-16 : 48+_direction/4; 
		[[[VZResourceManager sharedManager] imageNamed: @"b2Row"] compositeToPoint: outPoint fromRect: NSMakeRect(0, spriteN*100, 100,100) operation: NSCompositeSourceOver];
	}
}


@end
