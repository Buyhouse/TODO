//
//  AppDelegate.swift
//  TODO
//
//  Created by Euclid on 2019/4/16.
//  Copyright © 2019 liuxiang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("didFinishLaunchingWithOptions - 应用启动时调用")
        
        //应用在Mac操作系统中的实际位置
        print("应用在Mac操作系统中的实际位置:\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)")
        
        /* iosi系统会为每一个应用程序生成一个私有目录，这个目录位于 MacOS 系统下 iPhone 模拟器文件夹内部，并会随机生成一个字符串作为目录名。
         * 每一次启动应用程序是，这个字母数字串都不同于上一次。
         * 因为应用是在沙箱(sandbox)中，文件读写权限会受到限制，只能在下面几个目录下读写文件：
         **** Documents：应用中用户数据可以放这里，iTunes 备份和恢复的时候会包括此目录。
         **** tmp：存放临时文件，iTunes 不会备份和恢复此目录，此目录下的文件可能会在应用退出后删除。
         **** Library/Caches：存放缓存文件，iTunes 不会备份此目录，此目录下的文件不会在应用退出后被删除。
         */
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        print("applicationWillResignActive - 应用即将进入后台时调用，通常在该方法中执行指令防止用户数据丢失")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("applicationDidEnterBackground - 应用已经进入后台，界面从屏幕消失时调用")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        print("applicationWillEnterForeground - 应用即将进入前台时调用")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("applicationDidBecomeActive - 应用已经进入前台，即屏幕显示为当前应用")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print("applicationWillTerminate - 应用被用户或系统终止运行的时候调用")
    }


}

