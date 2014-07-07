//
//  VZSceneDocument.h
//  DaCar
//
//  Created by vad on Tue Jan 13 2004.
//  Copyright (c) 2004 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>
@class VZSceneController;
@class VZEditorInterfaceController;

@interface VZSceneDocument : NSDocument {
	VZSceneController* _container; //data container, game object container
	IBOutlet VZEditorInterfaceController* _ic;
	BOOL _edited;
	IBOutlet NSWindow* _docWindow;
}
- (BOOL)isDocumentEdited;
-(void)setEdited:(BOOL)flag;
-(void)addGameObjectOfClass:(Class)aClass;
-(void)removeGameObjectAtIndex:(int)index;
-(void)startSceneWithFps:(float)fps;
-(NSArray*)objectsList;

@end
