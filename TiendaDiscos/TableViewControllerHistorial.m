//
//  TableViewControllerHistorial.m
//  TiendaDiscos
//
//  Created by MAC COMPARTIDA2 on 21/07/15.
//  Copyright (c) 2015 MAC COMPARTIDA2. All rights reserved.
//

#import "TableViewControllerHistorial.h"
#import "Disco.h"

@interface TableViewControllerHistorial ()

@end

@implementation TableViewControllerHistorial

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSLog(@"Disco Historial Vista 2 %ld",[_historialDiscos count]);
    
    return [_historialDiscos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    Disco *disco = [_historialDiscos objectAtIndex:indexPath.row];
    
    
    cell.textLabel.text = disco.artista;
    
    cell.detailTextLabel.text = disco.nombre;
    
    
    return cell;
}

@end
