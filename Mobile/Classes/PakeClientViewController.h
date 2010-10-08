// PakeClientViewController.h

#import <UIKit/UIKit.h>
#import "JPAKEClient.h"

@interface PakeClientViewController : UIViewController <JPAKEClientDelegate> {
  @private
	UILabel* _passwordLabel;
	UILabel* _statusLabel;
  @private
	JPAKEClient* _client;
}

@property (nonatomic,assign) IBOutlet UILabel* passwordLabel;
@property (nonatomic,assign) IBOutlet UILabel* statusLabel;

- (IBAction) cancel;

@end
