// PakeClientViewController.m

#import "PakeClientViewController.h"

@implementation PakeClientViewController

- (void) JPAKEViewController: (JPAKEViewController*) vc didFinishWithMessage: (id) message
{
	UIAlertView* alert = [[[UIAlertView alloc] initWithTitle: @"Received J-PAKE Message"
		message: [message description]
			delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil] autorelease];
	[alert show];
}

- (void) JPAKEViewController: (JPAKEViewController*) vc didFailWithError: (NSError*) error
{
	UIAlertView* alert = [[[UIAlertView alloc] initWithTitle: @"Received J-PAKE Error"
		message: [error localizedDescription]
			delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil] autorelease];
	[alert show];
}

- (IBAction) test
{
	JPAKEViewController* vc = [[JPAKEViewController new] autorelease];
	if (vc != nil) {
		vc.server = [NSURL URLWithString: @"http://localhost:5000"];
		vc.delegate = self;
		[self presentModalViewController: vc animated: YES];
	}
}

@end
