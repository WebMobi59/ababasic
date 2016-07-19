//
//  SetUp1ViewController.m
//  Ababasic
//
//  Created by Superlight on 4/23/2559 BE.
//  Copyright © 2559 BE Superlight. All rights reserved.
//

#import "SetUp1ViewController.h"
#import "SetUp2ViewController.h"
#import "VSDropdown.h"

@interface SetUp1ViewController ()<VSDropdownDelegate>{
    VSDropdown *_dropdown;
    VSDropdown *_languageDropdown;
    NSMutableArray *promLevels;
    NSMutableArray *languages;
}
@property (nonatomic, assign) NSUInteger promLevel;
@property (nonatomic, assign) NSUInteger langLevel;

@property (weak, nonatomic) IBOutlet UIView *SelectLevelView;
@property (weak, nonatomic) IBOutlet UITextField *languageTextField;
@property (weak, nonatomic) IBOutlet UITextField *favor_wordTextField;
@property (weak, nonatomic) IBOutlet UIButton *ListBtn;


@end

int level_int;

@implementation SetUp1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - init
- (void)initUI {
    _dropdown = [[VSDropdown alloc]initWithDelegate:self];
    [_dropdown setAdoptParentTheme:YES];
    [_dropdown setShouldSortItems:YES];
    
    _languageDropdown = [[VSDropdown alloc]initWithDelegate:self];
    [_languageDropdown setAdoptParentTheme:YES];
    [_languageDropdown setShouldSortItems:YES];
    _SelectLevelView.layer.cornerRadius = 5.0f;
}

- (void)initData {
    self.promLevel = 1;
    self.langLevel = 1;
    
    promLevels = [[NSMutableArray alloc] init];
    languages = [[NSMutableArray alloc] init];
    
    promLevels = [@[
                 [@{
                    @"promo_id" : @"1",
                    @"promo_name" : @"Independent (I)"
                    } mutableCopy],
                 [@{
                    @"promo_id" : @"2",
                    @"promo_name" : @"Gestural (G)"
                    } mutableCopy],
                 [@{
                    @"promo_id" : @"3",
                    @"promo_name" : @"Verbal (V)"
                    
                    } mutableCopy],
                 [@{
                    @"promo_id" : @"4",
                    @"promo_name" : @"Model (M)"
                    
                    } mutableCopy],
                 [@{
                    @"promo_id" : @"5",
                    @"promo_name" : @"Partial Physical (PP)"
                    
                    } mutableCopy],
                 [@{
                    @"promo_id" : @"6",
                    @"promo_name" : @"Full Physical (FP)"
                    
                    } mutableCopy]
                 ] mutableCopy];
    
    languages = [@[
                    [@{
                       @"lang_id" : @"0",
                       @"lang_name" : @"Receptive"
                       
                       } mutableCopy],
                    [@{
                       @"lang_id" : @"1",
                       @"lang_name" : @"Expressive"
                       
                       } mutableCopy]
                    ] mutableCopy];
}

- (IBAction)onClickPromoLevel1:(id)sender {
    [ self showDropDownForButton:sender adContents:[self getNameArray:promLevels] multipleSelection:NO ];
}

- (IBAction)onClickListBtn:(id)sender {
    [ self showDropDownForLanguageBtn:self.languageTextField adContents:[self getLangugeArray:languages] multipleSelection:NO ];
}

- (NSMutableArray *)getNameArray:(NSMutableArray *)arr {
    NSMutableArray *names = [[NSMutableArray alloc] init];
    for(NSMutableDictionary *dic in arr) {
        [names addObject:[@"" stringByAppendingString:[dic objectForKey:@"promo_name"]]];
    }
    return names;
}

- (NSMutableArray *) getLangugeArray:(NSMutableArray *)arr
{
    NSMutableArray *langs = [[NSMutableArray alloc] init];
    for(NSMutableDictionary *dic in arr) {
        [langs addObject:[@"" stringByAppendingString:[dic objectForKey:@"lang_name"]]];
    }
    return langs;
}

- (void)showDropDownForLanguageBtn:(UITextField *)sender adContents:(NSArray *)contents multipleSelection:(BOOL)multipleSelection {
    
    [_languageDropdown setDrodownAnimation:rand() % 3];
    
    [_languageDropdown setAllowMultipleSelection:multipleSelection];
    
    [_languageDropdown setupDropdownForView:sender];
    
    [_languageDropdown setShouldSortItems:NO];
    
    [_languageDropdown setSeparatorColor:[UIColor grayColor]];
    
    [_languageDropdown setDirection:VSDropdownDirection_Down];
    
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    [_languageDropdown setMaxDropdownHeight:height * 0.3];
    
    
    if (_languageDropdown.allowMultipleSelection) {
    
        [_languageDropdown reloadDropdownWithContents:contents andSelectedItems:[sender.text componentsSeparatedByString:@";"]];
    
    } else {
        
        if ( [sender.text isEqual: @""] ){
            
            NSArray *arraytext=[[NSArray alloc] initWithObjects:@"", nil];
            [_languageDropdown reloadDropdownWithContents:contents andSelectedItems: arraytext];
        }
        else {
            
            NSArray *arraytext=[[NSArray alloc] initWithObjects:sender.text, nil];
            [_languageDropdown reloadDropdownWithContents:contents andSelectedItems: arraytext];
        }
        
    }
    [ _languageDropdown setTextColor:[UIColor blackColor]];
    
    
}

- (void)showDropDownForButton:(UIButton *)sender adContents:(NSArray *)contents multipleSelection:(BOOL)multipleSelection {
    
    [_dropdown setDrodownAnimation:rand() % 3];
    
    [_dropdown setAllowMultipleSelection:multipleSelection];
    
    [_dropdown setupDropdownForView:sender];
    
    [_dropdown setShouldSortItems:NO];
    
    [_dropdown setSeparatorColor:[UIColor grayColor]];
    
    [_dropdown setDirection:VSDropdownDirection_Down];
    
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    [_dropdown setMaxDropdownHeight:height * 0.4];
    
    if (_dropdown.allowMultipleSelection) {
        
        [_dropdown reloadDropdownWithContents:contents andSelectedItems:[sender.titleLabel.text componentsSeparatedByString:@";"]];
        
    } else {
        
        if ( [sender.titleLabel.text isEqual: @""] ){
            
            NSArray *arraytext=[[NSArray alloc] initWithObjects:@"", nil];
            [_dropdown reloadDropdownWithContents:contents andSelectedItems: arraytext];
        }
        else {
            
            NSArray *arraytext=[[NSArray alloc] initWithObjects:sender.titleLabel.text, nil];
            [_dropdown reloadDropdownWithContents:contents andSelectedItems: arraytext];
        }
        
    }
    [ _dropdown setTextColor:[UIColor blackColor]];
    
    
}

#pragma mark - VSDropdown Delegate methods.
-(void)dropdownWillDisappear:(VSDropdown *)dropDown{

    if ( dropDown == _languageDropdown) {
        [_favor_wordTextField becomeFirstResponder];
    } else {
        [ self push_nextpag];
    }
}

- (void)dropdown:(VSDropdown *)dropDown didChangeSelectionForValue:(NSString *)str atIndex:(NSUInteger)index selected:(BOOL)selected {
    if ( dropDown == _dropdown ) {
        UIButton *btn = (UIButton *)dropDown.dropDownView;
        NSString *allSelectedItems = [dropDown.selectedItems componentsJoinedByString:@";"];
        appController.promLevel = allSelectedItems;
        [btn setTitle:allSelectedItems forState:UIControlStateNormal];
        self.promLevel = [[[promLevels objectAtIndex:index] objectForKey:@"promo_id"] intValue];
        level_int = (int)self.promLevel;
    } else {
        UITextField *btn = (UITextField *)dropDown.dropDownView;
        NSString *allSelectedItems = [dropDown.selectedItems componentsJoinedByString:@";"];
        appController.langLevel = allSelectedItems;
        [btn setText:allSelectedItems];
        self.langLevel = [[[languages objectAtIndex:index] objectForKey:@"lang_id"] intValue];
        level_int = (int)self.langLevel;
    }
}

-(void)push_nextpag{
    [CommonUtils setLanguage:[_languageTextField text]];
    [CommonUtils setFavoriteWord:[_favor_wordTextField text]];
//    [CommonUtils set]
    SetUp2ViewController *setup2=[self.storyboard instantiateViewControllerWithIdentifier:@"SetUp2ViewController"];
    
    [ self.navigationController pushViewController:setup2 animated:YES];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ( textField == _languageTextField) {
        [_favor_wordTextField becomeFirstResponder];
    } else if ( textField == _favor_wordTextField ) {
        [textField resignFirstResponder];
    }
    return YES;
}

@end
