//  NSData+Base64.h

#import <Foundation/Foundation.h>

@interface NSData (AlternateBaseStringEncodings)

-(id) initWithBase64EncodedString:(NSString *) string;
-(NSString *) base64Encoding;
-(NSString *) base64EncodingWithLineLength:(unsigned int) lineLength;

-(NSString *) base16Encoding; //convert to hex string

@end
