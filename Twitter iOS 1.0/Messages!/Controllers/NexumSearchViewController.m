//
//  NexumSearchViewController.m
//  Twitter iOS 1.0
//
//  Created by Cristian Castillo on 11/13/13.
//  Copyright (c) 2013 NexumDigital Inc. All rights reserved.
//

#import "NexumSearchViewController.h"

@interface NexumSearchViewController ()

@end

@implementation NexumSearchViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self clearTable];
    self.path = @"contacts/twitter/suggested";
    
    self.searchBar.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self loadDataFromPath:self.path withPage:self.page andQuery:self.query];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"showProfile"]){
        NexumProfileViewController *profileView = [segue destinationViewController];
        profileView.profile = self.nextProfile;
    }
}

#pragma mark - SearchBar delegate

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self clearTable];
    [self.searchBar resignFirstResponder];
    self.path = @"contacts/twitter/search";
    self.query = searchBar.text;
    
    [self loadDataFromPath:self.path withPage:self.page andQuery:searchBar.text];
}

#pragma mark - TableView delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.nextProfile = [self.profiles objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier: @"showProfile" sender:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(0 < [self.profiles count])
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    return [self.profiles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ProfileCell";
    NexumProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *profile = [self.profiles objectAtIndex:indexPath.row];
    cell.identifier = profile[@"identifier"];
    [cell reuseCellWithProfile:profile];
    
    if([self.profiles count] < (indexPath.row + 20)){
        if([NSNull null] != (NSNull *)self.page){
            [self loadDataFromPath:self.path withPage:self.page andQuery:self.query];
        }
    }
    
    return cell;
}

#pragma mark - Load data

- (IBAction)actionButton:(id)sender {
}

- (void) loadDataFromPath:(NSString *)path withPage:(NSString *)page andQuery:(NSString *)query{
    if(!self.isLoading){
        self.isLoading = YES;
        
        NSString *params = [NSString stringWithFormat:@"identifier=%@&page=%@&query=%@",
                            [NexumDefaults currentAccount][@"identifier"],
                            page,
                            query
                            ];
        
        [NexumBackend apiRequest:@"GET" forPath:path withParams:params andBlock:^(BOOL success, NSDictionary *data) {
            if(success){
                self.page = data[@"pagination"][@"next"];
                [self.profiles addObjectsFromArray:data[@"profiles_data"]];
                [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
            }
            self.isLoading = NO;
        }];
    }
}

#pragma mark - Helpers

- (void) clearTable {
    self.profiles = [NSMutableArray array];
    self.isLoading = NO;
    self.page = @"0";
    self.query = @"";
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView reloadData];
}

@end
