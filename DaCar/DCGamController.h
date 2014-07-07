/* DCGamController */

#import <Cocoa/Cocoa.h>
#import "VZGameKit.h"
#import "DCBackroundObject.h"
#import "DCAircraftObject.h"

@interface DCGamController : VZGameController
{
    //IBOutlet NSView *_view;
}

- (IBAction)start:(id)sender;
- (IBAction)nextScene: (id)sender;
@end
