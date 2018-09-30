#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Measurement.h"
#import "Url.h"

@interface TestUtility : NSObject

+ (void)showNotification:(NSString*)name;
+ (NSString*)getFileNamed:(NSString*)name;
+ (NSDictionary*)getTests;
+ (NSArray*)getTestTypes;
+ (NSArray*)getTestsArray;
+ (NSString*)getCategoryForTest:(NSString*)testName;
+ (UIColor*)getColorForTest:(NSString*)testName;
+ (UIColor*)getColorForTest:(NSString*)testName alpha:(CGFloat)alpha;
+ (void)downloadUrls:(void (^)(NSArray *))completion;
+ (void)removeFile:(NSString*)fileName;
@end