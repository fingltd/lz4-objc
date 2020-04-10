//
// NSData+LZ4.h
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


#import <Foundation/Foundation.h>

#import "lz4.h"
#import "lz4hc.h"

typedef NS_ENUM(NSUInteger, LZ4Compression) {
    LZ4CompressionFast       = 0,
    LZ4CompressionHigh       = LZ4HC_CLEVEL_DEFAULT,
    LZ4CompressionHighOptMin = LZ4HC_CLEVEL_OPT_MIN,
    LZ4CompressionHighMax    = LZ4HC_CLEVEL_MAX,
};

@interface NSData (lz4)

// ------------------------------------
// COMPRESSION
// ------------------------------------

/**
 * Compresses this NSData using the LZ4 algorithm.
 *
 * @param compression The compression to use (@see LZ4Compression)
 *
 * @return The compressed variant of the receiver or nil if there was an error.
 */
- (NSData * __nullable)compressLZ4:(LZ4Compression)compression;

/**
 * Compresses this NSData using the LZ4 algorithm.
 *
 * @param compression The compression to use (@see LZ4Compression)
 * @param error NSError reference where to store compression errors
 *
 * @return The compressed variant of the receiver or nil if there was an error.
 */
- (NSData * __nullable)compressLZ4:(LZ4Compression)compression error:(NSError * __nullable * __nullable)error;

// ------------------------------------
// DECOMPRESSION
// ------------------------------------

/**
 * Decompress this NSData using the LZ4 algorithm using a predefined buffer.
 *
 * @return The decompressed variant of the receiver or nil if there was an error.
 */
- (NSData * __nullable)decompressLZ4;

/**
 * Decompress this NSData using the LZ4 algorithm.
 *
 * @param size The expected size of the resulting NSData
 *
 * @return The decompressed variant of the receiver or nil if there was an error.
 */
- (NSData * __nullable)decompressLZ4:(NSUInteger)size;

/**
 * Decompress this NSData using the LZ4 algorithm.
 *
 * @param size The expected size of the resulting NSData
 * @param error NSError reference where to store decompression errors
 *
 * @return The decompressed variant of the receiver or nil if there was an error.
 */
- (NSData * __nullable)decompressLZ4:(NSUInteger)size error:(NSError * __nullable * __nullable)error;

@end