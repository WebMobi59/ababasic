//
//  SetUp2ViewController.m
//  Ababasic
//
//  Created by Superlight on 4/23/2559 BE.
//  Copyright © 2559 BE Superlight. All rights reserved.
//

#import "SetUp2ViewController.h"
#import "AddImageViewController.h"
#import "VSDropdown.h"


@interface SetUp2ViewController ()<VSDropdownDelegate>{
    VSDropdown *_dropdown;
    NSMutableArray *trialNumbers;
}

@property (nonatomic, assign) NSUInteger trialNumber;
@property (weak, nonatomic) IBOutlet UITextField *promLevel;

//@property (weak, nonatomic) IBOutlet UILabel *promLevel;
@property (weak, nonatomic) IBOutlet UIButton *SelectTrialsBtn;
@property (weak, nonatomic) IBOutlet UIView *SelectTrialsView;
@property (weak, nonatomic) IBOutlet UILabel *LanguageLabel;
@property (weak, nonatomic) IBOutlet UILabel *FavoriteWordLabel;

@end

int trial_int;

NSString *language, *favor_word;

@implementation SetUp2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _promLevel.text = appController.promLevel;
    [self initUI];
    [self initData];
    
    language = [CommonUtils getLanguage];
    favor_word = [CommonUtils getFavoriteWord];
    
    if (language == nil) language = @"My Custom Language";
    [CommonUtils setLanguage:language];
    if (favor_word == nil) favor_word = @"My Favorite Word";
    [CommonUtils setFavoriteWord:favor_word];
    
    [_LanguageLabel setText:[[_LanguageLabel text] stringByAppendingString:language]];
    [_FavoriteWordLabel setText:[[_FavoriteWordLabel text] stringByAppendingString:favor_word]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init
- (void)initUI {
    _dropdown = [[VSDropdown alloc]initWithDelegate:self];
    [_dropdown setAdoptParentTheme:YES];
    [_dropdown setShouldSortItems:YES];
    _SelectTrialsView.layer.cornerRadius = 5.0f;
}

- (void)initData {
    self.trialNumber = 1;
    trialNumbers = [[NSMutableArray alloc] init];
    
    trialNumbers = [@[
                    [@{
                       @"trial_id" : @"1",
                       @"trial_name" : @"1"
                       } mutableCopy],
                    [@{
                       @"trial_id" : @"2",
                       @"trial_name" : @"2"
                       } mutableCopy],
                    [@{
                       @"trial_id" : @"3",
                       @"trial_name" : @"3"
                       
                       } mutableCopy],
                    [@{
                       @"trial_id" : @"4",
                       @"trial_name" : @"4"
                       
                       } mutableCopy],
                    [@{
                       @"trial_id" : @"5",
                       @"trial_name" : @"5"
                       
                       } mutableCopy],
                    [@{
                       @"trial_id" : @"6",
                       @"trial_name" : @"6"
                       
                       } mutableCopy],
                    [@{
                       @"trial_id" : @"7",
                       @"trial_name" : @"7"
                       
                       } mutableCopy],
                    [@{
                       @"trial_id" : @"8",
                       @"trial_name" : @"8"
                       
                       } mutableCopy],
                    [@{
                       @"trial_id" : @"9",
                       @"trial_name" : @"9"
                       
                       } mutableCopy],
                    [@{
                       @"trial_id" : @"10",
                       @"trial_name" : @"10"
                       
                       } mutableCopy]
                    ] mutableCopy];
}

- (IBAction)onClickPromoLevel1:(id)sender {
    [ self showDropDownForButton:sender adContents:[self getNameArray:trialNumbers] multipleSelection:NO ];
}

- (NSMutableArray *)getNameArray:(NSMutableArray *)arr {
    NSMutableArray *names = [[NSMutableArray alloc] init];
    for(NSMutableDictionary *dic in arr) {
        [names addObject:[@"" stringByAppendingString:[dic objectForKey:@"trial_name"]]];
    }
    return names;
}

- (void)showDropDownForButton:(UIButton *)sender adContents:(NSArray *)contents multipleSelection:(BOOL)multipleSelection {
    
    [_dropdown setDrodownAnimation:rand() % 3];
    
    [_dropdown setAllowMultipleSelection:multipleSelection];
    
    [_dropdown setupDropdownForView:sender];
    
    [_dropdown setShouldSortItems:NO];
    
    [_dropdown setSeparatorColor:[UIColor grayColor]];
    
    [_dropdown setDirection:VSDropdownDirection_Down];
    
    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation))
    {
        [_dropdown setMaxDropdownHeight:250];
    } else {
        [_dropdown setMaxDropdownHeight:100];
    }
      
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
    
    [ self push_nextpag];
    
}

- (void)dropdown:(VSDropdown *)dropDown didChangeSelectionForValue:(NSString *)str atIndex:(NSUInteger)index selected:(BOOL)selected {
    UIButton *btn = (UIButton *)dropDown.dropDownView;
    NSString *allSelectedItems = [dropDown.selectedItems componentsJoinedByString:@";"];
    appController.trialCount =[allSelectedItems intValue];
    [btn setTitle:allSelectedItems forState:UIControlStateNormal];
    self.trialNumber = [[[trialNumbers objectAtIndex:index] objectForKey:@"trial_id"] intValue];
    trial_int = (int)self.trialNumber;
    
    [CommonUtils setTrialsCount:trial_int];
    [CommonUtils setLevel:self.promLevel.text];
//    int trialCount = [CommonUtils getTrialsCount];
}

-(void)push_nextpag{
    AddImageViewController *addImage=[self.storyboard instantiateViewControllerWithIdentifier:@"AddImageViewController"];
    
    [ self.navigationController pushViewController:addImage animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ( textField == _promLevel ) {
        [textField resignFirstResponder];
    }
    
    return YES;
}

@end
