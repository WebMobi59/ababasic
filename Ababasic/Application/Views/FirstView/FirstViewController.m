//
//  FirstViewController.m
//  Ababasic
//
//  Created by Superlight on 4/17/2559 BE.
//  Copyright © 2559 BE Superlight. All rights reserved.
//

#import "FirstViewController.h"
#import "LoginViewController.h"
@interface FirstViewController ()<UIScrollViewDelegate>{
    NSUInteger pageIndex;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *firstpage;
@property (weak, nonatomic) IBOutlet UIView*secondpage;
@property (weak, nonatomic) IBOutlet UIView*thirdpage;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [_scrollView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [_scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width*3,_scrollView.frame.size.height)];
    [_firstpage setFrame:CGRectMake(0,0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
    [_secondpage setFrame:CGRectMake( _scrollView.frame.size.width,0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
    [_thirdpage setFrame:CGRectMake( _scrollView.frame.size.width*2,0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
    [_scrollView addSubview:_firstpage];
    [_scrollView addSubview:_secondpage];
    [_scrollView addSubview:_thirdpage];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    pageIndex = _scrollView.contentOffset.x / _scrollView.frame.size.width;
    _pageControl.currentPage = pageIndex;
}
- (IBAction)next_click:(id)sender {
    if (pageIndex < 2) {
        pageIndex++;
        [_scrollView setContentOffset:CGPointMake(pageIndex*_scrollView.frame.size.width,0)];
    }else if (pageIndex == 2){
        LoginViewController* loginController = [self.storyboard instantiateViewControllerWithIdentifier:@"loginController"];
        [self.navigationController pushViewController:loginController animated:YES];
    }
    
   }


@end
