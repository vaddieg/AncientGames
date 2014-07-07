#import "MinController.h"
#include <stdlib.h>
@implementation MinController


- (BOOL) applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return(YES); 
}

- (BOOL) windowShouldClose:(id)sender {
// closing rest of windows on quit
    NSWindow *tmp;
    [scoreWindow close];
    tmp=[self window];
    [self setWindow:minHelpWindow];
    [self close];
    [self setWindow:tmp];
    return YES;
   }
   

 
- (void) applicationDidFinishLaunching:(NSNotification *)aNotification{
//Initializing on startup
    int i;
    //NSLog(@"Init stage...");
	//[minField setNextResponder:self];
    srandom([[NSDate date] timeIntervalSince1970]);

    imgs[0] =  [NSImage imageNamed:@"0"];
    imgs[1] =  [NSImage imageNamed:@"1"];
    imgs[2] =  [NSImage imageNamed:@"2"];
    imgs[3] =  [NSImage imageNamed:@"3"];
    imgs[4] =  [NSImage imageNamed:@"4"];
    imgs[5] =  [NSImage imageNamed:@"5"];
    imgs[6] =  [NSImage imageNamed:@"6"];
    imgs[7] =  [NSImage imageNamed:@"7"];
    imgs[8] =  [NSImage imageNamed:@"8"];
    imgs[9] =  [NSImage imageNamed:@"mine"];
    imgs[10] = [NSImage imageNamed:@"flag"];
    imgs[11] = [NSImage imageNamed:@"redmine"];
    imgs[12] = [NSImage imageNamed:@"badmark"];
    imgs[13] = [NSImage imageNamed:@"smile"];
    imgs[14] = [NSImage imageNamed:@"angry"];
    imgs[15] = [NSImage imageNamed:@"cool"];
    imgs[16] = [NSImage imageNamed:@"wink"];
    imgs[17] = [NSImage imageNamed:@"sleep"];
    imgs[18] = [NSImage imageNamed:@"undecide"];
    for (i=13; i<=18; i++) {
      [imgs[i] setScalesWhenResized:YES];
      [imgs[i] setSize:NSMakeSize(24.0,24.0)];
    }  
    [minStartButton setImage:imgs[16]];
 //------------
    undecided=NO;
    gamStarted=NO;
    gamOver=NO;
    gamWin=NO;
    minTime=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(upTime) userInfo:nil repeats:YES]; 
    gameTime=0;
    amountOfMines=NORMlev;
    currentLevel=1;
    [scoreWindow initScores];
  
}

- (void) upTime {       // Timer field updater, smile animatoin
 unsigned int m,s;
    if (gamStarted) {
        gameTime++;
        sleepTime++;
        s=gameTime % 60;
        m=gameTime / 60;
        if (undecided) {[minStartButton setImage:imgs[13]]; undecided=NO; }
        [minTimeField setStringValue:[NSString stringWithFormat:@"%02d:%02d",m,s]];
//        NSLog(@"time is %d:%d",m,s);
        if ((gameTime+1)%5==0) {
           if (sleepTime>28) [minStartButton setImage:imgs[17]];
           else [minStartButton setImage:imgs[16]];
        }
        if (gameTime%5==0) [minStartButton setImage:imgs[13]]; // winking 5 sec
        if (gameTime>=3600) gameTime=0;
        if (sleepTime>=3600) sleepTime=0;
    } 

}

int countAround(int x, int y, int targ[WIDTH][HEIGHT])
{
    int n,ne,e,se,s,sw,w,nw,cnt; //available directions
      
    if (y<1) n=0; 		 	else n=targ[y-1][x]; //North
    if ((y<1)||(x==WIDTH-1)) ne=0; 	else ne=targ[y-1][x+1];//N-East
    if (x==WIDTH-1) e=0;		else e=targ[y][x+1];//East
    if ((y==HEIGHT-1)||(x==WIDTH-1)) se=0; else se=targ[y+1][x+1];//S-East
    if (y==HEIGHT-1) s=0;		else s=targ[y+1][x];//South
    if ((y==HEIGHT-1)||(x<1)) sw=0;	else sw=targ[y+1][x-1];//S-West
    if (x<1) w=0;			else w=targ[y][x-1];//West
    if ((x<1)||(y<1)) nw=0;		else nw=targ[y-1][x-1];//N-West
    
    cnt=n+ne+e+se+s+sw+w+nw;
    return (cnt);
}

- (void) setMines {	
    int i,x,y;
    for (i=0; i < amountOfMines; i++) {
      do {
       x=random()% WIDTH;
       y=random()% HEIGHT;
      }
      while (map[y][x]==1);// Already exist there?
      map[y][x]=1; 
//      NSLog(@"Mine#%d, at:,%d,%d",i,x,y);
    }
}

- (void)clearField{
    int i,j;
    for (i=0; i<HEIGHT; i++)
     for (j=0; j<WIDTH; j++) {
       [[minField cellAtRow:i column:j] setImage:nil];
       [[minField cellAtRow:i column:j] setBordered:YES];
       marks[i][j]=0; map[i][j]=0; // Filling by Zeros
     }  
}
- (void) openCellAtX:(int) x Y:(int) y
{  
   if (((x<0)||(x>WIDTH-1)||(y<0)||(y>HEIGHT-1)||(marks[y][x])>0)) return;
   if (map[y][x]) [self gameOverX:x Y:y];
   NSButtonCell *curCell=[minField cellAtRow:y column:x];
   if ([curCell isBordered]) {
      int c=countAround(x,y,map);
      [curCell setImage:imgs[c]];
      [curCell setBordered:NO];
      if (c==0) { 		 //Self-check neihbohurs recursive
         [self openCellAtX:x   Y:y+1];
         [self openCellAtX:x-1 Y:y+1];
         [self openCellAtX:x+1 Y:y+1];
         [self openCellAtX:x   Y:y-1];
         [self openCellAtX:x-1 Y:y-1];
         [self openCellAtX:x+1 Y:y-1];
         [self openCellAtX:x-1 Y:y];
         [self openCellAtX:x+1 Y:y];
      } 
   }  
}

- (void)markAtX:(int) x Y:(int) y {			//Toggling flags
    int i,j;
	//NSLog(@"Ctrl click");
    NSButtonCell *curCell=[minField cellAtRow:y column:x];
    if ([curCell isBordered]) {
      if (marks[y][x]==0) {
       marks[y][x]=1;
       [curCell setImage:imgs[10]];
      } else
      {
       marks[y][x]=0;
       [curCell setImage:nil];
      }
    }
    gamWin=YES;
    for (i=0; i<HEIGHT;i++)   // All mines are marked properly
      for (j=0; j<WIDTH; j++) if (marks[i][j]!=map[i][j]) gamWin=NO;
    if (gamWin) [self youWin];
}

- (void)trustAtX:(int) x Y:(int) y {
	//NSLog(@"Alt click");
    if ((marks[y][x]==0)&&(![[minField cellAtRow:y column:x] isBordered])&&(countAround(x,y,map)==countAround(x,y,marks))&&(countAround(x,y,map)>0)) 
    //Requied condition for trust-check: count of surrounding mines = count of surrounding flags
    {
     [self openCellAtX:x   Y:y+1]; //Opening neighbours on player's own risk
     [self openCellAtX:x-1 Y:y+1];
     [self openCellAtX:x+1 Y:y+1];
     [self openCellAtX:x   Y:y-1];
     [self openCellAtX:x-1 Y:y-1];
     [self openCellAtX:x+1 Y:y-1];
     [self openCellAtX:x-1 Y:y];
     [self openCellAtX:x+1 Y:y];
    }
    else if (countAround(x,y,map)!=countAround(x,y,marks))
    { //User hint code there (blink uncovered&non-marked cells )
        [minStartButton setImage:imgs[18]]; undecided=YES;
     /*if (([[minField cellAtRow:y+1 column:x] isBordered])&&(marks[y+1][x]==0)) {
          [[minField cellAtRow:y+1 column:x] setBordered:NO];[[minField cellAtRow:y+1 column:x] setBordered:YES];  
     }
     if (([[minField cellAtRow:y+1 column:x-1] isBordered])&&(marks[y+1][x-1]==0)) {
          [[minField cellAtRow:y+1 column:x-1] setBordered:NO];[[minField cellAtRow:y+1 column:x-1] setBordered:YES];  
     }
     if (([[minField cellAtRow:y+1 column:x+1] isBordered])&&(marks[y+1][x+1]==0)) {
          [[minField cellAtRow:y+1 column:x+1] setBordered:NO];[[minField cellAtRow:y+1 column:x+1] setBordered:YES];  
     }
     if (([[minField cellAtRow:y-1 column:x] isBordered])&&(marks[y-1][x]==0)) {
          [[minField cellAtRow:y-1 column:x] setBordered:NO];[[minField cellAtRow:y-1 column:x] setBordered:YES];  
     }
     if (([[minField cellAtRow:y-1 column:x-1] isBordered])&&(marks[y-1][x-1]==0)) {
          [[minField cellAtRow:y-1 column:x-1] setBordered:NO];[[minField cellAtRow:y-1 column:x-1] setBordered:YES];  
     }
     if (([[minField cellAtRow:y-1 column:x+1] isBordered])&&(marks[y-1][x+1]==0)) {
          [[minField cellAtRow:y-1 column:x+1] setBordered:NO];[[minField cellAtRow:y-1 column:x+1] setBordered:YES];  
     }
     if (([[minField cellAtRow:y column:x-1] isBordered])&&(marks[y][x-1]==0)) {
          [[minField cellAtRow:y column:x-1] setBordered:NO];[[minField cellAtRow:y column:x-1] setBordered:YES];  
     }
     if (([[minField cellAtRow:y column:x+1] isBordered])&&(marks[y][x+1]==0)) {
          [[minField cellAtRow:y column:x+1] setBordered:NO];[[minField cellAtRow:y column:x+1] setBordered:YES];  
     }
     */
     
    }
}


- (void) youWin{
    gamStarted=NO; gamOver=YES;
    [minStartButton setImage:imgs[15]];
    if ([scoreWindow goodCandidateTime:gameTime forLevel:currentLevel])
        [self showNameSheet]; //Show sheet for new champion of current level
}

- (void)gameOverX:(int) x Y:(int) y {// Opening all mines for looser
    int i,j;
    BOOL mineThere,flagThere;
    NSButtonCell *curCell;
    [minStartButton setImage:imgs[14]]; //Feeling Angry!!!
    
    gamOver=YES; gamStarted=NO;
    for (i=0; i<HEIGHT; i++) 
     for (j=0; j<WIDTH; j++) {
      curCell=[minField cellAtRow:i column:j];
      mineThere=map[i][j];
      flagThere=marks[i][j];
      if (mineThere!=flagThere) {
          [curCell setBordered:NO]; 			//uncover cell
          if (flagThere) [curCell setImage:imgs[12]]; // wrong-marked cell icon;
          if (mineThere) [curCell setImage:imgs[9]]; // non-marked mine icon;
      }
     }
     [[minField cellAtRow:y column:x] setImage:imgs[11]] ; 
}


- (void) showNameSheet {
    [NSApp beginSheet: nameWindow
            modalForWindow: [self window]
            modalDelegate: nil
            didEndSelector: nil
            contextInfo: nil];
    [NSApp runModalForWindow: nameWindow];    // Sheet is up here.
    [NSApp endSheet: nameWindow];
    [nameWindow orderOut: self];
}

- (IBAction)enterName:(id)sender {
  [scoreWindow addResult:gameTime:currentLevel:[nameField stringValue]];
  //Adding champion name for level in score table
  [NSApp stopModal]; //Hide sheet
  [scoreWindow showWindow:self]; //Show score table
}

- (void)flagsChanged:(NSEvent *)evt {
	
	_keyMask=[evt modifierFlags];
	//NSLog(@"Flags changed %06x",_keyMask);
	//NSLog(@"Flags Alterna %6x",NSAlternateKeyMask);
	//NSLog(@"Flags and op  %6x",NSAlternateKeyMask&_keyMask);
}
-(void)mouseDown:(NSEvent *)evt {
	//NSLog(@"mouse down");
}

-(void)rightMouseDown:(NSEvent *)evt {
	//NSLog(@"r-mouse down");
}
- (IBAction)cellCheck:(id)sender
{
    int x,y;
    unsigned int c; //Modifier Key mask
    sleepTime=0; //awake from sleeping:)
    
  if (gamStarted) {
    
    x=[minField selectedColumn];
    y=[minField selectedRow];
    //c=[[[NSApplication sharedApplication] currentEvent] modifierFlags];
	c=_keyMask;
	//NSLog(@"cell flags %06x",[[sender selectedCell] modifierFlags]);
   //NSLog(@"x,y= %d,%d",x,y);
   // NSLog(@"mine, flag,%d,%d",map[y][x],marks[y][x]);
   // NSLog(@"Bordered,%d",[[minField cellAtRow:y column:x] isBordered]);
    if ((x>=0)&&(y>=0)) {
     if (c&NSControlKeyMask) [self markAtX:x Y:y]; else	 //control-click
       if (c&NSAlternateKeyMask) [self trustAtX:x Y:y]; else 	//alt-click
          {						//click
             if ((map[y][x]==1)&&(marks[y][x]==0)) {
               [self gameOverX:x Y:y];	 		  //LOOOOSSSEEEERRR!!!!!!!!
             }
             else   [self openCellAtX:x Y:y];
          }     
     }
    } else if (!(gamOver||gamWin)) {
        [self minStart:self];
        [self cellCheck:self];
    };
}    
- (IBAction)showScore:(id)sender;
{
  [scoreWindow showWindow:self];
} 

- (IBAction)showMinHelp:(id)sender{
    NSWindow *tmp;
    tmp=[self window];
    [self setWindow:minHelpWindow];
    [self showWindow:self];
    [self setWindow:tmp];
}
  

- (IBAction)minLevel:(id)sender
{
    int i, l=1;
//Change level popup
    if ([sender class]==[NSMenuItem class]) l=[sender tag];
    else l=[levPop indexOfSelectedItem];
    [levPop selectItemAtIndex:l];
    switch (l) {
        case 0: amountOfMines=EASYlev; break;
        case 1: amountOfMines=NORMlev; break;
        case 2: amountOfMines=HARDlev; break;
        default: amountOfMines=NORMlev;
    }
    for (i=0; i<3; i++) [[levMenu itemWithTag:i] setState:(i==l)]; //re-selecting level submenu items
//[self minStart:self];
}

- (IBAction) minStart:(id)sender
{
	//[minTimeField setStringValue: @"Go!"];
	gamOver=NO; gamStarted=YES; gamWin=NO;
	_keyMask=0;
	[minStartButton setImage:imgs[13]];
	currentLevel=[levPop indexOfSelectedItem];
	//NSLog(@"Setting mines... Numb=%d",amountOfMines);
	[self clearField];
	[self setMines];
	switch (currentLevel) {
		case 0: [[self window] setTitle:@"MinesX (Easy)"]; break;
		case 1: [[self window] setTitle:@"MinesX (Normal)"]; break;
		case 2: [[self window] setTitle:@"MinesX (Hard)"]; break;
		default: [[self window] setTitle:@"MinesX (Normal)"];
	}
	gameTime=-1; sleepTime=0; //initializing timer values
	}

@end
