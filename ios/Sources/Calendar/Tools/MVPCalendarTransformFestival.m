//
//  MVPCalendarTransformFestival.m
//  FSCalendar
//
//  Created by 风海 on 17/2/25.
//  Copyright © 2017年 wenchaoios. All rights reserved.
//

#import "MVPCalendarTransformFestival.h"
#import "MVPCommonUtils.h"
#define ChineseFestival @[@"除夕",@"春节",@"元宵节",@"妇女节",@"劳动节",@"端午节",@"儿童节",@"七夕",@"中秋节",@"教师节",@"国庆节",@"元旦",@"情人节",@"愚人节",@"光棍节",@"平安夜",@"圣诞节"]

@implementation MVPCalendarTransformFestival
+ (BOOL)isPreSaleDate:(NSDate *)date preNum:(long)preNum{
    if ([[NSDate date] compare:date] == NSOrderedAscending) {
        if ([MVPCommonUtils getDaysBetweenOneDay:date otherDay:[NSDate date]] < preNum) {
            return YES;
        }
    }
    return NO;
}

+ (NSString *)transformFestivalWithDate:(NSDate *)date{
    
    NSString *festival = @"";
    NSCalendar *chineseCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *components = [chineseCalendar components:NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    NSCalendar *normalDate = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [normalDate components:NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    
    //农历节日
    if (components.month == 1 && components.day == 1) {
        festival = [NSString stringWithFormat:@"%@",ChineseFestival[1]];//春节
    }else if (components.month == 1 && components.day == 15){
        festival = [NSString stringWithFormat:@"%@",ChineseFestival[2]];//元宵节
    }else if(components.month == 5 && components.day == 5){
        festival = [NSString stringWithFormat:@"%@",ChineseFestival[5]];//端午节
    }else if(components.month == 7 && components.day == 7){
        festival = [NSString stringWithFormat:@"%@",ChineseFestival[7]];//七夕
    }else if(components.month == 8 && components.day == 15){
        festival = [NSString stringWithFormat:@"%@",ChineseFestival[8]];//中秋
    }
    //阳历节日
    if (dateComponents.month == 1 && dateComponents.day == 1) {       //元旦
        festival = [NSString stringWithFormat:@"%@",ChineseFestival[11]];
    }else if(dateComponents.month == 2 && dateComponents.day == 14){  //情人节
        festival = [NSString stringWithFormat:@"%@",ChineseFestival[12]];
    }else if(dateComponents.month == 3 && dateComponents.day == 8){   //妇女节
        festival = [NSString stringWithFormat:@"%@",ChineseFestival[3]];
    }else if(dateComponents.month == 4 && dateComponents.day == 1){   //愚人节
        festival = [NSString stringWithFormat:@"%@",ChineseFestival[13]];
    }else if(dateComponents.month == 5 && dateComponents.day == 1){   //劳动节
        festival = [NSString stringWithFormat:@"%@",ChineseFestival[4]];
    }else if(dateComponents.month == 6 && dateComponents.day == 1){   //儿童节
        festival = [NSString stringWithFormat:@"%@",ChineseFestival[6]];
    }else if(dateComponents.month == 9 && dateComponents.day == 10){  //教师节
        festival = [NSString stringWithFormat:@"%@",ChineseFestival[9]];
    }else if(dateComponents.month == 10 && dateComponents.day == 1){  //国庆节
        festival = [NSString stringWithFormat:@"%@",ChineseFestival[10]];
    }else if(dateComponents.month == 11 && dateComponents.day == 11){ //光棍节
        festival = [NSString stringWithFormat:@"%@",ChineseFestival[14]];
    }else if(dateComponents.month == 12 && dateComponents.day == 24){ //平安夜
        festival = [NSString stringWithFormat:@"%@",ChineseFestival[15]];
    }else if(dateComponents.month == 12 && dateComponents.day == 25){ //圣诞节
        festival = [NSString stringWithFormat:@"%@",ChineseFestival[16]];
    }
    //转换节气
    if ([[self getLunarSpecialDate:dateComponents.year Month:dateComponents.month Day:dateComponents.day] isEqualToString:@"清明节"]) {
        festival = @"清明节";
    }
    
    //除夕另外提出放在所有节日的末尾执行，除夕是在春节前一天，即把components当天时间前移一天，放在所有节日末尾，避免其他节日全部前移一天
    NSTimeInterval timeInterval_day = 60 * 60 * 24;
    NSDate *nextDay_date = [NSDate dateWithTimeInterval:timeInterval_day sinceDate:date];
    NSCalendar *localCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    components = [localCalendar components:unitFlags fromDate:nextDay_date];
    if (1 == components.month && 1 == components.day) {
        festival = [NSString stringWithFormat:@"%@",ChineseFestival[0]];//除夕
    }
    
    return festival;
}
const int START_YEAR = 1901;
const int END_YEAR   = 2050;
static int32_t gLunarHolDay[] =
{
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X79,0X69, 0X78,0X77,   //1901
    0X96,0XA4, 0X96,0X96, 0X97,0X87, 0X79,0X79, 0X79,0X69, 0X78,0X78,   //1902
    0X96,0XA5, 0X87,0X96, 0X87,0X87, 0X79,0X69, 0X69,0X69, 0X78,0X78,   //1903
    0X86,0XA5, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X79, 0X78,0X87,   //1904
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X79,0X69, 0X78,0X77,   //1905
    0X96,0XA4, 0X96,0X96, 0X97,0X97, 0X79,0X79, 0X79,0X69, 0X78,0X78,   //1906
    0X96,0XA5, 0X87,0X96, 0X87,0X87, 0X79,0X69, 0X69,0X69, 0X78,0X78,   //1907
    0X86,0XA5, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X69, 0X78,0X87,   //1908
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X79,0X69, 0X78,0X77,   //1909
    0X96,0XA4, 0X96,0X96, 0X97,0X97, 0X79,0X79, 0X79,0X69, 0X78,0X78,   //1910
    0X96,0XA5, 0X87,0X96, 0X87,0X87, 0X79,0X69, 0X69,0X69, 0X78,0X78,   //1911
    0X86,0XA5, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X69, 0X78,0X87,   //1912
    0X95,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X79,0X69, 0X78,0X77,   //1913
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X79,0X79, 0X79,0X69, 0X78,0X78,   //1914
    0X96,0XA5, 0X97,0X96, 0X97,0X87, 0X79,0X79, 0X69,0X69, 0X78,0X78,   //1915
    0X96,0XA5, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X79, 0X77,0X87,   //1916
    0X95,0XB4, 0X96,0XA6, 0X96,0X97, 0X78,0X79, 0X78,0X69, 0X78,0X87,   //1917
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X79,0X79, 0X79,0X69, 0X78,0X77,   //1918
    0X96,0XA5, 0X97,0X96, 0X97,0X87, 0X79,0X79, 0X69,0X69, 0X78,0X78,   //1919
    0X96,0XA5, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X79, 0X77,0X87,   //1920
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X78,0X79, 0X78,0X69, 0X78,0X87,   //1921
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X79,0X79, 0X79,0X69, 0X78,0X77,   //1922
    0X96,0XA4, 0X96,0X96, 0X97,0X87, 0X79,0X79, 0X69,0X69, 0X78,0X78,   //1923
    0X96,0XA5, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X79, 0X77,0X87,   //1924
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X78,0X79, 0X78,0X69, 0X78,0X87,   //1925
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X79,0X69, 0X78,0X77,   //1926
    0X96,0XA4, 0X96,0X96, 0X97,0X87, 0X79,0X79, 0X79,0X69, 0X78,0X78,   //1927
    0X96,0XA5, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X78, 0X87,0X87,   //1928
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X79, 0X77,0X87,   //1929
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X79,0X69, 0X78,0X77,   //1930
    0X96,0XA4, 0X96,0X96, 0X97,0X87, 0X79,0X79, 0X79,0X69, 0X78,0X78,   //1931
    0X96,0XA5, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X78, 0X87,0X87,   //1932
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X69, 0X78,0X87,   //1933
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X79,0X69, 0X78,0X77,   //1934
    0X96,0XA4, 0X96,0X96, 0X97,0X97, 0X79,0X79, 0X79,0X69, 0X78,0X78,   //1935
    0X96,0XA5, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X78, 0X87,0X87,   //1936
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X69, 0X78,0X87,   //1937
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X79,0X69, 0X78,0X77,   //1938
    0X96,0XA4, 0X96,0X96, 0X97,0X97, 0X79,0X79, 0X79,0X69, 0X78,0X78,   //1939
    0X96,0XA5, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X78, 0X87,0X87,   //1940
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X69, 0X78,0X87,   //1941
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X79,0X69, 0X78,0X77,   //1942
    0X96,0XA4, 0X96,0X96, 0X97,0X97, 0X79,0X79, 0X79,0X69, 0X78,0X78,   //1943
    0X96,0XA5, 0X96,0XA5, 0XA6,0X96, 0X88,0X78, 0X78,0X78, 0X87,0X87,   //1944
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X79, 0X77,0X87,   //1945
    0X95,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X78,0X69, 0X78,0X77,   //1946
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X79,0X79, 0X79,0X69, 0X78,0X78,   //1947
    0X96,0XA5, 0XA6,0XA5, 0XA6,0X96, 0X88,0X88, 0X78,0X78, 0X87,0X87,   //1948
    0XA5,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X79, 0X78,0X79, 0X77,0X87,   //1949
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X78,0X79, 0X78,0X69, 0X78,0X77,   //1950
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X79,0X79, 0X79,0X69, 0X78,0X78,   //1951
    0X96,0XA5, 0XA6,0XA5, 0XA6,0X96, 0X88,0X88, 0X78,0X78, 0X87,0X87,   //1952
    0XA5,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X79, 0X77,0X87,   //1953
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X78,0X79, 0X78,0X68, 0X78,0X87,   //1954
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X79,0X69, 0X78,0X77,   //1955
    0X96,0XA5, 0XA5,0XA5, 0XA6,0X96, 0X88,0X88, 0X78,0X78, 0X87,0X87,   //1956
    0XA5,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X79, 0X77,0X87,   //1957
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X69, 0X78,0X87,   //1958
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X79,0X69, 0X78,0X77,   //1959
    0X96,0XA4, 0XA5,0XA5, 0XA6,0X96, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //1960
    0XA5,0XB4, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X78, 0X87,0X87,   //1961
    0X96,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X69, 0X78,0X87,   //1962
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X79,0X69, 0X78,0X77,   //1963
    0X96,0XA4, 0XA5,0XA5, 0XA6,0X96, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //1964
    0XA5,0XB4, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X78, 0X87,0X87,   //1965
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X69, 0X78,0X87,   //1966
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X79,0X69, 0X78,0X77,   //1967
    0X96,0XA4, 0XA5,0XA5, 0XA6,0XA6, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //1968
    0XA5,0XB4, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X78, 0X87,0X87,   //1969
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X69, 0X78,0X87,   //1970
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X79,0X69, 0X78,0X77,   //1971
    0X96,0XA4, 0XA5,0XA5, 0XA6,0XA6, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //1972
    0XA5,0XB5, 0X96,0XA5, 0XA6,0X96, 0X88,0X78, 0X78,0X78, 0X87,0X87,   //1973
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X69, 0X78,0X87,   //1974
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X78,0X69, 0X78,0X77,   //1975
    0X96,0XA4, 0XA5,0XB5, 0XA6,0XA6, 0X88,0X89, 0X88,0X78, 0X87,0X87,   //1976
    0XA5,0XB4, 0X96,0XA5, 0X96,0X96, 0X88,0X88, 0X78,0X78, 0X87,0X87,   //1977
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X79, 0X78,0X87,   //1978
    0X96,0XB4, 0X96,0XA6, 0X96,0X97, 0X78,0X79, 0X78,0X69, 0X78,0X77,   //1979
    0X96,0XA4, 0XA5,0XB5, 0XA6,0XA6, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //1980
    0XA5,0XB4, 0X96,0XA5, 0XA6,0X96, 0X88,0X88, 0X78,0X78, 0X77,0X87,   //1981
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X79, 0X77,0X87,   //1982
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X78,0X79, 0X78,0X69, 0X78,0X77,   //1983
    0X96,0XB4, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X88,0X78, 0X87,0X87,   //1984
    0XA5,0XB4, 0XA6,0XA5, 0XA6,0X96, 0X88,0X88, 0X78,0X78, 0X87,0X87,   //1985
    0XA5,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X79, 0X77,0X87,   //1986
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X79, 0X78,0X69, 0X78,0X87,   //1987
    0X96,0XB4, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X88,0X78, 0X87,0X86,   //1988
    0XA5,0XB4, 0XA5,0XA5, 0XA6,0X96, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //1989
    0XA5,0XB4, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X79, 0X77,0X87,   //1990
    0X95,0XB4, 0X96,0XA5, 0X86,0X97, 0X88,0X78, 0X78,0X69, 0X78,0X87,   //1991
    0X96,0XB4, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X88,0X78, 0X87,0X86,   //1992
    0XA5,0XB3, 0XA5,0XA5, 0XA6,0X96, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //1993
    0XA5,0XB4, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X78, 0X87,0X87,   //1994
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X76, 0X78,0X69, 0X78,0X87,   //1995
    0X96,0XB4, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X88,0X78, 0X87,0X86,   //1996
    0XA5,0XB3, 0XA5,0XA5, 0XA6,0XA6, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //1997
    0XA5,0XB4, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X78, 0X87,0X87,   //1998
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X69, 0X78,0X87,   //1999
    0X96,0XB4, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X88,0X78, 0X87,0X86,   //2000
    0XA5,0XB3, 0XA5,0XA5, 0XA6,0XA6, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //2001
    0XA5,0XB4, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X78, 0X87,0X87,   //2002
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X69, 0X78,0X87,   //2003
    0X96,0XB4, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X88,0X78, 0X87,0X86,   //2004
    0XA5,0XB3, 0XA5,0XA5, 0XA6,0XA6, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //2005
    0XA5,0XB4, 0X96,0XA5, 0XA6,0X96, 0X88,0X88, 0X78,0X78, 0X87,0X87,   //2006
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X69, 0X78,0X87,   //2007
    0X96,0XB4, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X87,0X78, 0X87,0X86,   //2008
    0XA5,0XB3, 0XA5,0XB5, 0XA6,0XA6, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //2009
    0XA5,0XB4, 0X96,0XA5, 0XA6,0X96, 0X88,0X88, 0X78,0X78, 0X87,0X87,   //2010
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X79, 0X78,0X87,   //2011
    0X96,0XB4, 0XA5,0XB5, 0XA5,0XA6, 0X87,0X88, 0X87,0X78, 0X87,0X86,   //2012
    0XA5,0XB3, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X88,0X78, 0X87,0X87,   //2013
    0XA5,0XB4, 0X96,0XA5, 0XA6,0X96, 0X88,0X88, 0X78,0X78, 0X87,0X87,   //2014
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X79, 0X77,0X87,   //2015
    0X95,0XB4, 0XA5,0XB4, 0XA5,0XA6, 0X87,0X88, 0X87,0X78, 0X87,0X86,   //2016
    0XA5,0XC3, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X88,0X78, 0X87,0X87,   //2017
    0XA5,0XB4, 0XA6,0XA5, 0XA6,0X96, 0X88,0X88, 0X78,0X78, 0X87,0X87,   //2018
    0XA5,0XB4, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X79, 0X77,0X87,   //2019
    0X95,0XB4, 0XA5,0XB4, 0XA5,0XA6, 0X97,0X87, 0X87,0X78, 0X87,0X86,   //2020
    0XA5,0XC3, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X88,0X78, 0X87,0X86,   //2021
    0XA5,0XB4, 0XA5,0XA5, 0XA6,0X96, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //2022
    0XA5,0XB4, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X79, 0X77,0X87,   //2023
    0X95,0XB4, 0XA5,0XB4, 0XA5,0XA6, 0X97,0X87, 0X87,0X78, 0X87,0X96,   //2024
    0XA5,0XC3, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X88,0X78, 0X87,0X86,   //2025
    0XA5,0XB3, 0XA5,0XA5, 0XA6,0XA6, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //2026
    0XA5,0XB4, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X78, 0X87,0X87,   //2027
    0X95,0XB4, 0XA5,0XB4, 0XA5,0XA6, 0X97,0X87, 0X87,0X78, 0X87,0X96,   //2028
    0XA5,0XC3, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X88,0X78, 0X87,0X86,   //2029
    0XA5,0XB3, 0XA5,0XA5, 0XA6,0XA6, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //2030
    0XA5,0XB4, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X78, 0X87,0X87,   //2031
    0X95,0XB4, 0XA5,0XB4, 0XA5,0XA6, 0X97,0X87, 0X87,0X78, 0X87,0X96,   //2032
    0XA5,0XC3, 0XA5,0XB5, 0XA6,0XA6, 0X88,0X88, 0X88,0X78, 0X87,0X86,   //2033
    0XA5,0XB3, 0XA5,0XA5, 0XA6,0XA6, 0X88,0X78, 0X88,0X78, 0X87,0X87,   //2034
    0XA5,0XB4, 0X96,0XA5, 0XA6,0X96, 0X88,0X88, 0X78,0X78, 0X87,0X87,   //2035
    0X95,0XB4, 0XA5,0XB4, 0XA5,0XA6, 0X97,0X87, 0X87,0X78, 0X87,0X96,   //2036
    0XA5,0XC3, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X88,0X78, 0X87,0X86,   //2037
    0XA5,0XB3, 0XA5,0XA5, 0XA6,0XA6, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //2038
    0XA5,0XB4, 0X96,0XA5, 0XA6,0X96, 0X88,0X88, 0X78,0X78, 0X87,0X87,   //2039
    0X95,0XB4, 0XA5,0XB4, 0XA5,0XA6, 0X97,0X87, 0X87,0X78, 0X87,0X96,   //2040
    0XA5,0XC3, 0XA5,0XB5, 0XA5,0XA6, 0X87,0X88, 0X87,0X78, 0X87,0X86,   //2041
    0XA5,0XB3, 0XA5,0XB5, 0XA6,0XA6, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //2042
    0XA5,0XB4, 0X96,0XA5, 0XA6,0X96, 0X88,0X88, 0X78,0X78, 0X87,0X87,   //2043
    0X95,0XB4, 0XA5,0XB4, 0XA5,0XA6, 0X97,0X87, 0X87,0X88, 0X87,0X96,   //2044
    0XA5,0XC3, 0XA5,0XB4, 0XA5,0XA6, 0X87,0X88, 0X87,0X78, 0X87,0X86,   //2045
    0XA5,0XB3, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X88,0X78, 0X87,0X87,   //2046
    0XA5,0XB4, 0X96,0XA5, 0XA6,0X96, 0X88,0X88, 0X78,0X78, 0X87,0X87,   //2047
    0X95,0XB4, 0XA5,0XB4, 0XA5,0XA5, 0X97,0X87, 0X87,0X88, 0X86,0X96,   //2048
    0XA4,0XC3, 0XA5,0XA5, 0XA5,0XA6, 0X97,0X87, 0X87,0X78, 0X87,0X86,   //2049
    0XA5,0XC3, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X78,0X78, 0X87,0X87    //2050
    
};

+ (NSString *)getLunarSpecialDate:(NSInteger)iYear Month:(NSInteger)iMonth  Day:(NSInteger)iDay{
    NSString *solarTerm;
    NSArray *chineseDays = [NSArray arrayWithObjects:
                            @"小寒",@"大寒",@"立春",@"雨水",@"惊蛰",@"春分",
                            @"清明节",@"谷雨",@"立夏",@"小满",@"芒种",@"夏至",
                            @"小暑",@"大暑",@"立秋",@"处暑",@"白露",@"秋分",
                            @"寒露",@"霜降",@"立冬",@"小雪",@"大雪",@"冬至",nil];
    
    long array_index = (iYear - START_YEAR) * 12 + iMonth - 1;
    
    int64_t flag = gLunarHolDay[array_index];
    int64_t day;
    
    if(iDay < 15) {
        day= 15 - ((flag>>4) & 0x0f);
    }else{
        day = ((flag) & 0x0f) + 15;
    }
    
    long index = -1;
    
    if(iDay == day) {
        index = (iMonth - 1) *2 + (iDay > 15?1 : 0);
    }
    
    if (index >= 0 && index < [chineseDays count]) {
        solarTerm = chineseDays[index];
        return solarTerm;
    } else {
        return nil;
    }
}
@end
