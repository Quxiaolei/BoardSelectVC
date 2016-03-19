//
//  ViewController.m
//  BoardSelectVC
//
//  Created by Madis on 16/3/19.
//  Copyright © 2016年 Madis. All rights reserved.
//

#import "ViewController.h"
#import "myButton.h"
@interface ViewController ()<UIScrollViewDelegate>{
    UIScrollView *_scro;
}
@property (nonatomic, strong) UIButton *currentSelectBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"scro";
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"next" style:UIBarButtonItemStylePlain target:self action:@selector(selector)];
    //数字自己改下
    _scro = [[UIScrollView alloc]init];
    _scro.frame = CGRectMake(0, 0, 375, 667);
    _scro.backgroundColor = [UIColor whiteColor];
    _scro.delegate = self;
    [self.view addSubview:_scro];
    
    NSMutableArray *listTop = [[NSMutableArray alloc] initWithArray:@[@"推荐",@"热点",@"杭州",@"社会",@"娱乐",@"科技",@"汽车",@"体育",@"订阅",@"财经",@"军事",@"国际",@"正能量",@"段子",@"趣图",@"美女",@"健康",@"教育",@"特卖",@"彩票",@"辟谣"]];
    float high = 0.0f;
    for (int i=0; i<listTop.count; i++) {
        myButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(padding+(padding+kItemW)*(i% itemPerLine), padding+(kItemH + padding)*(i/itemPerLine), kItemW, kItemH);
        btn.tag = 100+i;
        [btn setTitle:listTop[i] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor grayColor];
        [btn addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
        [_scro addSubview:btn];
        if (i == listTop.count -1) {
            high = btn.frame.origin.y + kItemH;
        }
    }
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, high + 4, kScreenW, 20)];
    view.backgroundColor = [UIColor blackColor];
    [_scro addSubview:view];
    
    NSMutableArray *listBottom = [[NSMutableArray alloc] initWithArray:@[@"电影",@"数码",@"时尚",@"奇葩",@"游戏",@"旅游",@"育儿",@"减肥",@"养生",@"美食",@"政务",@"历史",@"探索",@"故事",@"美文",@"情感",@"语录",@"美图",@"房产",@"家居",@"搞笑",@"星座",@"文化",@"毕业生",@"视频"]];
    for (int i=0; i<listBottom.count; i++) {
        myButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(padding+(padding+kItemW)*(i% itemPerLine),high + 20 + 5+ padding+(kItemH + padding)*(i/itemPerLine), kItemW, kItemH);
        //        CGRectMake(padding+(padding+kItemW)*(i%itemPerLine),CGRectGetMaxY(self.sectionHeaderView.frame)+padding+(kItemH+padding)*(i/itemPerLine), kItemW, kItemH)
        btn.tag = 200+i;
        [btn setTitle:listBottom
         [i] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor grayColor];
        [btn addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
        [_scro addSubview:btn];
    }
    
    //    _scro.contentSize = CGSizeMake(200*5, 180);
    //    分页
    //    _scro.pagingEnabled = YES;
    //    无弹性
    //    _scro.bounces = NO;
    //    隐藏水平/竖直滑动条
    //    _scro.showsHorizontalScrollIndicator = NO;
    //    _scro.showsVerticalScrollIndicator = NO;
    //    初始偏移量
    //    _scro.contentOffset = CGPointMake(200, 0);
    //    用到的4个协议方法可以查，将要开始拖拽，已经结束减速（控制小不点）等
}
- (void)selector{
    
        SecondViewController *vc = [[SecondViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
}
//按钮点击方法
- (void)touch:(myButton *)btn{
    NSLog(@"李磊 - %ld \nx:%.2f,y:%.2f",btn.tag,btn.frame.origin.x,btn.frame.origin.y);
    _currentSelectBtn = btn;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        //        CGRect btnBackViewRect = self.btnBackView.frame;
        //        btnBackViewRect.size.width = sender.frame.size.width+kExtraPadding;
        //        self.btnBackView.frame = btnBackViewRect;
        //        CGFloat changeW = sender.frame.origin.x-(btnBackViewRect.size.width-sender.frame.size.width)/2-10;
        //        self.btnBackView.transform  = CGAffineTransformMakeTranslation(changeW, 0);
        CGPoint p = CGPointMake(20, 315);
        btn.center = p;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            CGPoint changePoint;
            
            
            //            if (sender.frame.origin.x >= kScreenW - 150 && sender.frame.origin.x < self.contentSize.width-200) {changePoint = CGPointMake(sender.frame.origin.x - 200, 0);}
            //            else if (sender.frame.origin.x >= self.contentSize.width-200){changePoint = CGPointMake(self.contentSize.width-350, 0);}
            //            else{changePoint = CGPointMake(0, 0);}
            //            self.contentOffset = changePoint;
        }];
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"李磊");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
