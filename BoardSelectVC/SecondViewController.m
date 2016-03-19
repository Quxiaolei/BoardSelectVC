//
//  SecondViewController.m
//  BoardSelectVC
//
//  Created by Madis on 16/3/19.
//  Copyright © 2016年 Madis. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collection;
    NSMutableArray *topArray;
//    ,*bottomArray;
}
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"collection";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc] init];
    _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, 375, 667) collectionViewLayout:layout];
    _collection.backgroundColor = [UIColor whiteColor];
    _collection.userInteractionEnabled = YES;
    //设置每一块的大小
    layout.itemSize = CGSizeMake(50, 50);
    //设置行间距
    layout.minimumLineSpacing = 30;
    //设置列间距
    layout.minimumInteritemSpacing = 30;
    //设置边界间距
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.view addSubview:_collection];
    _collection.dataSource = self;
    _collection.delegate = self;
    [_collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
//    NSMutableArray *array1 = [NSMutableArray arrayWithArray:@[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"]];
//    NSMutableArray *array2= [NSMutableArray arrayWithArray:@[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"]];
    topArray = [[NSMutableArray alloc]initWithArray:@[[NSMutableArray arrayWithArray:@[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"]],[NSMutableArray arrayWithArray:@[@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"110"]]]];
//    bottomArray = [[NSMutableArray alloc]initWithArray:@[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"]];
    
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    longPressGr.minimumPressDuration = 1.0;
    [_collection addGestureRecognizer:longPressGr];
}

-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture
{
    CGPoint point = [gesture locationInView:_collection];
    NSIndexPath * indexPath = [_collection indexPathForItemAtPoint:point];
    switch(gesture.state) {
        case UIGestureRecognizerStateBegan:{
            [_collection beginInteractiveMovementForItemAtIndexPath:indexPath];
            break;
            }
        case UIGestureRecognizerStateChanged:{
            [_collection updateInteractiveMovementTargetPosition:point];
            break;
        }
        case UIGestureRecognizerStateEnded:{
            [_collection endInteractiveMovement];
            break;
        }
        default:
        [_collection cancelInteractiveMovement];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return topArray.count;
}
//设置collectionView一共有多少块
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return [topArray[0] count];
    }else{
        return [topArray[1] count];
    }
}
//设置每一块的内容cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //添加内容
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    label.textAlignment = NSTextAlignmentCenter;
    if(indexPath.section == 0){
        label.text = [NSString stringWithFormat:@"%@",topArray[indexPath.section][indexPath.row]];
        cell.backgroundColor = [UIColor redColor];
    }else{
        label.text = [NSString stringWithFormat:@"%@",topArray[indexPath.section][indexPath.row]];
        cell.backgroundColor = [UIColor yellowColor];
    }
    label.tag = 999;
    [[cell viewWithTag:999] removeFromSuperview];
    [cell.contentView addSubview:label];
    return cell;
}
#pragma mark touch
- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
{
    NSLog(@"李磊");
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"李磊se:%ld row:%ld",indexPath.section,indexPath.row);

    if (indexPath.section == 1) {
        [topArray[0] addObject:topArray[1][indexPath.row] ];
        [topArray[1] removeObjectAtIndex:indexPath.row];
    }else{
        [topArray[1] addObject:topArray[0][indexPath.row]];
        [topArray[0] removeObjectAtIndex:indexPath.row];
    }
    [_collection reloadData];
//    [_collection insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:topArray.count - 1 inSection:0]]];
}
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSLog(@"move:form:se:%ld row:%ld TO se:%ld row:%ld",sourceIndexPath.section,sourceIndexPath.row,destinationIndexPath.section,destinationIndexPath.row);
    NSString *temp = topArray[sourceIndexPath.section][sourceIndexPath.row];
    [topArray[sourceIndexPath.section] removeObjectAtIndex:sourceIndexPath.row];
    [topArray[destinationIndexPath.section] insertObject:temp atIndex:destinationIndexPath.row];
//    [topArray exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
    NSLog(@"%@",topArray);
}
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end
