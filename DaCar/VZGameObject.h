//
//  VZGameObject.h
//  DaCar
//
//  Created by vad on Mon Dec 15 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define kVZObjectShouldDieNotification	@"kVZObjectShouldDieNotification"
#define kObjectClassKey	@"kObjectClassKey"
#define kObjectKindKey	@"kObjectKindKey"


@interface VZGameObject : NSObject {
	NSString* _customKind;
	
}	//generic properties

+(void)registerSubclass:(Class)aClass;
+(NSArray*)allSubclasses;
-(id)initWithDictionary:(NSDictionary*)properties;
-(id)init;
+(id)instanceOfClass:(Class)aClass;
-(NSDictionary*)properties;
-(NSString*)description;


-(NSString*)kind;
-(void)setKind:(NSString*)kind;

-(void)die;
-(void) move;		
-(void) display;	//empty
-(void) displayInWorldRect: (NSRect) rect;



@end
