//
//  ActionViewController.m
//  TranslateActionDemo
//
//  Created by Satheeshwaran on 9/19/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import "ActionViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

#define TRANSLATE_API_URL @"http://mymemory.translated.net/api/get?q=%@&langpair=%@"

@interface ActionViewController ()

@property(strong,nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *sourceText;
@property (weak, nonatomic) IBOutlet UILabel *targetText;
@property (weak, nonatomic) IBOutlet UILabel *sourceLanguage;
@property (weak, nonatomic) IBOutlet UILabel *targetLanguage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation ActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Get the item[s] we're handling from the extension context.
    
    for (NSExtensionItem *item in self.extensionContext.inputItems) {
        for (NSItemProvider *itemProvider in item.attachments) {
            if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypePlainText]) {
                [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypePlainText options:nil completionHandler:^(NSString *piggyBackData, NSError *error) {
                    if(piggyBackData) {
                        
                        NSError *jsonReadingError;
                        
                        NSLog(@"string passed: %@",piggyBackData);
                        
                        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:[piggyBackData dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&jsonReadingError];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                           
                            self.sourceText.text = [dataDict objectForKey:@"sourceText"];
                            self.targetText.text = @"Translating...";
                            self.sourceLanguage.text = [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:[dataDict objectForKey:@"sourceLanguage"]];
                            self.targetLanguage.text = [dataDict objectForKey:@"targetLanguage"];
                            [self.spinner startAnimating];
                        });


                        NSString *urlString = [NSString stringWithFormat:@"http://mymemory.translated.net/api/get?q=%@&langpair=%@|%@",[dataDict objectForKey:@"sourceText"],[dataDict objectForKey:@"sourceLanguage"],[dataDict objectForKey:@"targetLanguage"]];
                        
                        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSStringEncodingConversionAllowLossy]]];
                        
                        
                        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                            
                            NSString *translatedString = @"";
                            
                            if(!connectionError)
                            {
                                NSError *jsonReadingError;

                                NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonReadingError];
                                
                                NSLog(@"results: %@",dataDict);
                                
                                translatedString = [[[dataDict objectForKey:@"matches"] objectAtIndex:0] objectForKey:@"translation"];
                                
                            }
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                [self.spinner stopAnimating];
                                
                                self.targetText.text = translatedString;
                                
                            });
                        }];
                    }
                }];
                
            }
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancel:(id)sender {
    
    [self.extensionContext completeRequestReturningItems:nil completionHandler:nil];
}

- (IBAction)done {
    // Return any edited content to the host app.
    // This template doesn't do anything, so we just echo the passed in items.
    
    NSExtensionItem *extensionItem = [[NSExtensionItem alloc]init];
    [extensionItem setAttributedTitle:[[NSAttributedString alloc]initWithString:@"Translated String"]];
    [extensionItem setAttributedContentText:[[NSAttributedString alloc]initWithString:self.targetText.text]];
    [self.extensionContext completeRequestReturningItems:self.extensionContext.inputItems completionHandler:nil];
}

@end
