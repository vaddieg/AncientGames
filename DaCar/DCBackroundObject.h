//
//  DCBackroundObject.h
//  DaCar
//
//  Created by vad on Thu Dec 18 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "VZActiveObject.h"
#import <Cocoa/Cocoa.h>


@interface DCBackroundObject : VZActiveObject {
	NSImage* _bgImage;
	NSColor* _fillColor;
	BOOL alfa;
}

@end
