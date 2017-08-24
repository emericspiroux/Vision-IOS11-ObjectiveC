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
					printf("Result : %s\n", result.symbology.UTF8String);
					NSString *desc = result.payloadStringValue;
					if (desc != nil) {
						printf("Payload: %s\n", [desc UTF8String]);
						return;
					}
				}
				
			}
		}
		printf("No results\n");
	}];
	
	VNImageRequestHandler *handler = [[VNImageRequestHandler alloc] initWithCGImage: [UIImage imageNamed:@"barcode3"].CGImage options:@{VNImageOptionProperties:@""}];
	NSError *error = [[NSError alloc] init];
	
	[handler performRequests:@[barcodeRequest] error:&error];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
