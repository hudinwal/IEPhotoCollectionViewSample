//
//  IEPhotoCollectionView.h
//  DetailPageDemo
//
//  Created by Dinesh Kumar on 14/09/15.
//  Copyright (c) 2015 Dinesh Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IEPhotoCollectionView : UICollectionView

@property (nonatomic,strong) NSArray * photURLStrings;

@end


@interface IEPhotoCell : UICollectionViewCell

-(void)setupPhotoCellWithPhotoURLString:(NSString *)photoURLString;

@end