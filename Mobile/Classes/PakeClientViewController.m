// PakeClientViewController.m

#import "PakeClientViewController.h"

@implementation PakeClientViewController

- (void) JPAKEViewController: (JPAKEViewController*) vc didFinishWithMessage: (id) message
{
	[vc dismissModalViewControllerAnimated: YES];

	UIAlertView* alert = [[[UIAlertView alloc] initWithTitle: @"Received J-PAKE Message"
		message: [message description]
			delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil] autorelease];
	[alert show];
}

- (void) JPAKEViewController: (JPAKEViewController*) vc didFailWithError: (NSError*) error
{
	[vc dismissModalViewControllerAnimated: YES];

	UIAlertView* alert = [[[UIAlertView alloc] initWithTitle: @"Received J-PAKE Error"
		message: [error localizedDescription]
			delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil] autorelease];
	[alert show];
}

- (void) JPAKEViewControllerDidCancel:(JPAKEViewController *)vc
{
	[vc dismissModalViewControllerAnimated: YES];

	UIAlertView* alert = [[[UIAlertView alloc] initWithTitle: nil
		message: @"Operation was cancelled by user"
			delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil] autorelease];
	[alert show];
}

#pragma mark -

- (void) viewDidLoad
{
	_reporter = [[JPAKEReporter alloc] initWithServer: [NSURL URLWithString: @"http://173.32.34.78:5000/"]];
	[_reporter reportCode: 200 message: @"OKIEDOKIE"];
}

- (void) viewDidUnload
{
	[_reporter release];
}

#pragma mark -

- (IBAction) test
{
	JPAKEViewController* vc = [[JPAKEViewController new] autorelease];
	if (vc != nil) {
		vc.server = [NSURL URLWithString: @"http://173.32.34.78:5000/"];
		vc.delegate = self;
		vc.reporter = _reporter;
		[self presentModalViewController: vc animated: YES];
	}
}

@end
