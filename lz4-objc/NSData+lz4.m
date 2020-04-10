//
// NSData+LZ4.m
//
// Created by Daniele Pantaleone on 09/04/20
// Copyright © 2020 Fing Ltd. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following
// conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
//

#import "NSData+lz4.h"

@implementation NSData (lz4)

// ------------------------------------
// COMPRESSION
// ------------------------------------

- (NSData *)compressLZ4:(LZ4Compression)compression {
    return [self compressLZ4:compression error:nil];
}

- (NSData *)compressLZ4:(LZ4Compression)compression error:(NSError **)error {
    int res = 0;
    int size = LZ4_compressBound((int) self.length);
    char *buffer = (char *)malloc((size_t) size);
    switch (compression) {
        case LZ4CompressionFast:
            res = LZ4_compress_default(self.bytes, buffer, (int) self.length, size);
            break;
        default:
            res = LZ4_compress_HC(self.bytes, buffer, (int) self.length, size, (int)compression);
            break;
    }
    if (res < 0) {
        if (error != nil)
            *error = [NSError errorWithDomain:@"LZ4" code:res userInfo:@{NSLocalizedDescriptionKey:@"LZ4 compression failed"}];
        free(buffer);
        return nil;
    }
    return [[NSData alloc] initWithBytesNoCopy:buffer length:res freeWhenDone:YES];
}

// ------------------------------------
// DECOMPRESSION
// ------------------------------------

- (NSData *)decompressLZ4 {
    return [self decompressLZ4:4096];
}

- (NSData *)decompressLZ4:(NSUInteger)size {
    return [self decompressLZ4:size error:nil];
}

- (NSData *)decompressLZ4:(NSUInteger)size error:(NSError **)error {
    char *buffer = (char *)malloc((size_t) size);
    int res = LZ4_decompress_safe(self.bytes, buffer, (uint32_t) self.length, (uint32_t) size);
    if (res < 0) {
        if (error != nil)
            *error = [NSError errorWithDomain:@"LZ4" code:res userInfo:@{NSLocalizedDescriptionKey:@"LZ4 decompression failed"}];
        free(buffer);
        return nil;
    }
    return [[NSData alloc] initWithBytesNoCopy:buffer length:res freeWhenDone:YES];
}

@end