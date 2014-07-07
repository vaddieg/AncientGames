//
//  VZActiveObject.m
//  DaCar
//
//  Created by vad on Tue Jan 06 2004.
//  Copyright (c) 2004 __MyCompanyName__. All rights reserved.
//

#import "VZActiveObject.h"
#import "VZInputManager.h"
#import "VZResourceManager.h"

@implementation VZActiveObject

+(void)load {
	[VZGameObject registerSubclass:self];
}
-(id) initWithDictionary: (NSDictionary*) dic{
	self=[super initWithDictionary:dic];
    if (self) {
		if (dic) {
			_layer=([dic objectForKey:kLayerKey]) ? [[dic objectForKey:kLayerKey] floatValue] : 0;
			[self setPos:NSPointFromString([dic objectForKey:kPosKey])];
			[self setSpeedModule:[[dic objectForKey:kSpeedModuleKey] floatValue]];
			[self setDirection:[[dic objectForKey:kDirectionKey] floatValue]];
		} 
		else { 
        _active=YES;
        _userControlled=NO;
		
		}
    }
    return self;
}

-(void)dealloc {
	[super dealloc];
}
-(NSString*)propertyNibName {
	return @"ActiveObjectProp";
}

-(void) setLayer: (float) layer{
    _layer=layer;
}
-(float) layer{
    return _layer;
}
-(int) compareLayers: (VZActiveObject*) obj{ 
    float res=_layer-[obj layer];
    if (res<0) return NSOrderedAscending;
    if (res>0) return NSOrderedDescending;
    return NSOrderedSame; 
}

-(BOOL) readyToDead{
    return NO;
}

-(void) setControlledByUser: (BOOL) flag{
    _userControlled=flag;
}
-(BOOL)controlledByUser {
	return _userControlled;
}

-(void) setLifeTime:(unsigned int) ticks{
	if (ticks==0) _usesLifeTime=NO;
	else
		_usesLifeTime=YES;
	_lifeTime=ticks;
}
-(unsigned int)lifeTime {
	return _lifeTime;
}
-(BOOL)isActive {
	return _active;
}

-(void)setActive:(BOOL)flag {
	_active=flag;
}


-(float) direction{
    return _direction;
}
-(NSPoint) pos{
    return NSMakePoint(_x,_y);
}

-(float) rotation{
    return _rotation;
}

-(float) speedModule{
	return sqrt(_spx*_spx+_spy*_spy);
}

-(void) setSpeedModule: (float) module{
	/*
	float k=module/[self speedModule];
	[self setSpeed: NSMakePoint(_spx*k, _spy*k)]
	*/
	[self setSpeed:[[VZResourceManager sharedManager] vectorForAngle:_direction ofSize:module]];
}

-(NSPoint) speed{
    return NSMakePoint(_spx,_spy);
}
-(NSPoint) acceleration{
    return NSMakePoint(_ax,_ay);    
}
-(NSRect) margines{
	return NSMakeRect(_leftM,_botM, _rightM-_leftM, _topM-_botM);
}
-(NSRect) damRect{
	return NSMakeRect(_x,_y,5,5);
}

-(void) setDirection: (float) dir{
	if (dir>=256) {
		//_direction=dir%256.0;
		_direction=dir-256.0;
	} else
	if (dir<0) { 
		//_direction=256+dir%256.0;
		_direction=256.0+dir;
		
	}
	else
		_direction=dir;
	float spm=[self speedModule];
	[self setSpeed: [[VZResourceManager sharedManager] vectorForAngle: _direction ofSize: spm]];
}
-(void) setPos: (NSPoint) pos{
    _x=pos.x;
    _y=pos.y;
}
-(void) setRotation: (float) rot{
    _rotation=rot;
}
-(void) setSpeed: (NSPoint) spd{
    _spx=spd.x;
    _spy=spd.y;

}
-(void) setAcceleration: (NSPoint) accel{
    _ax=accel.x;
    _ay=accel.y;
}
-(void) setMargines: (NSRect) aRect{
	_leftM =NSMinX(aRect);
	_rightM=NSMaxX(aRect);
	_topM  =NSMaxY(aRect);
	_botM  =NSMinY(aRect);
}

-(void) move{ ///temporaty impl
	if (_usesLifeTime) {
		_lifeTime--;
		if (!_lifeTime) [self die];
	}
	
	
    _x+=_spx;
    _y+=_spy;
    _spx+=_ax;
    _spy+=_ay;
	/*	if ((_x>_rightM) || (_x<_leftM)) _spx=-_spx;
	if ((_y>_topM) || (_y<_botM)) _spy=-_spy;*/
        
}
-(void) display{
	if (_layer<0) return;
	[[NSColor yellowColor] set];
    NSRectFill(NSMakeRect(_x,_y,5,5));
   // NSLog([self description]);
}
-(void) displayInWorldRect: (NSRect) rect{
	if (_layer<0) return;
	//if (!NSPointInRect(NSMakePoint(_x,_y), rect)) return;
	[[NSColor yellowColor] set];
	NSPoint outPoint=NSMakePoint(_x-NSMinX(rect),_y-NSMinY(rect));
    NSRectFill(NSMakeRect(_x-NSMinX(rect),_y-NSMinY(rect),5,5));
	//[[[VZResourceManager sharedManager] imageNamed: @"b2 copy"] compositeToPoint: outPoint operation: NSCompositeSourceOver];
}
-(NSDictionary*)properties {
	NSMutableDictionary* ret=[[super properties] mutableCopy];
	[ret setObject:[NSNumber numberWithFloat:_layer] forKey:kLayerKey];
	[ret setObject:NSStringFromPoint([self pos]) forKey:kPosKey];
	[ret setObject:[NSNumber numberWithFloat:[self speedModule]] forKey:kSpeedModuleKey];
	[ret setObject:[NSNumber numberWithFloat:[self direction]] forKey:kDirectionKey];

	return ret;
}

- (NSString*) description {
    return [[super description] stringByAppendingFormat: 
        @"\n Pos: %f, %f\n Speed: %f, %f\n Direct:%f Rotation:%f Layer: %f  ACTIVE: %d",_x,_y,_spx,_spy,_direction,_rotation,_layer, _active]; 
}

-(NSString*)propertyControllerClass {
	return @"VZObjectPropertyController";
}

@end
