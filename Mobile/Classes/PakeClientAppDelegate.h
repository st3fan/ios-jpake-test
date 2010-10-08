//
//  PakeClientAppDelegate.h
//  PakeClient
//
//  Created by Stefan Arentz on 10-10-05.
//  Copyright 2010 Arentz Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PakeClientViewController;

@interface PakeClientAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    PakeClientViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet PakeClientViewController *viewController;

@end

