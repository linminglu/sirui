//
//  NSString+RSA.m
//  Business
//
//  Created by 宋搏 on 2017/4/14.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "NSString+RSA.h"
#import <ObjcAssociatedObjectHelpers/ObjcAssociatedObjectHelpers.h>  //RSA

@implementation NSString (RSA)

SYNTHESIZE_ASC_OBJ(publicKey, setPublicKey);

- (SecKeyRef)getPublicKey {
    
    if (self.publicKey) {
        return (__bridge SecKeyRef)(self.publicKey);
    }
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Commons" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    //        NSLog(@"path:%@,bundle:%@",path,bundle);
//    UIImage *im = [UIImage imageNamed:@"sportarrow" inBundle:bundle compatibleWithTraitCollection:nil];
    NSString *resourcePath = [bundle pathForResource:@"key" ofType:@"sr"];
    SecCertificateRef myCertificate = nil;
    NSData *certificateData = [[NSData alloc] initWithContentsOfFile:resourcePath];
    myCertificate = SecCertificateCreateWithData(kCFAllocatorDefault, (__bridge_retained CFDataRef) certificateData);
    SecPolicyRef policy = SecPolicyCreateBasicX509();
    SecTrustRef trust;
    OSStatus status = SecTrustCreateWithCertificates(myCertificate, policy, &trust);
    SecTrustResultType trustResult;
    if (status == noErr) {
        status = SecTrustEvaluate(trust, &trustResult);
    }
    
    self.publicKey = CFBridgingRelease(SecTrustCopyPublicKey(trust));
    return (__bridge SecKeyRef)((self.publicKey));
}

- (NSString *)RSAEncode {
    SecKeyRef publicKey = [self getPublicKey];
    size_t cipherBufferSize = SecKeyGetBlockSize(publicKey);
    uint8_t *cipherBuffer = malloc(cipherBufferSize);
    uint8_t *nonce = (uint8_t *) [self UTF8String];
    SecKeyEncrypt(publicKey,
                  kSecPaddingNone,
                  nonce,
                  strlen((char *) nonce),
                  &cipherBuffer[0],
                  &cipherBufferSize);
    NSData *encryptedData = [NSData dataWithBytes:cipherBuffer length:cipherBufferSize];
    free(cipherBuffer);
    
    NSString *endodedStr = [encryptedData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    
    return endodedStr;
}

@end

