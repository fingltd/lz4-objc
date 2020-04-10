//
//  lz4_objc_tests.m
//  lz4-objc-tests
//
//  Created by Daniele Pantaleone on 10/04/2020.
//  Copyright © 2020 Fing Ltd. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSData+lz4.h"

@interface lz4_objc_tests : XCTestCase
@property (nonatomic, strong) NSString *content;
@end

@implementation lz4_objc_tests

- (void)setUp {
    self.content =
        @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris ac lorem elementum, "
        "ultricies arcu sed, ultricies nulla. Vestibulum accumsan porttitor mi sed posuere. "
        "Vivamus non velit sed lorem ultrices dapibus. Aenean egestas pharetra hendrerit. Donec venenatis "
        "leo odio, non sodales tortor venenatis quis. Curabitur lacinia, sem sed fringilla imperdiet, ligula "
        "nunc tincidunt ligula, sed ornare libero est eu ipsum. Phasellus tristique non sem vel blandit. "
        "Curabitur quis mauris rhoncus, suscipit ipsum nec, vehicula nulla. Duis luctus consectetur felis, "
        "et feugiat velit porttitor et. Nunc vitae mollis dui, convallis aliquet dolor. Fusce sit amet elit "
        "a arcu molestie vehicula sed ut elit. Vestibulum laoreet feugiat lobortis. Curabitur consectetur "
        "tempor nulla, eu fermentum massa accumsan quis. Aenean cursus nisl turpis, sit amet consequat "
        "tortor consequat quis. Maecenas semper felis molestie, efficitur diam faucibus, condimentum eros. "
        "Suspendisse ullamcorper tellus vitae tellus consectetur, sit amet rhoncus sem congue. "
        "Pellentesque viverra nisi vitae nibh tincidunt commodo. Sed interdum mauris sed enim condimentum "
        "facilisis. Etiam pretium neque at arcu pulvinar, vitae laoreet tortor auctor. Quisque ac consectetur "
        "sapien, sagittis tempus eros. Fusce vehicula imperdiet venenatis. Donec a sem nisl. In hac habitasse "
        "platea dictumst. Cras non felis est. Vestibulum vel imperdiet tellus, ullamcorper imperdiet lorem. "
        "Mauris bibendum diam eleifend, dictum ex in, tristique est. Phasellus cursus leo sit amet quam porta, "
        "non convallis quam venenatis. Integer in urna et nisi luctus porta at quis risus. Integer tincidunt "
        "feugiat pretium. Maecenas vitae placerat lorem. Quisque magna magna, placerat vel purus tristique, "
        "dignissim dignissim ex. Suspendisse id purus nibh. Integer placerat purus est, vel efficitur eros "
        "commodo fringilla. Donec dui lorem, dapibus non odio ac, vehicula ornare leo. Nunc volutpat lectus "
        "diam, et placerat risus cursus sed. Duis interdum maximus tellus in vehicula. Pellentesque ante ligula, "
        "varius at fringilla sed, gravida ac leo. Donec viverra tristique eros et feugiat. Morbi erat lorem, "
        "commodo ornare tincidunt a, ullamcorper id enim. Fusce ultricies, enim ac sodales dapibus, felis arcu "
        "scelerisque nunc, ut congue urna lacus eu lectus. Vivamus gravida quam aliquet neque ullamcorper placerat. "
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed aliquam magna ut eros dapibus, ac laoreet "
        "eros accumsan. Quisque condimentum, mauris a sollicitudin dictum, ex ex pharetra sapien, ut euismod quam "
        "erat ac lacus. Nunc metus ante, elementum eu pulvinar a, euismod a nulla.Nullam aliquam, elit vel mattis "
        "euismod, massa ipsum aliquet lacus, in lobortis elit libero quis massa. Aenean eu ante sit amet sem "
        "eleifend laoreet ac eu lacus. Praesent porta laoreet lorem, ac venenatis nisi sollicitudin a. "
        "Pellentesque ornare velit eget iaculis consectetur. Aliquam pellentesque felis vel ligula venenatis "
        "elementum non vel dui. Donec dictum dui mollis, fermentum lectus nec, lobortis nisl. Phasellus ut "
        "accumsan massa. Duis sapien arcu, porta et sollicitudin eget, semper in mi. Integer fringilla pretium "
        "risus, in condimentum erat porta at. Nullam aliquet sodales lacus a tempor. Mauris et neque nec tellus "
        "pulvinar euismod. Vestibulum quis tincidunt libero. Phasellus interdum risus sed venenatis volutpat. "
        "Nulla neque erat, pharetra id justo sed, pretium consectetur lacus. Sed aliquam euismod pharetra.";
}

- (void)tearDown {

}

// ------------------------------------
// COMPRESSION
// ------------------------------------

- (void)testCompressionFast {
    NSError *error = nil;
    NSData *data = [self.content dataUsingEncoding:NSUTF8StringEncoding];
    NSData *compressed = [data compressLZ4:LZ4CompressionFast error:&error];
    XCTAssertLessThanOrEqual(compressed.length, data.length);
    XCTAssertNil(error);
}

- (void)testCompressionHigh {
    NSError *error = nil;
    NSData *data = [self.content dataUsingEncoding:NSUTF8StringEncoding];
    NSData *compressed = [data compressLZ4:LZ4CompressionHigh error:&error];
    XCTAssertLessThanOrEqual(compressed.length, data.length);
    XCTAssertNil(error);
}

- (void)testCompressionHighOptMin {
    NSError *error = nil;
    NSData *data = [self.content dataUsingEncoding:NSUTF8StringEncoding];
    NSData *compressed = [data compressLZ4:LZ4CompressionHighOptMin error:&error];
    XCTAssertLessThanOrEqual(compressed.length, data.length);
    XCTAssertNil(error);
}

- (void)testCompressionHighMax {
    NSError *error = nil;
    NSData *data = [self.content dataUsingEncoding:NSUTF8StringEncoding];
    NSData *compressed = [data compressLZ4:LZ4CompressionHighMax error:&error];
    XCTAssertLessThanOrEqual(compressed.length, data.length);
    XCTAssertNil(error);
}

// ------------------------------------
// DECOMPRESSION
// ------------------------------------

- (void)testDecompressionWithCompressionFast {
    NSError *error = nil;
    NSData *data = [self.content dataUsingEncoding:NSUTF8StringEncoding];
    NSData *compressed = [data compressLZ4:LZ4CompressionFast];
    NSData *decompressed = [compressed decompressLZ4:data.length error:&error];
    XCTAssertEqual(decompressed.length, data.length);
    XCTAssertEqualObjects(decompressed, data);
    XCTAssertNil(error);
}

- (void)testDecompressionWithCompressionHigh {
    NSError *error = nil;
    NSData *data = [self.content dataUsingEncoding:NSUTF8StringEncoding];
    NSData *compressed = [data compressLZ4:LZ4CompressionHigh];
    NSData *decompressed = [compressed decompressLZ4:data.length error:&error];
    XCTAssertEqual(decompressed.length, data.length);
    XCTAssertEqualObjects(decompressed, data);
    XCTAssertNil(error);
}

- (void)testDecompressionWithCompressionHighOptMin {
    NSError *error = nil;
    NSData *data = [self.content dataUsingEncoding:NSUTF8StringEncoding];
    NSData *compressed = [data compressLZ4:LZ4CompressionHighOptMin];
    NSData *decompressed = [compressed decompressLZ4:data.length error:&error];
    XCTAssertEqual(decompressed.length, data.length);
    XCTAssertEqualObjects(decompressed, data);
    XCTAssertNil(error);
}

- (void)testDecompressionWithCompressionHighMax {
    NSError *error = nil;
    NSData *data = [self.content dataUsingEncoding:NSUTF8StringEncoding];
    NSData *compressed = [data compressLZ4:LZ4CompressionHighMax];
    NSData *decompressed = [compressed decompressLZ4:data.length error:&error];
    XCTAssertEqual(decompressed.length, data.length);
    XCTAssertEqualObjects(decompressed, data);
    XCTAssertNil(error);
}

@end
