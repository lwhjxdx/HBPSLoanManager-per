//
//  HBCheckNextBaseController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/31.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBCheckNextBaseController.h"
#import "HBCTextFeildTableViewCell.h"
#import "HBNextStepChangeCell.h"
#import "ZipTool.h"




@implementation HBCheckNextBaseController

- (void)viewDidLoad{
    [super viewDidLoad];
    _draftSevice = [[HBDraftSevice alloc] init];


}


- (void)refreshView:(NSMutableDictionary *)dic{
    [self.view endEditing:YES];
    NSInteger index = [dic[@"index"] integerValue];
    
    //如果 _infoArray 中相应的 为 @""时  表示不需要弹出输入框。
    if ([[_infoArray objectAtIndex:index] isEqualToString:@""]) {
        return;
    }
    
    //当需要 needAdd 添加输入框时
    if (dic[@"needAdd"]) {
        
        UIView *cellView = [cellArray objectAtIndex:index];
        NSInteger viewIndex = [viewArray indexOfObject:cellView];
        HBCTextFeildTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"HBCTextFeildTableViewCell" owner:nil options:nil] lastObject];
        cell.frame = CGRectMake(0,cellView.frame.origin.y + cellView.frame.size.height, kSCREEN_WIDTH, kTextFieldHigh);
        cell.keyString = [_infoArray objectAtIndex:index];
        [cell setValueText:[self.userDic objectForKey:cell.keyString]];
        [cell setTextLength:_textLengthArray[index]];
        [scrollView addSubview:cell];
        
        for (NSUInteger i = viewIndex+1; i<viewArray.count; i++) {
            [UIView animateWithDuration:0.3 animations:^{
                UIView *view = [viewArray objectAtIndex:i];
                CGRect rect = view.frame;
                rect.origin.y += kTextFieldHigh;
                view.frame  = rect;
            }];
        }
        [viewArray insertObject:cell atIndex:viewIndex+1];
        
    }else{
        //需要去除 textField框时
        
        UIView *cellView = [cellArray objectAtIndex:index];
        NSInteger viewIndex = [viewArray indexOfObject:cellView];
        
        for (NSInteger i = viewIndex+1; i<viewArray.count; i++) {
            [UIView animateWithDuration:0.3 animations:^{
                
                UIView *view = [viewArray objectAtIndex:i];
                CGRect rect = view.frame;
                rect.origin.y -= kTextFieldHigh;
                view.frame  = rect;
            }];
        }
        UIView *view = [viewArray objectAtIndex:viewIndex+1];
        [view removeFromSuperview];
        [viewArray removeObjectAtIndex:viewIndex+1];
    }
    
    //重新计算 scrollView.contentSize
    CGFloat scorllHigh =  kNextStepCellHigh * 2;
    for (UIView *view in viewArray) {
        scorllHigh += view.frame.size.height;
    }
    scrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, scorllHigh);
}


- (void)addTwoBtn{
    saveBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [saveBtn setFrame:CGRectMake(10, (cellArray.count + 1)*kNextStepCellHigh, kSCREEN_WIDTH/2-20, 40)];
    [saveBtn setTitle:@"保存草稿箱" forState:UIControlStateNormal];
    [saveBtn setBackgroundColor:RGBACOLOR(0, 93, 57, 1)];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    saveBtn.layer.cornerRadius = 5;
    saveBtn.layer.masksToBounds = YES;
    [saveBtn addTarget:self action:@selector(save) forControlEvents:(UIControlEventTouchUpInside)];
    [scrollView addSubview:saveBtn];
    [viewArray addObject:saveBtn];
    
    upDataBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [upDataBtn setFrame:CGRectMake(10+kSCREEN_WIDTH/2, (cellArray.count + 1)*kNextStepCellHigh, kSCREEN_WIDTH/2-20, 40)];
    [upDataBtn setBackgroundColor:RGBACOLOR(0, 93, 57, 1)];
    [upDataBtn addTarget:self action:@selector(upData) forControlEvents:(UIControlEventTouchUpInside)];
    [upDataBtn setTitle:@"完成" forState:UIControlStateNormal];
    upDataBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    upDataBtn.layer.cornerRadius = 5;
    upDataBtn.layer.masksToBounds = YES;
    [scrollView addSubview:upDataBtn];
    [viewArray addObject:upDataBtn];
    scrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, upDataBtn.frame.origin.y + 100);
}


//保存草稿箱
- (void)save{
    [self getParamDicWithOutCheck];
    Boolean success =[_draftSevice saveDraft:_paramDic withType:self.checkType withClassName:self.className];
    
    if (success) {
        [self showAlterView:@"保存成功"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self showAlterView:@"保存失败"];
    }
}


//上传信息
- (void)upData{
    [self makeParams];
}


//准备参数  （将 相应的 图片路径 打包 上传到服务器）

- (void)makeParams{
    //如果 参数没有填写完整  返回
    if (![self getAllParams]) {
        return;
    };
    
    
    //参数完整  处理 zip
    if (![self isZipParamsRight]) {
        
        //如果有  没有上传的 文件
        
        for (NSString *key in valueArrays) {
            NSString *keyString1 = [self.userDic objectForKey:key];
            
            
            if ([keyString1 rangeOfString:@"."].length ==0) {
                
                /*
                 判断有 “.” 表示为 文件路径
                 例如 c://book.jpg 中含有“.”
                 
                 当  当前参数 不为文件路径
                 跳出当前循环
                 */
                
                break;
            }
            if (keyString1 == nil) {
                break;
            }else{
                
                /**
                 
                 通过图片路径 keyString1 压缩 成zip包

                 获取压缩文件路径
                 
                 将压缩文件 上传服务器
                 
                 */
                
                NSString *path = [ZipTool getZipPath:keyString1];
                [self uploadZip:path keyString:key];
            }
        }
    }else{
        [self upDataString];
    }
}

//判断zip的文件参数是否正确
- (Boolean)isZipParamsRight{
    Boolean right = NO;
    for (NSString *keyString in valueArrays) {
        NSString *valueString1 = [_paramDic objectForKey:keyString];
        if (valueString1!=nil){
            if ([valueString1 rangeOfString:@"."].length ==0) {
                right =YES;
            }else{
                return NO;
            }
        }else{
            [self showAlterView:@"你上传的影像文件不完整"];
            return YES;
        }
    }
    return right;
}

//上传附件 接口
- (void)uploadZip:(NSString *)zipPath keyString:(NSString *)keyString{
    
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSData *data = [NSData dataWithContentsOfFile:zipPath];
    [dic setObject:data forKey:@"fileName"];
    [dic setObject:@"2" forKey:@"uploadType"];
    [HBRequest uploadHeader:kFileUploadURL withParams:dic successfulBlock:^(NSDictionary *receiveJSON) {
        //上传成功后  将上传的结果 和 key  添加到 _paramDic  再进行文本的上传
        
 
        //上传成功  删除zip
        [[NSFileManager defaultManager] removeItemAtPath:zipPath error:nil];
        
        [_paramDic setObject:receiveJSON[@"uploadResult"] forKey:keyString];
        
        
        //再次调用上传
        [self upDataString];
    } failBlock:^(NSError *error) {
        
    } isNoSession:YES];
}





//上传文字
- (void)upDataString{
    if([self isZipParamsRight] &&self.requestUrl){
        [HBRequest RequestDataJointStr:self.requestUrl parameterDic:_paramDic successfulBlock:^(NSDictionary *receiveJSON) {
            //成功返回
            
            //将草稿箱中的数据清除
            [_draftSevice cleanDraft:_paramDic[@"custName"] type:self.checkType];
            
            [self showAlterView:receiveJSON[@"respMsg"]];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        } failBlock:^(NSError *error) {
        }];
    }
}



- (Boolean)getAllParams{
    Boolean isRight = YES;
    [viewArray removeObject:saveBtn];
    [viewArray removeObject:upDataBtn];
    for (UIView *view in viewArray) {

            NSString *keyString = [view valueForKey:@"keyString"];
            NSString *valueString = [view valueForKey:@"valueString"];
            @try {
                if(valueString  && ![valueString isEqualToString:@""]){
                    [_paramDic setObject:valueString forKey:keyString];
                }else{
                    [self showAlterView:@"请将信息填写完整"];
                    isRight = NO;
                }
            }
            @catch (NSException *exception) {
                [self showAlterView:@"请将信息填写完整"];
                isRight = NO;
            }
            @finally {
                
            }
    }
    
    [viewArray addObject:saveBtn];
    [viewArray addObject:upDataBtn];
    [self handleSpecial];
    NSLog(@"dic = %@",_paramDic);
//    for (NSString *valueStr in [_paramDic allValues]) {
//        if ([valueStr isEqualToString:kDefaultValue]) {
//            isRight = NO;
//            [self showAlterView:@"请将上页信息填写完整"];
//        }
//    }
    return isRight;
}


//填充数据从字典中 如果字段中有对应的数据 就显示
- (void)fillDataFromDic{
    NSMutableArray *tempArray = viewArray;
    for (int i = 0 ; i <tempArray.count ; i++) {
        UIView *view = [tempArray objectAtIndex:i];
        if (view == saveBtn || view == upDataBtn) {
            continue;
        }
        NSString *keyString = [view valueForKey:@"keyString"];
        if (_paramDic[keyString]) {
            if ([view isKindOfClass:[HBNextStepChangeCell class]]) {
                [((HBNextStepChangeCell *)view) setSelectIndex:[_paramDic[keyString] integerValue]];
            }else if([view isKindOfClass:[HBCTextFeildTableViewCell class]]){
                [((HBCTextFeildTableViewCell *)view)  setValueText:_paramDic[keyString]];
            }
        }
    }
}



//接收block
- (void)setBackEvent:(GetBackData)black{
    self.getbackData = black;
}


//返回上一页   保存数据 并将数据带到上页
- (void)backBtnEvents:(id)sender{
    [super backBtnEvents:sender];
    [self getParamDicWithOutCheck];
    if (self.getbackData) {
        self.getbackData(_paramDic);
    }
}

//获取参数  跳过 检查 数据完整性
- (void)getParamDicWithOutCheck{
    [viewArray removeObject:saveBtn];
    [viewArray removeObject:upDataBtn];
    for (UIView *view in viewArray) {
        NSString *keyString = [view valueForKey:@"keyString"];
        NSString *valueString = [view valueForKey:@"valueString"];
        if(valueString  ){
            [_paramDic setObject:valueString forKey:keyString];
        }
    }
    [viewArray addObject:saveBtn];
    [viewArray addObject:upDataBtn];
}



//页面显示  填充数据
- (void)viewDidAppear:(BOOL)animated{
    _paramDic = self.userDic;
    [self fillDataFromDic];
    NSLog(@"=============%@",_paramDic);

}

@end
