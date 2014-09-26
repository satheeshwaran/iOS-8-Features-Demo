//
//  PhotoEditingViewController.m
//  AddMoustacheFilter
//
//  Created by Satheeshwaran on 9/25/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import "PhotoEditingViewController.h"
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>
#import <CoreImage/CoreImage.h>
#import "Moustache.h"

@interface PhotoEditingViewController () <PHContentEditingController>
@property (strong) PHContentEditingInput *input;
@property (nonatomic,weak)IBOutlet UIImageView *bgImageView;
@property (nonatomic,weak)IBOutlet UIImageView *orignialImageView;
@property (nonatomic,weak)IBOutlet UICollectionView *moustacheSelectionView;
@property (nonatomic, strong) UIImage *inputImage;
@property (nonatomic,strong)NSArray *moustachesArray;
@property (nonatomic,strong)NSMutableArray *editsArray;
@property (nonatomic,copy)NSString *selectedMoustacheName;
@end

@implementation PhotoEditingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.moustacheSelectionView.alwaysBounceHorizontal = YES;
    self.moustacheSelectionView.allowsMultipleSelection = NO;
    self.moustacheSelectionView.allowsSelection = YES;
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    [effectView setTranslatesAutoresizingMaskIntoConstraints:NO];
    effectView.frame = self.bgImageView.frame;
    [self.view insertSubview:effectView aboveSubview:self.bgImageView];
    
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[effectView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(effectView)];
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[effectView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(effectView)];
    [self.view addConstraints:verticalConstraints];
    [self.view addConstraints:horizontalConstraints];
    
    self.moustachesArray = @[@"cat8.png",@"big84.png",@"cat8.png",@"curled1.png",@"curled2.png",@"curled3.png",@"curled4.png",@"curling.png",@"curly.png",@"curly1.png",@"curve21.png",@"curve22.png",@"curved7.png",@"curvy.png",@"cut16.png",@"double26.png",@"facial2.png",@"irregular6.png",@"leaf11.png",@"long2.png",@"male86.png",@"moustache2.png",@"moustache3.png",@"moustache4.png",@"moustache5.png",@"moustache6.png",@"moustache8.png",@"mustache2.png",@"mustache3.png",@"oval3.png",@"pixel1.png",@"pixelated.png",@"round35.png",@"round36.png",@"short1.png",@"small142.png",@"straight10.png",@"thin19.png",@"thin20.png",@"thin21.png",@"thin22.png",@"thin23.png",@"triangular16.png",@"zigzag.png",@"zigzag1.png",@"zigzag2.png"];
    
    self.selectedMoustacheName = [self
                                  .moustachesArray objectAtIndex:0];
    [self updateSelectionForCell:[self.moustacheSelectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PHContentEditingController

- (BOOL)canHandleAdjustmentData:(PHAdjustmentData *)adjustmentData {
    // Inspect the adjustmentData to determine whether your extension can work with past edits.
    // (Typically, you use its formatIdentifier and formatVersion properties to do this.)
    return NO;
}

- (void)startContentEditingWithInput:(PHContentEditingInput *)contentEditingInput placeholderImage:(UIImage *)placeholderImage {
    // Present content for editing, and keep the contentEditingInput for use when closing the edit session.
    // If you returned YES from canHandleAdjustmentData:, contentEditingInput has the original image and adjustment data.
    // If you returned NO, the contentEditingInput has past edits "baked in".
    self.input = contentEditingInput;
    
    // Load input image
    switch (self.input.mediaType) {
        case PHAssetMediaTypeImage:
            self.inputImage = self.input.displaySizeImage;
            break;
            
        default:
            break;
    }
    
    
    // Update filter and background image
    //[self updateFilter];
    //[self updateFilterPreview];
    self.bgImageView.image = placeholderImage;
    self.orignialImageView.image = placeholderImage;
    [self markFaces:self.inputImage];
}

- (void)finishContentEditingWithCompletionHandler:(void (^)(PHContentEditingOutput *))completionHandler {
    // Update UI to reflect that editing has finished and output is being rendered.
    
    // Render and provide output on a background queue.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Create editing output from the editing input.
        PHContentEditingOutput *output = [[PHContentEditingOutput alloc] initWithContentEditingInput:self.input];
        
        NSData *adjustment = [NSKeyedArchiver archivedDataWithRootObject:self.editsArray];
        output.adjustmentData = [[PHAdjustmentData alloc]initWithFormatIdentifier:@"com.satheeshwaran.ios8featuresdemo.addmoustachefileter" formatVersion:@"1.0" data:adjustment];
        NSData *renderedJPEGData = UIImageJPEGRepresentation(self.orignialImageView.image, 0.9);
        [renderedJPEGData writeToURL:output.renderedContentURL atomically:YES];
        
        // Call completion handler to commit edit to Photos.
        completionHandler(output);
        
        // Clean up temporary files, etc.
    });
}

- (BOOL)shouldShowCancelConfirmation {
    // Returns whether a confirmation to discard changes should be shown to the user on cancel.
    // (Typically, you should return YES if there are any unsaved changes.)
    return NO;
}

- (void)cancelContentEditing {
    // Clean up temporary files, etc.
    // May be called after finishContentEditingWithCompletionHandler: while you prepare output.
}


#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.moustachesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoFilterCell" forIndexPath:indexPath];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:999];
    imageView.image = [UIImage imageNamed:[self
                                           .moustachesArray objectAtIndex:indexPath.row]];
    
    UILabel *label = (UILabel *)[cell viewWithTag:998];
    label.text = [NSString stringWithFormat:@"Moustache %ld",(long)indexPath.row+1];
    
    [self updateSelectionForCell:cell];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.selectedMoustacheName = [self
                                  .moustachesArray objectAtIndex:indexPath.row];
    [self.orignialImageView setImage:self.inputImage];
    
    self.editsArray = [NSMutableArray array];
    [self markFaces:self.inputImage];
    [self updateSelectionForCell:[collectionView cellForItemAtIndexPath:indexPath]];

}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self updateSelectionForCell:[collectionView cellForItemAtIndexPath:indexPath]];

}

- (void)updateSelectionForCell:(UICollectionViewCell *)cell {
    
    BOOL isSelected = cell.selected;
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:999];
    imageView.layer.borderColor = self.view.tintColor.CGColor;
    imageView.layer.borderWidth = isSelected ? 2.0 : 0.0;
    
    UILabel *label = (UILabel *)[cell viewWithTag:998];
    label.textColor = isSelected ? self.view.tintColor : [UIColor whiteColor];
}

-(void)markFaces:(UIImage *)facePicture
{
    NSLog(@"face detection started");
    // draw a ci image from view
    CIImage *image = [CIImage imageWithCGImage:facePicture.CGImage];
    
    
    // Create face detector with high accuracy
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil options:[NSDictionary   dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy]];

    // Get features from the image
    NSArray* features = [detector featuresInImage:image];
    for(CIFaceFeature* faceFeature in features) {
        
        // Transform CoreImage coordinates to UIKit
        if (faceFeature.hasMouthPosition) {

            
        CGSize mustacheSize = CGSizeMake(faceFeature.bounds.size.width/1.5, faceFeature.bounds.size.height/5);
        CGRect mustacheRect = CGRectMake(faceFeature.mouthPosition.x - (mustacheSize.width / 2),
                                      facePicture.size.height - faceFeature.mouthPosition.y - mustacheSize.height,
                                            mustacheSize.width,mustacheSize.height);
            
        CGFloat mustacheAngle;
            
        if([faceFeature hasFaceAngle])
            {
                mustacheAngle = (faceFeature.faceAngle) * 3.14 / 180.0;
            }
        else {
                mustacheAngle = CGFLOAT_MIN;
                NSLog(@"Mustache angle not found, using \(mustacheAngle)");
            }

            [self drawMoustacheOnImage:self.orignialImageView.image withFrame:mustacheRect andAngele:mustacheAngle];
            
            Moustache *moustacheObject = [[Moustache alloc]initWithFrame:mustacheRect andAngle:mustacheAngle];
            [self.editsArray addObject:moustacheObject];
        
        }
        
    }
    
}

- (void)drawMoustacheOnImage:(UIImage *)image withFrame:(CGRect)frm andAngele:(CGFloat)angle
{
    UIGraphicsBeginImageContextWithOptions(image.size, YES, image.scale);
    [image drawAtPoint:CGPointZero];
    
    UIImage *moustacheImage = [UIImage imageNamed:self.selectedMoustacheName];
    [moustacheImage drawInRect:frm];
   
    
    UIImage *generatedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();

    [self.orignialImageView setImage:generatedImage];

}


@end
