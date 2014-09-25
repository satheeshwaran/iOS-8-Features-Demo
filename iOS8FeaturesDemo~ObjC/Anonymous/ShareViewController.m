//
//  ShareViewController.m
//  Anonymous
//
//  Created by Satheeshwaran on 9/23/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import "ShareViewController.h"
#import "MLIMGURUploader.h"
#import "DescriptionViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>


@interface ShareViewController ()<DescriptionDelegate>

@property (nonatomic, strong) UIImage *anonymousImageToBeUploaded;
@property (nonatomic, strong) SLComposeSheetConfigurationItem *descriptionItem;
@end

@implementation ShareViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.textView setTintColor:[UIColor redColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    [self.view setTintColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor redColor]];
    
    for (NSExtensionItem *item in self.extensionContext.inputItems) {
        for (NSItemProvider *itemProvider in item.attachments) {
            if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeImage]) {
                [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeImage options:nil completionHandler:^(UIImage *piggyBackData, NSError *error) {
                    if(piggyBackData) {
                        
                        self.anonymousImageToBeUploaded = piggyBackData;
                    }
                }];
                
            }
        }
    }
}
- (BOOL)isContentValid {
    // Do validation of contentText and/or NSExtensionContext attachments here
    
    return YES;
}

- (void)didSelectPost {
    // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
    NSString *clientID = @"30d6fb17880cb63";
    // Load the image data up in the background so we don't block the UI
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *imageData = UIImageJPEGRepresentation(self.anonymousImageToBeUploaded, 1.0f);
        
        
        [MLIMGURUploader uploadPhoto:imageData title:self.textView.text description:self.descriptionItem.value imgurClientID:clientID completionBlock:^(NSString *result) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //[self.extensionContext completeRequestReturningItems:@[result] completionHandler:nil];

                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Upload Successful" message:result preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                    
                    NSLog(@"You clicked OK");
                    
                }];
                
                UIAlertAction *copyLinkAction = [UIAlertAction actionWithTitle:@"Copy Link" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    NSLog(@"You clicked Copy Link");
                    
                    [[UIPasteboard generalPasteboard] setString:result];
                }];
                
                [alertController addAction:okAction];
                [alertController addAction:copyLinkAction];

                [self presentViewController:alertController animated:YES completion:^{
                    
                }];

                
            });
        } failureBlock:^(NSURLResponse *response, NSError *error, NSInteger status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                

                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Upload Failed" message:[NSString stringWithFormat:@"%@ (Status code %ld)", [error localizedDescription], (long)status] preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    NSLog(@"You clicked OK");
                    
                }];
                
                [alertController addAction:okAction];
                
                [self presentViewController:alertController animated:YES completion:^{
                    
                }];

            });
        }];
        
    });

    // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
}

- (NSArray *)configurationItems {
    // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
    self.descriptionItem = [[SLComposeSheetConfigurationItem alloc]init];
    self.descriptionItem.title = @"Description";
    
    __weak ShareViewController *weakSelf = self;
    self.descriptionItem.tapHandler = ^(void){
    
        DescriptionViewController *descriptionVC = [weakSelf.storyboard instantiateViewControllerWithIdentifier:@"descriptionVC"];
        descriptionVC.delegate = weakSelf;
        [weakSelf pushConfigurationViewController:descriptionVC];
    };
    
    return @[self.descriptionItem];
}

- (void)descriptionCompleted:(NSString *)text
{
    self.descriptionItem.value = text;
}
@end
