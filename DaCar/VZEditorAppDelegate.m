//
//  VZEditorAppDelegate.m
//  DaCar
//
//  Created by vad on Mon Jan 19 2004.
//  Copyright (c) 2004 __MyCompanyName__. All rights reserved.
//

#import "VZEditorAppDelegate.h"

static NSArray* classesList = nil;

@implementation VZEditorAppDelegate

- (id)init {
	self = [super init];
	if (self) {
		NSLog(@"app del init");
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setClassesList:) name:NSBundleDidLoadNotification object:nil];
	}
	return self;
}

-(void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[super dealloc];
}
-(void)setClassesList:(NSNotification*)not {
	NSLog(@"bundl loaded notif receivd");
	classesList = [[[not userInfo] objectForKey:NSLoadedClasses] retain];
}

-(void)awakeFromNib {
	NSLog(@"app del awake");

}

@end
