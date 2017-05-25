//
//  FZKECodeSpecificationEg.h
//  Example
//
//  Created by czl on 2017/4/10.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//　5> 宏命名
//全部大写，单词间用 _ 分隔。[不带参数]
#define THIS_IS_AN_MACRO @"THISISAN_MACRO"

//以字母 k 开头，后面遵循大驼峰命名[不带参数]
//大驼峰式命名：每个单词的首字母都采用大写字母。
#define kWidth self.frame.size.width

//小驼峰式命名：第一个单词以小写字母开始，后面的单词的首字母全部大写。[带参数]
#define getImageUrl(url) [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseUrl,url]]

/*
Enum类型的命名与类的命名规则一致

Enum中枚举内容的命名需要以该Enum类型名称开头

　　例子:
*/
typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
    AFNetworkReachabilityStatusUnknown = -1,
    AFNetworkReachabilityStatusNotReachable = 0,
    AFNetworkReachabilityStatusReachableViaWWAN = 1,
    AFNetworkReachabilityStatusReachableViaWiFi = 2
};


/*
 含义清楚，尽量做到不需要注释也能了解其作用，若做不到，就加注释
 　2> 类的命名
 大驼峰式命名：每个单词的首字母都采用大写字母
 　　　例子：MFHomePageViewController
 
 */
@interface FZKECodeSpecificationEg : NSObject

@end

/*
 后缀要求
 　　ViewController: 使用ViewController做后缀
 
 　例子: MFHomeViewController
 
 View: 使用View做后缀
 
 例子: MFAlertView
 
 UITableCell:使用Cell做后缀
 
 例子: MFNewsCell
 
 Protocol: 使用Delegate或者DataSource作为后缀
 
 例子: UITableViewDelegate
 
 UI控件依次类推
*/
@interface FZKExampleViewController : UIViewController


/**
 属性：小驼峰式命名：第一个单词以小写字母开始，后面的单词的首字母全部大写
 　1> 指针 "*" 位置
 　　定义一个对象时，指针 "*" 靠近变量
 属性与属性之间空一行
 属性类型前面加空格
 */
@property (nonatomic,copy) NSString *userName;

@property (nonatomic,assign) NSInteger age;

/**
 在 - 、+ 和 返回值 之间留一个空格，方法名和参数之间不留空格
 Method与Method之间空一行
 */
- (void)sendUser:(NSString *)uer;


- (instancetype)init;
@end

/*
 后缀要求
 Protocol: 使用Delegate或者DataSource作为后缀
 
 例子: UITableViewDelegate
 */
@protocol FZKExampleDelegate <NSObject>

//类的实例必须为回调方法的参数之一, 如
- (void)exampleViewController:(FZKExampleViewController *)exampleViewController;


//使用did和will通知Delegate已经发生的变化或将要发生的变化, 如:
- (void)exampleViewController:(FZKExampleViewController *)exampleViewController willChange:(id)object;
- (void)exampleViewController:(FZKExampleViewController *)exampleViewController didChange:(id)object;

/*
4. 关于UI布局
　使用Interface Builder进行界面布局

　Xib文件的命名与其对应的.h文件保持相同

　Xib文件中控件的组织结构要合理，Xib文件中控件需要有合理的可读性强的命名，方便他人理解
 */

@end

