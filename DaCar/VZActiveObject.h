//
//  VZActiveObject.h
//  DaCar
//
//  Created by vad on Tue Jan 06 2004.
//  Copyright (c) 2004 __MyCompanyName__. All rights reserved.
//

#import "VZGameObject.h"

#define kLayerKey @"kLayerKey"
#define kPosKey @"kPosKey"
#define kSpeedModuleKey @"kSpeedModuleKey"
#define kDirectionKey @"kDirectionKey"

@interface VZActiveObject : VZGameObject {
	float _layer;	// defines drawing order, invisible if <0
	float _direction;
	float _rotation;
	float _x,_y;			// coordinates
	//float _w,_h;			// size
	float _spx, _spy; // speed
	float _ax, _ay;	// acceleration
	float _leftM,_rightM,_topM,_botM; //allowed margines
    BOOL _active; // is responds on 'move' action
    BOOL _userControlled;
	BOOL _usesLifeTime;
	unsigned int _lifeTime;

}
-(void)setLayer:(float)layer;
-(float)layer;
-(int)compareLayers:(VZActiveObject*)obj; // layer sorting selector

-(BOOL)readyToDead; // default is NO, implement removing condition there


// temporary staff
-(void)setControlledByUser:(BOOL)flag;
-(BOOL)controlledByUser;
-(void)setLifeTime:(unsigned int)ticks;
-(unsigned int)lifeTime;
// physical properties
-(BOOL)isActive;
-(void)setActive:(BOOL)flag;
-(float)direction;
-(void)setDirection:(float)dir;
-(float)rotation;
-(void)setRotation:(float)rot;
-(NSPoint)pos;
-(void)setPos:(NSPoint)pos;
-(float)speedModule;
-(void)setSpeedModule:(float) module;
-(NSPoint)speed;				//speed vector, use module and direction instead
-(void)setSpeed:(NSPoint)spd;
-(NSPoint)acceleration;
-(void)setAcceleration:(NSPoint)accel;
-(NSRect)margines;
-(void)setMargines:(NSRect)aRect;
-(NSRect)damRect;

-(NSString*)propertyControllerClass;

@end
