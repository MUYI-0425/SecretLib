//
//  SecretHandle.m
//  BlueToothData
//
//  Created by apple on 2018/1/8.
//  Copyright © 2018年 孙晓东. All rights reserved.
//

#import "SecretHandle.h"

static NSString *deviceName;

@implementation SecretHandle

+ (void)transportDeviceId:(NSString *)deviceId secretModel:(SecretModel)secretM result:(Result)result {
    
    if (deviceId.length < 6) {
        
        return;
    }
    
    deviceName = deviceId;
    
    NSDate *current = [NSDate date];
    
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    
    [format setDateFormat:@"yyyyMMddHHmmss"];
    
    NSString *date_str = [format stringFromDate:current];
    
    NSString *data_correct = [date_str substringFromIndex:2];
    
    int month = [[data_correct substringWithRange:NSMakeRange(2, 2)] intValue];
    
    int day = [[data_correct substringWithRange:NSMakeRange(4, 2)] intValue];
    
    int hour = [[data_correct substringWithRange:NSMakeRange(6, 2)] intValue] + 1;
    
    int minute = [[data_correct substringWithRange:NSMakeRange(8, 2)] intValue];
    
    NSString *passWord = @"";
    
    int deviceID = [[deviceId substringFromIndex:3] intValue];
    
    int tempDivisor,num;
    
    switch (secretM) {
        case 0:
            tempDivisor = minute / 5 + 1;
            
            num = month * day * hour * tempDivisor;
            
            num += deviceID;
            
            passWord = [NSString stringWithFormat:@"%d",num];
            break;
        case 1:
            tempDivisor = minute / 10 + 1;
            
            num = month * day * hour * tempDivisor;
            
            num += deviceID;
            
            passWord = [NSString stringWithFormat:@"%d",num];
            
            break;
        case 2:
            tempDivisor = minute / 30 + 1;
            
            num = month * day * hour * tempDivisor;
            
            num += deviceID;
            
            passWord = [NSString stringWithFormat:@"%d",num];
            break;
        case 3:
            num = month * day * hour;
            
            num += deviceID;
            
            passWord = [NSString stringWithFormat:@"%d",num];
            break;
        case 4:
        {
            int div = hour / 2;
            int remainder = hour % 2;
            
            int tempPlus = div + remainder;
            num = month * day * tempPlus;
            
            num += deviceID;
            
            passWord = [NSString stringWithFormat:@"%d",num];
            break;
        }
        case 5:
        {
            int div = (hour - 1) / 4;
            
            int tempPlus = div + 1;
            
            num = month * day * tempPlus;
            
            num += deviceID;
            
            passWord = [NSString stringWithFormat:@"%d",num];
            break;
        }
        case 6:
        {
            int div = (hour - 1) / 8;
            
            int tempPlus = div + 1;
            
            num = month * day * tempPlus;
            
            num += deviceID;
            
            passWord = [NSString stringWithFormat:@"%d",num];
            break;
        }
            break;
        case 7:
        {
            int range = [self getNumberOfDaysOneYear:current];
            
            passWord = [NSString stringWithFormat:@"%d",range];
            
            break;
        }
        default:
            break;
    }
    
    if (secretM != 7) {
        if (passWord.length < 5) {
            NSString *temp = @"";
            for (int i = 0; i < 5 - passWord.length; i++) {
                temp = [temp stringByAppendingString:@"0"];
            }
            passWord = [NSString stringWithFormat:@"%@%@",temp,passWord];
        }
        if (passWord.length > 5) {
            passWord = [passWord substringFromIndex:passWord.length - 5];
        }
        
        passWord = [passWord stringByAppendingString:[NSString stringWithFormat:@"%d",secretM]];
        
        
        if (result) {
            result(passWord);
        }
    }else{
        if (passWord.length < 4) {
            NSString *temp = @"";
            for (int i = 0; i < 4 - passWord.length; i++) {
                temp = [temp stringByAppendingString:@"0"];
            }
            passWord = [NSString stringWithFormat:@"%@%@",temp,passWord];
        }
        
        int random = arc4random()%900+100;
        
        int _100div = random / 100 ;
        
        int _10div = random % 100 / 10 ;
        
        int _1div = random % 100 % 10 ;
        
        NSString *firstChar = [passWord substringToIndex:1];
        NSString *secChar = [passWord substringWithRange:NSMakeRange(1, 1)];
        NSString *thirdChar = [passWord substringWithRange:NSMakeRange(2, 1)];
        NSString *fouthChar = [passWord substringWithRange:NSMakeRange(3, 1)];
        
        NSString *secPW = [NSString stringWithFormat:@"%@%d%@%d%@%d%@",firstChar,_100div,secChar,_10div,thirdChar,_1div,fouthChar];
    
        if (result) {
            result(secPW);
        }
    }
}

+ (int)getNumberOfDaysOneYear:(NSDate *)date{
    
    NSDate *current = [NSDate date];
    
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    
    [format setDateFormat:@"yyyyMMddHHmmss"];
    
    NSString *date_str = [format stringFromDate:current];
    
    int year = [[date_str substringToIndex:4] intValue];
    int month = [[date_str substringWithRange:NSMakeRange(4, 2)] intValue];
    int day = [[date_str substringWithRange:NSMakeRange(6, 2)] intValue];
    
    NSArray *_366Day = @[@31,@29,@31,@30,@31,@30,@31,@31,@30,@31,@30,@31];
    NSArray *_365Day = @[@31,@28,@31,@30,@31,@30,@31,@31,@30,@31,@30,@31];
    
    int totalNum = 0;
    if (year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)) {
        if (month == 1) {
            totalNum = day;
        }else{
            for (int i = 0; i < month - 1; i++) {
                totalNum += [_366Day[i] intValue];
            }
            totalNum += day;
        }
    }else{
        if (month == 1) {
            totalNum = day;
        }else{
            for (int i = 0; i < month - 1; i++) {
                totalNum += [_365Day[i] intValue];
            }
            totalNum += day;
        }
    }
    
    totalNum += [[deviceName substringFromIndex:3] intValue];
    
    return totalNum;
}


@end
