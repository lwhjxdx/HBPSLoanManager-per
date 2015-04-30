//
//  HBNextStepChangeCell.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/18.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBNextStepChangeCell.h"

@implementation HBNextStepChangeCell
{
    NSArray *_btnArray;
    NSInteger _tag;
}
- (void)awakeFromNib {
    [self.firstBtn addTarget:self action:@selector(changeImage:) forControlEvents:(UIControlEventTouchUpInside)];
    self.firstBtn.tag = firstBtnTag;
    
    [self.secondBtn addTarget:self action:@selector(changeImage:) forControlEvents:(UIControlEventTouchUpInside)];
    self.secondBtn.tag = secondBtnTag;
    
    [self.thirdBtn addTarget:self action:@selector(changeImage:) forControlEvents:(UIControlEventTouchUpInside)];
    self.thirdBtn.tag = thirdBtnTag;
    _btnArray = @[self.firstBtn,self.secondBtn,self.thirdBtn];
    
    
    _tag = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




- (void)changeImage:(UIButton *)btn{
    self.valueString = [NSString stringWithFormat:@"%ld",(long)btn.tag];

    if (btn.tag == _tag) {
        return;
    }
    _tag = btn.tag;
    for (UIButton *btn in _btnArray) {
        [btn setImage:[UIImage imageNamed:@"unChecked"] forState:(UIControlStateNormal)];
    }
    [btn setImage:[UIImage imageNamed:@"checked"] forState:(UIControlStateNormal)];
    
    
    if (_vc) {
        
        NSMutableDictionary *valueDic = [NSMutableDictionary dictionary];
        [valueDic setObject:[NSNumber numberWithInteger:self.index] forKey:@"index"];
        if (self.needAdd == btn.tag) {
            [valueDic setObject:@"YES" forKey:@"needAdd"];
        }
        
        // 当cell中的按钮被点击 且 当前按钮的下标为1时 出发刷新方法

        [_vc performSelector:@selector(refreshView:) withObject:valueDic];
    }
}




- (void)ConfigCellWithTitle:(NSString *)titleString itemArray:(NSArray *)itemArray{
    self.titleNameLabel.text = titleString;
    self.firstLabel.text = itemArray[0];
    self.secondLabel.text = itemArray[1];
    if (itemArray.count >2) {
        self.thirdLabel.text = itemArray[2];
        self.thirdView.hidden = NO;
    }else{
        self.thirdView.hidden = YES;
    }
}



- (void)setSelectIndex:(NSInteger)selectIndex{
    if(selectIndex >_btnArray.count){
        return;
    }
    UIButton *btn = [_btnArray objectAtIndex:selectIndex];
    [self changeImage:btn];
}

- (void)fitTwoItems{
    self.fristView.frame = CGRectMake(10, 30, kSCREEN_WIDTH/2 - 20, 30);
    self.firstLabel.frame = CGRectMake(30, 4, kSCREEN_WIDTH/2 - 20 - 30, 21);
    self.secondLabel.frame = CGRectMake(30, 4, kSCREEN_WIDTH/2 - 20 - 30, 21);
    self.secondView.frame = CGRectMake(kSCREEN_WIDTH/2, 30, kSCREEN_WIDTH/2 - 20, 30);
}


@end
