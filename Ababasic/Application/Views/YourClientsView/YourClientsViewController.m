//
//  YourClientsViewController.m
//  Ababasic
//
//  Created by Superlight on 5/10/2559 BE.
//  Copyright © 2559 BE Superlight. All rights reserved.
//

#import "YourClientsViewController.h"
#import "ClientsTableViewCell.h"
#import "TrialHistoryViewController.h"

@interface YourClientsViewController ()<UITableViewDelegate,UITableViewDataSource  >
@property (weak, nonatomic) IBOutlet UITableView *clientsTable;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

NSMutableArray *nameArray, *diagnosisArray, *companyArray, *photoArray;
NSMutableArray *clientInfos;

@implementation YourClientsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataFromServer];
    nameArray=[[NSMutableArray alloc]initWithObjects:@"JOHN D.",@"Katelyn G.",@"Kieren G.",@"Adrian K.",@"Jonas H.",@"Mediras P.", nil];
    diagnosisArray=[[NSMutableArray alloc]initWithObjects:@"Diagnosis: AUT",@"No diagnosis",@"No diagnosis",@"Diagnosis: AUT",@"Diagnosis: AUT",@"No diagnosis", nil];
    companyArray=[[NSMutableArray alloc]initWithObjects:@"Organization: COR", @"Organization: COR", @"Organization: COR",@"Organization: COR",@"Organization: COR",@"Organization: COR", nil];
    photoArray=[[NSMutableArray alloc]initWithObjects:@"client1.png",@"client2.png",@"client3.png",@"client4.png",@"client5.png",@"client6.png", nil];
    clientInfos = [[NSMutableArray alloc] init];
    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width, 500)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) getDataFromServer {
    NSDictionary *parameters = @{@"token":[[NSUserDefaults standardUserDefaults] valueForKey:@"UserToken"]};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:@"http://52.26.92.41/api/v1/clients" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *responseData = (NSDictionary *)responseObject;
        
        if ([[responseData valueForKey:@"status"] isEqualToString:@"success"]) {
            NSArray *result = (NSArray *)[responseData valueForKey:@"data"];
            [self setClientInfos:result];
            [self.clientsTable reloadData];
        } else {
            [commonUtils showVAlertSimple:@"Notice" body:(NSString *)[responseData valueForKey:@"data"] duration:1.2];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [commonUtils showVAlertSimple:@"Notice" body:@"Internet connection is failed. Try it again later" duration:1.2];
        
    }];

}

- (void) setClientInfos : (NSArray *) datas {
    [clientInfos removeAllObjects];
    for (int i = 0 ; i <  [datas count]; i ++) {
        NSDictionary *client = (NSDictionary *)datas[i];
        [clientInfos addObject:client];
    }
}


#pragma mark - UITableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [clientInfos count];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *client = [clientInfos objectAtIndex:indexPath.row];
    
    ClientsTableViewCell *cell = (ClientsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"clientsCell"];
    NSString *clientPhotoURL = [client valueForKey:@"photo"];
    UIImage *clientPhoto = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:clientPhotoURL]]];
    cell.clientPhoto.image = clientPhoto;
    cell.clientName.text = [NSString stringWithFormat:@"%@ %@", [client valueForKey:@"first_name"], [client valueForKeyPath:@"last_name"]];
    cell.clientDiagnosis.text = [client valueForKey:@"diagnosis"];
    cell.clientCompany.text = [client valueForKey:@"school"];
//    cell.clientPhoto.image = [ UIImage imageNamed:[photoArray objectAtIndex:indexPath.row]];
//    cell.clientName.text = [nameArray objectAtIndex:indexPath.row];
//    cell.clientDiagnosis.text=[diagnosisArray objectAtIndex:indexPath.row];
//    cell.clientCompany.text=[companyArray objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath* )indexPath{
    appController.clientName=[nameArray objectAtIndex:indexPath.row];
    TrialHistoryViewController *trialHistoryViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"TrialHistoryViewController"];
    [self.navigationController pushViewController:trialHistoryViewController animated:YES];

}



- (IBAction)segmentClicked:(id)sender {
}

- (IBAction)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
