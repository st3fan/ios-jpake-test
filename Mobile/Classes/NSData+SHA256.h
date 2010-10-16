// NSData+SHA256.h

#import <Foundation/Foundation.h>

@interface NSData (SHA256)

- (NSData*) SHA256Hash;
- (NSData*) HMACSHA256WithKey: (NSData*) key;

@end