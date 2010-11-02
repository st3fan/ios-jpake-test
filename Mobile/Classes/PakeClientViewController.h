// PakeClientViewController.h

#import <UIKit/UIKit.h>
#import "JPAKEViewController.h"
#import "JPAKEReporter.h"

@interface PakeClientViewController : UIViewController <JPAKEViewControllerDelegate> {
  @private
	JPAKEReporter* _reporter;
}

- (IBAction) test;

@end
