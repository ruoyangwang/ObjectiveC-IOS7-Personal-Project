//
//  LYQViewController.m
//  test
//
//  Created by Emily Liu on 2014-05-14.
//  Copyright (c) 2014 Emily Liu. All rights reserved.
//

#import "LYQViewController.h" 

@interface LYQViewController ()
@property (weak, nonatomic) IBOutlet UITextView *localInfoText;
- (IBAction)buttonLocalInfo:(id)sender;

@end

@implementation LYQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.localInfoText.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//set bridge(address/pointer) for future return, without this connection is lost
/*- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"showRegister"])
    {
        [[segue destinationViewController] setDelegate:self];
    }
}*/



- (IBAction)buttonLocalInfo:(id)sender {
    self.localInfoText.text = @"hello world";
    if (self.localInfoText.hidden) {
        self.localInfoText.hidden = NO;
    }
    else
    {
        self.localInfoText.hidden = YES;
    }

}


@end
