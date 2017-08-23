//
//  DFCFileToPDF.h
//  planByGodWin
//
//  Created by DaFenQi on 16/12/22.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DFCPPTToImage;

@protocol DFCPPTToImageDelegate <NSObject>

@optional
- (void)pptToImageDidSucceed:(DFCPPTToImage*)pptToImage imagePaths:(NSArray *)imagePaths;
- (void)pptToImageDidFail:(DFCPPTToImage*)pptToImage;

@end

@interface DFCPPTToImage : UIViewController

+ (instancetype)createPdfWithURL:(NSURL *)url
                        delegate:(id <DFCPPTToImageDelegate>)delegate;

@end
