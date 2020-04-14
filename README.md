# lz4-objc


[![Build Status](https://travis-ci.org/fingltd/lz4-objc.svg?branch=master)](https://travis-ci.org/fingltd/lz4-objc)
[![GitHub issues](https://img.shields.io/github/issues/fingltd/lz4-objc.svg)](https://github.com/fingltd/lz4-objc/issues)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

**lz4-objc** is an `Objective-C` category that provides [lz4](https://github.com/lz4/lz4) compression and decompression algorithms.

## License

**lz4-objc** library is provided as open-source software using [MIT](https://opensource.org/licenses/MIT) license.

## Installation

* Copy the **lz4** directory to your project and add the `lz4.c` and `lz4hc.c` file to your target
* Copy the **lz4-objc** directory to your project and add the `NSData+lz4.m` file to your target

## Usage

#### Compression:

```objective-c
NSData *data = // some data
NSData *compressed1 = [data compressLZ4:LZ4CompressionFast]; // use LZ4_compress_default
NSData *compressed2 = [data compressLZ4:LZ4CompressionHigh]; // use LZ4_compress_HC with LZ4HC_CLEVEL_DEFAULT
NSData *compressed3 = [data compressLZ4:LZ4CompressionHighOptMin]; // use LZ4_compress_HC with LZ4HC_CLEVEL_OPT_MIN
NSData *compressed4 = [data compressLZ4:LZ4CompressionHighMax]; // use LZ4_compress_HC with LZ4HC_CLEVEL_MAX
```

#### Decompression:

```objective-c
NSData *compressed = // some compressed data
NSData *decompressed1 = [compressed decompressLZ4]; // use LZ4_decompress_safe with a predefined buffer size
NSData *decompressed2 = [compressed decompressLZ4:1024]; // use LZ4_decompress_safe with a provided buffer size
```

## Releases and changelog

* **lz4-objc 1.0.0**

    * First release