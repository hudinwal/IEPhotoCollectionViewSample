//
//  ViewController.m
//  IEPhotoCollectionViewSample
//
//  Created by Dinesh Kumar on 18/09/15.
//  Copyright © 2015 Dinesh Kumar. All rights reserved.
//

#import "ViewController.h"
#import "IEPhotoCollectionView.h"

@interface ViewController ()

@property (nonatomic,weak) IBOutlet IEPhotoCollectionView * photoCollectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.photoCollectionView.photURLStrings = @[
    @"http://photography.nationalgeographic.com/u/TvyamNb-BivtNwcoxtkc5xGBuGkIMh_nj4UJHQKuoXI2z4EAnzEmvypgDxsuwAlPXIS1U1OFn6ywK9gDpxfOJGFtQceYKQ/",
    @"http://photography.nationalgeographic.com/u/TvyamNb-BivtNwcoxtkc5xGBuGkIMh_nj4UJHQKuoX2qULS2Lj9RKhmKieAzvEQjiGlsITxuTy7k7KXfszKJE2eS3wqHYA/",
    @"http://photography.nationalgeographic.com/u/TvyamNb-BivtNwcoxtkc5xGBuGkIMh_nj4UJHQKuoX2o48fMc5zSRoqD6uDzhwgu45QZ0HzFj13-arqBHzgye1clvoggDg/",
    @"http://photography.nationalgeographic.com/u/TvyamNb-BivtNwcoxtkc5xGBuGkIMh_nj4UJHQKuoXI2xZ8bmkb8Lnxm46UOfw6qvreOk6PlkvDuTB6-48mbI6Ap-kwZfQ/",
    @"http://photography.nationalgeographic.com/u/TvyamNb-BivtNwcoxtkc5xGBuGkIMh_nj4UJHQKuoXI2zsZtUKvF5SUoJ4ocZt8JH_u6aowLnd4kre7656Z9dEr2cbKHqw/",
    @"http://photography.nationalgeographic.com/u/TvyamNb-BivtNwcoxtkc5xGBuGkIMh_nj4UJHQKuoX2qWUTBu4TqHbqPcGLfSX5liHfHp1TWldeeQXlZGynGHjseUHyL4Q/",
    @"http://photography.nationalgeographic.com/u/TvyamNb-BivtNwcoxtkc5xGBuGkIMh_nj4UJHQKuoX2rnaM2Ew3fRqT__1KZYjUdlkXX-70CnzHuty_s1LTLyfF2dneWxw/"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
