//
//  XVideoUtil.swift
//  XVideoPlayerDemo
//
//  Created by XiaAo on 2021/8/31.
//

import UIKit

class XVideoUtil: NSObject {
    
    class func getTopViewController() -> UIViewController? {
        var topViewController: UIViewController?
        guard var window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {
            return nil
        }
        if window.windowLevel != UIWindow.Level.normal {
            let windows = UIApplication.shared.windows
            for tmpWin in windows {
                if tmpWin.windowLevel == UIWindow.Level.normal {
                    window = tmpWin
                    break
                }
            }
        }
        topViewController = window.rootViewController
        while let presentedVC = topViewController?.presentedViewController {
            topViewController = presentedVC
        }
        if topViewController is UITabBarController {
            topViewController = (topViewController as? UITabBarController)?.selectedViewController
        }
        while topViewController is UINavigationController && (topViewController as? UINavigationController)?.topViewController != nil{
            topViewController = (topViewController as? UINavigationController)?.topViewController
        }
        return topViewController
    }
    
}
