//
//  ViewController.m
//  Sample-iOS
//
// Created by Paulo Andrade on 17/10/2018.
// Copyright © 2018 Outer Corner. All rights reserved.
//

#import "ViewController.h"
#import <OpenSSL/OpenSSL.h>

@interface ViewController ()

@property (strong) NSData *keyMaterial;
@property (weak, nonatomic) IBOutlet UITextView *plainTextView;
@property (weak, nonatomic) IBOutlet UITextView *cipherTextView;

@end

@implementation ViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    // create our key
    Byte buffer[128];
    
    int rc = RAND_bytes(buffer, sizeof(buffer));
    NSAssert(rc == 1, @"RAND_bytes failed with %ld", ERR_get_error());
    
    self.keyMaterial = [NSData dataWithBytes:buffer length:sizeof(buffer)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)encrypt:(id)sender
{
    NSData *plaintext = [[self.plainTextView text] dataUsingEncoding:NSUTF8StringEncoding];
    Byte iv[128];
    int rc = RAND_bytes(iv, sizeof(iv));
    NSAssert(rc == 1, @"RAND_bytes failed with %ld", ERR_get_error());
    const Byte *key = (const Byte *)[self.keyMaterial bytes];
    
    EVP_CIPHER_CTX *ctx;
    
    /* Create and initialise the context */
    if(!(ctx = EVP_CIPHER_CTX_new())) {
        [NSException raise:NSInternalInconsistencyException format:@"Failed to create EVP Cipher context"];
        return;
    }
    
    /* Initialise the encryption operation. IMPORTANT - ensure you use a key
     * and IV size appropriate for your cipher*/
    if(1 != EVP_EncryptInit_ex(ctx, EVP_aes_128_cbc(), NULL, key, iv)) {
        [NSException raise:NSInternalInconsistencyException format:@"Failed to initialized EVP Cipher context"];
        return;
    }
    
    
    /* Provide the message to be encrypted, and obtain the encrypted output.
     * EVP_EncryptUpdate can be called multiple times if necessary
     */
    Byte *ciphertext = (Byte *)malloc([plaintext length] + 32);
    int len;
    int ciphertext_len = 0;
    if(1 != EVP_EncryptUpdate(ctx, ciphertext, &len, [plaintext bytes], (int)[plaintext length])) {
        [NSException raise:NSInternalInconsistencyException format:@"Encryption failed"];
        return;
    }
    ciphertext_len = len;
    /* Finalise the encryption. Further ciphertext bytes may be written at
     * this stage.
     */
    if(1 != EVP_EncryptFinal_ex(ctx, ciphertext + len, &len)) {
        [NSException raise:NSInternalInconsistencyException format:@"Encryption failed"];
        return;
    }
    ciphertext_len += len;
    
    /* Clean up */
    EVP_CIPHER_CTX_free(ctx);
    
    NSData *cipherText = [NSData dataWithBytes:ciphertext length:ciphertext_len];
    free(ciphertext);
    
    [self.cipherTextView setText:[cipherText description]];
}

@end
