// NSData+AES.h

#import <Foundation/Foundation.h>

@interface NSData (AES)

- (id) initWithAESEncryptedData: (NSData*) data key: (NSData*) key iv: (NSData*) iv;

@end
