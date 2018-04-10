//
//  ZWCalendarView.m
//  ZWCalendar
//
//  Created by apple on 2018/3/20.
//  Copyright © 2018年 zzw. All rights reserved.
//

#import "ZWCalendarView.h"
#import "ZWDateItemCollectionViewCell.h"
#import "ZWCalendarManage.h"
#import "ZWCalendarHeaderCollectionReusableView.h"
#import "ZWCalendarViewModel.h"
@interface ZWCalendarView () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic , strong) UICollectionView * collectionView;
@property (nonatomic , strong) ZWCalendarViewModel * viewModel;
@property (nonatomic , strong) ZWCalendarItemsModel * selectModel;
@end
@implementation ZWCalendarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
    }
    return self;
}

- (ZWCalendarViewModel*)viewModel{
    
    if (!_viewModel) {
        _viewModel = [[ZWCalendarViewModel alloc] init];
    }
    return _viewModel;
}

- (void)createUI{
    CGFloat w = self.frame.size.width/7;
    CGFloat h = 20.0f;
    NSArray *  weekStr = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    for (NSInteger i = 0; i <weekStr.count; i++) {
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(i*w, 0, w, h)];
        lab.text = weekStr[i];
        lab.font = [UIFont systemFontOfSize:14];
        lab.backgroundColor =[UIColor whiteColor];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = [UIColor blackColor];
        [self addSubview:lab];
    }
    [self addSubview:self.collectionView];
}
- (UICollectionView*)collectionView{
    if (!_collectionView) {
     
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionHeadersPinToVisibleBounds= YES;
        layout.sectionInset = UIEdgeInsetsMake(0,0, 0, 0);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, self.frame.size.width, self.frame.size.height-20) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_collectionView];
        [_collectionView registerClass:[ZWDateItemCollectionViewCell class] forCellWithReuseIdentifier:@"ZWDateItemCollectionViewCell"];
        [_collectionView registerClass:[ZWCalendarHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ZWCalendarHeaderCollectionReusableView"];
    }
    
    return _collectionView;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.viewModel.dataSource.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   ZWCalendarModel * model = self.viewModel.dataSource[section];
    return model.dateArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZWDateItemCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"ZWDateItemCollectionViewCell" forIndexPath:indexPath];
    ZWCalendarModel * model = self.viewModel.dataSource[indexPath.section];
   ZWCalendarItemsModel * m =model.dateArr[indexPath.row];
    if (m.isSelected) {
        self.selectModel = m;
    }
    cell.model =m;
    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        ZWCalendarHeaderCollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ZWCalendarHeaderCollectionReusableView" forIndexPath:indexPath];
        ZWCalendarModel * model = self.viewModel.dataSource[indexPath.section];
        view.datelab.text = [NSString stringWithFormat:@"%ld-%ld",model.year,model.month];
        return view;
    }
    
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
       CGFloat w = self.frame.size.width/7.0;
    return CGSizeMake(w, 1.5*w);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
        return CGSizeMake(self.frame.size.width, 30);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZWCalendarModel * model = self.viewModel.dataSource[indexPath.section];
    ZWCalendarItemsModel * m =model.dateArr[indexPath.row];
    self.selectModel.isSelected = NO;
    m.isSelected = YES;
    [collectionView reloadData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
