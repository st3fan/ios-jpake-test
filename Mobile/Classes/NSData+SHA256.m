//  NSData+SHA256.m

#include <openssl/evp.h>

#import "NSData+SHA256.h"

@implementation NSData (SHA256)

- (NSData*) SHA256Hash
{
	NSData* result = nil;

	const EVP_MD* md = EVP_get_digestbyname("SHA256");
	if (md != NULL)
	{
		unsigned char md_value[EVP_MAX_MD_SIZE];
		unsigned int md_len;	
		EVP_MD_CTX mdctx;

		EVP_MD_CTX_init(&mdctx);
		EVP_DigestInit_ex(&mdctx, md, NULL);
		EVP_DigestUpdate(&mdctx, [self bytes], [self length]);
		EVP_DigestFinal_ex(&mdctx, md_value, &md_len);
		EVP_MD_CTX_cleanup(&mdctx);
		
		result = [NSData dataWithBytes: md_value length: md_len];
	}
	
	return result;
}

@end
