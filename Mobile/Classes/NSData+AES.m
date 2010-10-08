// NSData+AES.m

#import <CommonCrypto/CommonCryptor.h>
#import "NSData+AES.h"

@implementation NSData (AES)

- (id) initWithAESEncryptedData: (NSData*) encryptedData key: (NSData*) key iv: (NSData*) iv
{
	NSData* result = nil;

	size_t bufferSize = [encryptedData length];

	void *buffer = calloc(bufferSize, sizeof(uint8_t));
	if (buffer != nil)
	{
		size_t dataOutMoved = 0;

		CCCryptorStatus cryptStatus = CCCrypt(
			kCCDecrypt,
			kCCAlgorithmAES128,
			kCCOptionPKCS7Padding,
			[key bytes],
			kCCKeySizeAES256,
			[iv bytes],
			[encryptedData bytes],
			[encryptedData length],
			buffer,
			bufferSize,
			&dataOutMoved
		);
		
		if (cryptStatus == kCCSuccess) {
			result = [[NSData alloc] initWithBytesNoCopy: buffer length: dataOutMoved];
		}
	}
	
	return result;
}

@end