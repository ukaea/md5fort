#include <stdlib.h>
#include <stdio.h>
#include <openssl/md5.h>

void c_md5_init(void** ptr)
{
    *ptr = malloc(sizeof(MD5_CTX));
    MD5_CTX* ctx = (MD5_CTX*)*ptr;
    MD5_Init(ctx);
}

void c_md5_update(void** ptr, void** data, long* len)
{
    MD5_CTX* ctx = (MD5_CTX*)*ptr;
    MD5_Update(ctx, *data, *len);
}

void c_md5_final(void** ptr, char* hash)
{
    MD5_CTX* ctx = (MD5_CTX*)*ptr;
    hash[31] = '\0';
    unsigned char digest[16];
    MD5_Final(digest, ctx);
    int i;
    for (i = 0; i < 16; ++i) {
        sprintf(&hash[i*2], "%02x", (unsigned int)digest[i]);
    }
}
