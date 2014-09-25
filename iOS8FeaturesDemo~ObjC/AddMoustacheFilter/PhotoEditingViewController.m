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

@interface PhotoEditingViewController () <PHContentEditingController>
@property (strong) PHContentEditingInput *input;
@property (nonatomic,weak)IBOutlet UIImageView *bgImageView;
@property (nonatomic,weak)IBOutlet UIImageView *orignialImageView;
@property (nonatomic,weak)IBOutlet UICollectionView *moustacheSelectionView;
@property (nonatomic, strong) UIImage *inputImage;
@property (nonatomic,strong)NSArray *moustachesArray;
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
    
    self.moustachesArray = @[@"m1.png",@"m2.png",@"m3.png",@"m4.png",];
    
    self.selectedMoustacheName = [self
                                  .moustachesArray objectAtIndex:0];
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
    [self markFaces:self.orignialImageView];
}

- (void)finishContentEditingWithCompletionHandler:(void (^)(PHContentEditingOutput *))completionHandler {
    // Update UI to reflect that editing has finished and output is being rendered.
    
    // Render and provide output on a background queue.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Create editing output from the editing input.
        PHContentEditingOutput *output = [[PHContentEditingOutput alloc] initWithContentEditingInput:self.input];
        
        // Provide new adjustments and render output to given location.
        // output.adjustmentData = <#new adjustment data#>;
        // NSData *renderedJPEGData = <#output JPEG#>;
        // [renderedJPEGData writeToURL:output.renderedContentURL atomically:YES];
        
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
    
    /*NSDictionary *filterInfo = self.availableFilterInfos[indexPath.item];
    NSString *displayName = filterInfo[kFilterInfoDisplayNameKey];
    NSString *previewImageName = filterInfo[kFilterInfoPreviewImageKey];
    */
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoFilterCell" forIndexPath:indexPath];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:999];
    imageView.image = [UIImage imageNamed:[self
                                           .moustachesArray objectAtIndex:indexPath.row]];
    
    UILabel *label = (UILabel *)[cell viewWithTag:998];
    label.text = [NSString stringWithFormat:@"Moustache %ld",(long)indexPath.row+1];
    
    [self updateSelectionForCell:cell];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //self.selectedFilterName = self.availableFilterInfos[indexPath.item][kFilterInfoFilterNameKey];
    //[self updateFilter];
    
    [self updateSelectionForCell:[collectionView cellForItemAtIndexPath:indexPath]];
    
    //[self updateFilterPreview];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedMoustacheName = [self
                                  .moustachesArray objectAtIndex:indexPath.row];
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

-(void)markFaces:(UIImageView *)facePicture
{
    NSLog(@"face detection started");
    // draw a ci image from view
    CIImage *image = [CIImage imageWithCGImage:facePicture.image.CGImage];
    
    
    // Create face detector with high accuracy
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil options:[NSDictionary   dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy]];
    
    
    CGAffineTransform transform = CGAffineTransformMakeScale(1, -1);
    transform = CGAffineTransformTranslate(transform,
                                           0,-facePicture.bounds.size.height);
    
    // Get features from the image
    NSArray* features = [detector featuresInImage:image];
    for(CIFaceFeature* faceFeature in features) {
        
        // Transform CoreImage coordinates to UIKit
        CGRect faceRect = CGRectApplyAffineTransform(faceFeature.bounds, transform);

        if (faceFeature.hasMouthPosition) {

        
        
        UIImage *mustache = [UIImage imageNamed:self.selectedMoustacheName];
        
        UIImageView *mustacheview = [[UIImageView alloc] initWithImage:mustache];
        
        
        mustacheview.contentMode = UIViewContentModeScaleAspectFill;
        [mustacheview.layer setBorderColor:[[UIColor whiteColor] CGColor]];
        [mustacheview.layer setBorderWidth:3];
        //[mustacheview addGestureRecognizer:pancontrol];
        //[mustacheview addGestureRecognizer:pinchcontrol];
        //[mustacheview addGestureRecognizer:rotatecontrol];
        mustacheview.userInteractionEnabled=YES;
        
        CGPoint mouthPos = CGPointApplyAffineTransform(faceFeature.mouthPosition, transform);
        
        
        [mustacheview setFrame:CGRectMake(mouthPos.x, mouthPos.y,     mustacheview.frame.size.width, mustacheview.frame.size.height)];
        [mustacheview setCenter:mouthPos];

        [self.orignialImageView addSubview:mustacheview];
        [self.orignialImageView bringSubviewToFront:mustacheview];
        
        }
        
    }
    
}


@end
