//
//  ViewController.m
//  VisionIOS11
//
//  Created by Emeric Spiroux on 23/08/2017.
//  Copyright © 2017 Nissan Organization. All rights reserved.
//

#import "ViewController.h"
#import <Vision/Vision.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	VNDetectBarcodesRequest *barcodeRequest = [[VNDetectBarcodesRequest alloc] initWithCompletionHandler:^(VNRequest * _Nonnull request, NSError * _Nullable error) {
		if (request.results != nil) {
			for (VNBarcodeObservation *result in request.results) {
				if (result != nil) {
					printf("Result : %s", result.symbology.UTF8String);
					CIQRCodeDescriptor *desc = (CIQRCodeDescriptor *)result.barcodeDescriptor;
					if (desc != nil) {
						NSString *content = [[NSString alloc] initWithData:desc.errorCorrectedPayload encoding:NSUTF8StringEncoding];
						
						printf("Payload: %s", content.UTF8String);
						printf("Error-Correction-Level: %li", desc.errorCorrectionLevel);
						printf("Symbol-Version: %li", desc.symbolVersion);
					}
				}
			}
		}
		printf("No results");
	}];
	
	VNImageRequestHandler *handler = [[VNImageRequestHandler alloc] initWithCGImage: [[UIImage alloc] initWithContentsOfFile:@"Your file bro"].CGImage options:@{VNImageOptionProperties:@""}];
	NSError *error = [[NSError alloc] init];
	
	[handler performRequests:@[barcodeRequest] error:&error];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
