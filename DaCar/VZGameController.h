//
//  VZGameController.h
//  DaCar
//
//  Created by vad on Mon Dec 15 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class VZSceneController;

@interface VZGameController : NSWindowController {
    VZSceneController* _currentScene;
    IBOutlet NSView* _view;
}
- (void) setScene: (VZSceneController*) scene;
/*
- (IBAction) startScene: (id) sender;
*/

@end
