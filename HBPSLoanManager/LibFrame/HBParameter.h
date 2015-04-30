//
//  HBParameter.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/9.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#ifndef HBPSLoanManager_HBParameter_h
#define HBPSLoanManager_HBParameter_h

#define kDefaultEDSKey @"8jG93wGg8h"          //默认key
#define kEDSKeyString @"EDSKEYSTRING"   //edsKey 在userdefault中的名称

#define kDefaultValue @"9\\9....\\9"

typedef void(^GetBackData)(NSMutableDictionary *dataDic);



// 当前系统版本
#define DSystemVersion          ([[[UIDevice currentDevice] systemVersion] doubleValue])
//当前软件版本
#define DAPPVersion          ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])

// MainScreen Height&Width
#define kSCREEN_HEIGHT      (DSystemVersion>=7.0 ? [[UIScreen mainScreen] bounds].size.height : ([[UIScreen mainScreen] bounds].size.height - 20))

#define kSCREEN_WIDTH       [[UIScreen mainScreen] bounds].size.width


#define kTopBarHeight           (DSystemVersion>=7?64.f:44.f)

#define kTabbarHight kSCREEN_HEIGHT*49/568


#define  FromStatusBarHeight   (DSystemVersion>=7?20.f:0.f)

#define kIsIOS7OrLater ([UIDevice currentDevice].systemVersion.integerValue >= 7 ? YES : NO)

// 加载图片
#define PNGIMAGE(NAME)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
#define JPGIMAGE(NAME)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpg"]]
#define IMAGE(NAME, EXT)        [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]
#define IMAGENAMED(NAME)        [UIImage imageNamed:NAME]



///< 参数格式为：0xFFFFFF
#define kColorWith16RGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
                green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
                 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]
///< 参数格式：22,22,22
#define kColorWithRGB(r, g, b) ([UIColor colorWithRed:(r) / 255.0  \
green:(g) / 255.0  \
blue:(b) / 255.0  \
alpha:1])
///< 参数格式：22,22,22,0.5
#define kColorWithRGBA(r, g, b, a) ([UIColor colorWithRed:(r) / 255.0  \
green:(g) / 255.0  \
blue:(b) / 255.0  \
alpha:(a)])

// 颜色(RGB)
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//网络请求超时时间
#define kTIMEOUTSECOND 15
//定位信息
#define kLocationInfo @"kLocationInfo"

#define kNSNotificationTabbarHide @"kNSNotificationTabbarHide"








//默认配置参数
/*
 1：生产经营场所外观
 2：企业经营场地或生产车间
 3：货物/机器、设备、车辆等实物照片、采购合同或协议、入库单
 4：货物/机器、设备、车辆等实物照片、采购合同或协议、入库单、转账或汇款凭证、账户流水
 5：经营场地内部照片、装修合同或协议
 6：经营场地内部照片、装修合同或协议、转账或汇款凭证、账户流水
 7：工资表、转账或汇款凭证、账户流水
 8：原材料或辅料/机器、设备、车辆等实物照片、采购合同或协议、入库单
 9：原材料或辅料/机器、设备、车辆等实物照片、采购合同或协议、入库单、转账或汇款凭证、账户流水
 10：车间、厂房内外部照片，修建/装修合同或协议
 11：车间、厂房内外部照片，修建/装修合同或协议，转账或汇款凭证、账户流水
 12：设备/车间、厂房维修单据或协议
 13：设备/车间、厂房维修单据或协议，转账或汇款凭证、账户流水
 14：设备/库房维修单据或协议
 15：设备/库房维修单据或协议，转账或汇款凭证、账户流水
 16: 原材料、库存成品或半成品
 17：财务系统截屏/纳税申报表、销售出入库单/销售合同/发票、近两个月银行账户流水/会计凭证
 18：企业营业执照
 19：组织机构代码证
 20：存货明细清单
 21：销售出入库单/销售合同/发票
 22：近两个月银行账户流水/会计凭证
 23：财务系统截屏/纳税申报表
 24：应收款明细
 */

typedef NS_ENUM(NSUInteger, ImageType) {
    ImageType1 = 1,
    ImageType2,
    ImageType3,
    ImageType4,
    ImageType5,
    ImageType6,
    ImageType7,
    ImageType8,
    ImageType9,
    ImageType10,
    ImageType11,
    ImageType12,
    ImageType13,
    ImageType14,
    ImageType15,
    ImageType16,
    ImageType17,
    ImageType18,
    ImageType19,
    ImageType20,
    ImageType21,
    ImageType22,
    ImageType23,
    ImageType24,
};




#endif
