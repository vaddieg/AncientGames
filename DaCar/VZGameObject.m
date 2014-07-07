//
//  VZGameObject.m
//  DaCar
//
//  Created by vad on Mon Dec 15 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "VZGameObject.h"



@implementation VZGameObject

static NSMutableArray* s_AllSubclasses = nil;

+(void)load {
	//NSLog(@"load base GO");
	//[self registerSubclass:self];
	//[s_AllSubclasses addObject:self];
}

+(void)registerSubclass:(Class)aClass {
	if (!s_AllSubclasses) s_AllSubclasses = [NSMutableArray new];
	[s_AllSubclasses addObject:aClass];
}

+(NSArray*)allSubclasses {
	return s_AllSubclasses;
}

+(id)instanceOfClass:(Class)aClass {

	if ([aClass isSubclassOfClass:[VZGameObject class]])
		return [[aClass new] autorelease];
	else return nil;
}

-(id) initWithDictionary:(NSDictionary*)dic {
	self=[super init];
    if (self) {
		if (dic) {
			_customKind=[[dic objectForKey:kObjectKindKey] retain];
		} 
    }
    return self;
}
-(id)init {
    return [self initWithDictionary: nil];
}

-(void)die {
	[[NSNotificationCenter defaultCenter] postNotificationName: kVZObjectShouldDieNotification object:self];
}

-(void)dealloc {
	[_customKind release];
    //NSLog(@"VZGame object dealloc");
    [super dealloc];
}

-(NSDictionary*)properties {
	return [NSDictionary dictionaryWithObject:NSStringFromClass([self class]) forKey:kObjectClassKey];
}


-(NSString*)kind{
	if (_customKind) 
		return _customKind; 
	else
		return @"GenericGameObject";
}
-(void)setKind:(NSString*)kind{
	[kind retain];
	[_customKind release];
	_customKind=kind;
}
-(void)move {
	NSLog(@"method should be overriden by subclass");
} 		
-(void)display {
	NSLog(@"method should be overriden by subclass");
}	//empty
-(void)displayInWorldRect:(NSRect)rect {
	NSLog(@"method should be overriden by subclass");
}


- (NSString*) description {
    return [[super description] stringByAppendingString:NSStringFromClass([self class])]; 
}
@end
