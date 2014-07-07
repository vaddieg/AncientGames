//
//  VZSceneDocument.m
//  DaCar
//
//  Created by vad on Tue Jan 13 2004.
//  Copyright (c) 2004 __MyCompanyName__. All rights reserved.
//

#import "VZSceneDocument.h"
#import "DCSceneController.h"
#import "VZGameObject.h"
#import "VZEditorInterfaceController.h"


@implementation VZSceneDocument

- (id)init
{
    self = [super init];
    if (self) {
		
        // Add your subclass-specific initialization here.
        // If an error occurs here, send a [self release] message and return nil.
    
    }
    return self;
}
-(void)dealloc {
	[_container release];
	NSLog(@"doccument dealloc");
	[super dealloc];
}

-(void)setEdited:(BOOL)flag {
	_edited = flag;
	[_docWindow setDocumentEdited:flag];
}

- (BOOL)isDocumentEdited {
	return _edited;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"EditorDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController
{
    [super windowControllerDidLoadNib:aController];
	_container=[[DCSceneController alloc] initWithDictionary: nil superview: [_ic sceneView] inRect: NSZeroRect];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

-(BOOL)writeToFile:(NSString*)fileName ofType:(NSString *)aType {
	BOOL res = [[_container properties] writeToFile:fileName atomically:YES];
	if (res) [self setEdited:NO];
	return res;
}

-(BOOL)readFromFile:(NSString*)fileName ofType:(NSString *)aType {
	NSDictionary* dic=[NSDictionary dictionaryWithContentsOfFile:fileName];
	_container=[[VZSceneController alloc] initWithDictionary:dic superview: [_ic sceneView] inRect: NSZeroRect];
	return YES;
} 

// game data container staff
-(void)addGameObjectOfClass:(Class)aClass {
	[self setEdited:YES];
	NSLog(@"DOC: add objt");
	[_container addObject:[VZGameObject instanceOfClass:aClass]];
}

-(void)removeGameObjectAtIndex:(int)index {
	[self setEdited:YES];
	[_container removeObject:[[_container objects] objectAtIndex:index]];
}
-(void)startSceneWithFps:(float)fps {
	if ([_container isStarted]) [_container stop];
	else [_container startWithFPS:fps];
}


-(NSArray*)objectsList {
	/*NSMutableArray* ret = [NSMutableArray array];
	int i;
	for (i=0; i<[[_container objects] count]; i++)
		[ret addObject: 
			[[[[_container objects] objectAtIndex:i] properties] objectForKey:kObjectClassKey]
		];
	return ret;
	*/
	return [_container objects];
}

@end
