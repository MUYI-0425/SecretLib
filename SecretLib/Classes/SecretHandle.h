//
//  SecretHandle.h
//  BlueToothData
//
//  Created by apple on 2018/1/8.
//  Copyright © 2018年 孙晓东. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    FiveMinuteM = 0,
    TenMinuteM,
    HalfHourM,
    OneHourM,
    TwoHourM,
    FourHourM,
    EightHourM,
    OnceM
} SecretModel;

typedef void(^Result)(NSString *secretR);

@interface SecretHandle : NSObject

+ (void)transportDeviceId:(NSString *)deviceId secretModel:(SecretModel)secretM result:(Result)result;

@end
