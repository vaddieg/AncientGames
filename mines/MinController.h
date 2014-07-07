/* MinController */

#import <Cocoa/Cocoa.h>
#import "ScoreWindowController.h"

#define WIDTH 16
#define HEIGHT 16
#define EASYlev 15
#define NORMlev 25
#define HARDlev 40

@interface MinController : NSWindowController
{
    IBOutlet NSMatrix *minField;			//Game map
    IBOutlet NSTextField *minTimeField;			//Timer text field
    IBOutlet NSPopUpButton *levPop;	
    IBOutlet NSMenu *levMenu;
    IBOutlet NSButton *minStartButton;
    IBOutlet ScoreWindowController *scoreWindow;
    
    IBOutlet NSTextField *nameField;
    IBOutlet NSWindow *nameWindow;
    IBOutlet NSWindow *minHelpWindow;
    
    @private
    NSImage *imgs[19]; //icon storage
    NSTimer *minTime;
    BOOL gamOver,gamStarted,gamWin;
    int gameTime,sleepTime;
    int amountOfMines, currentLevel;	// Mines munber
    int map[WIDTH][HEIGHT];
    int marks[WIDTH][HEIGHT]; //Mine map, Flags Map
    BOOL undecided;
	unsigned int _keyMask;
    
}

- (void) openCellAtX:(int) x Y:(int) y;  //click
- (void) markAtX:(int) x Y:(int) y;	 //control-click
- (void) trustAtX:(int) x Y:(int) y;	 //option-click
- (void)clearField;			 
- (void) setMines;			//random mines generation
int countAround(int x, int y, int targ[WIDTH][HEIGHT]); //count of items in surrounding cells
- (void) upTime; //Timer update

- (void)gameOverX:(int) x Y:(int) y;
- (void) youWin;
- (void) showNameSheet; 

- (IBAction)cellCheck:(id)sender; //clicking cells
- (IBAction)minLevel:(id)sender;  //changing game level
- (IBAction)minStart:(id)sender;  //starting game

- (IBAction)showScore:(id)sender;    //show scores
- (IBAction)showMinHelp:(id)sender;  //show help
- (IBAction)enterName:(id)sender;    //close input Name sheet

@end
