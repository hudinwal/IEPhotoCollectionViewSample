//
//  IEPhotoCollectionView.m
//  DetailPageDemo
//
//  Created by Dinesh Kumar on 14/09/15.
//  Copyright (c) 2015 Dinesh Kumar. All rights reserved.
//

#import "IEPhotoCollectionView.h"
#import "IECacher.h"


@interface IEPhotoCollectionView() <UICollectionViewDataSource, UICollectionViewDelegate>
@end

@implementation IEPhotoCollectionView

-(void)awakeFromNib {
    
    self.delegate = self;
    self.dataSource = self;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumInteritemSpacing:0.0f];
    [flowLayout setMinimumLineSpacing:0.0f];
    [self setPagingEnabled:YES];
    [self setCollectionViewLayout:flowLayout];
    
    [self registerClass:[IEPhotoCell class] forCellWithReuseIdentifier:@"cell_ID"];
}

//-----------------------------------------------------------------//
#pragma mark - CollectionView Data Source
//-----------------------------------------------------------------//


-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section {
    return self.photURLStrings.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IEPhotoCell * photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_ID" forIndexPath:indexPath];
    [photoCell setupPhotoCellWithPhotoURLString:self.photURLStrings[indexPath.row]];
    return photoCell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

@end

//-----------------------------------------------------------------//
#pragma mark - Photo Collection View Cell
//-----------------------------------------------------------------//

@interface IEPhotoCell()

@property (nonatomic,strong) UIActivityIndicatorView * downloadIndicatorView;
@property (nonatomic,strong) UIImageView * photoImageView;
@property (nonatomic,strong) NSURL * photoURL;

@end

@implementation IEPhotoCell

-(instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self createAndLayoutSubviews];
    }
    return self;
}

-(void)createAndLayoutSubviews {
    __weak UIView * weakContentView = self;
    
    _photoImageView = [UIImageView new];
    _photoImageView.contentMode = UIViewContentModeScaleAspectFit;
    _photoImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_photoImageView];
    NSArray * verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_photoImageView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_photoImageView)];
    NSArray * horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_photoImageView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_photoImageView)];
    [self.contentView addConstraints:verticalConstraints];
    [self.contentView addConstraints:horizontalConstraints];
    
    _downloadIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _downloadIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    _downloadIndicatorView.hidesWhenStopped = YES;
    [self.contentView addSubview:_downloadIndicatorView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_downloadIndicatorView]-(<=1)-[weakContentView]" options:NSLayoutFormatAlignAllCenterX metrics:nil views:NSDictionaryOfVariableBindings(weakContentView,_downloadIndicatorView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_downloadIndicatorView]-(<=1)-[weakContentView]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(weakContentView,_downloadIndicatorView)]];
    [self.contentView addConstraints:verticalConstraints];
    [self.contentView addConstraints:horizontalConstraints];
}

-(void)setupPhotoCellWithPhotoURLString:(NSString *)photoURLString {
    self.photoURL = [NSURL URLWithString:photoURLString];
    NSData * photoData = [IECacher cachedDataForKey:self.photoURL.lastPathComponent];
    if(photoData) {
        [self.downloadIndicatorView stopAnimating];
        UIImage * photoImage = [UIImage imageWithData:photoData];
        [self.photoImageView setImage:photoImage];
    }
    else {
        [self.photoImageView setImage:nil];
        [self.downloadIndicatorView startAnimating];
        [self startPhotoDownload];
    }
}
-(void)startPhotoDownload {
    NSURLRequest *request = [NSURLRequest requestWithURL:self.photoURL
                                             cachePolicy:NSURLRequestReloadIgnoringCacheData
                                         timeoutInterval:120];
    __weak IEPhotoCell * weakSelf = self;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * response,NSData * data, NSError * error) {
        if(error)
            return;
        [IECacher cacheData:data forKey:response.URL.lastPathComponent];
        [weakSelf.downloadIndicatorView stopAnimating];
        UIImage * photoImage = [UIImage imageWithData:data];
        [weakSelf.photoImageView setImage:photoImage];
    }];
}
@end