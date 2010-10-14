// PakeClientViewController.m

#import "PakeClientViewController.h"
#import "JPAKEClient.h"

@implementation PakeClientViewController

@synthesize statusLabel = _statusLabel;
@synthesize passwordLabel = _passwordLabel;

- (void) viewDidLoad
{
	_client = [[JPAKEClient alloc] initWithServer: [NSURL URLWithString: @"http://localhost:5000/"] delegate: self];
	[_client start];
}

#pragma mark -

- (IBAction) cancel
{
	[_client cancel];
}

#pragma mark -

- (void) client: (JPAKEClient*) client didGenerateSecret: (NSString*) secret
{
	_passwordLabel.text = secret;
}

- (void) client: (JPAKEClient*) client didFailWithError: (NSError*) error
{
	NSLog(@"client: %@ didFailWithError: %@", client, error);
}

- (void) client: (JPAKEClient*) client didReceivePayload: (id) payload
{
	NSLog(@"client: %@ didReceivePayload: %@", client, payload);

	UIAlertView* alert = [[UIAlertView alloc] initWithTitle: @"Receive J-PAKE Message"
		message: [payload objectForKey: @"message"] delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
	[alert show];
	[alert autorelease];
}

@end
