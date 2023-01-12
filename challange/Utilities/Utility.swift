//
//  Utility.swift
//  kacific-ios
//
//  Created by Sanam on 29/03/2022.
//

import Foundation
import UIKit
import NVActivityIndicatorView



var kApplicationWindow = Utility.getAppDelegate()!.window

@objc class Utility: NSObject {
    
    var window: UIWindow?
    
    
    @objc class func showLoading(offSet: CGFloat = 0, isVisible: Bool = true) {
        
        if let kApplicationWindow = Utility.getAppDelegate(), let window = kApplicationWindow.window {
            if let _ = window.viewWithTag(9000) {
                return
            }
        } else {
            return
        }
        
        let superView = UIView(frame: CGRect(x: 0, y: 0 - offSet, width: kApplicationWindow?.frame.width ?? 0.0, height: kApplicationWindow?.frame.height ?? 0.0))
        let activityIndicator = NVActivityIndicatorView(frame: CGRect(x: superView.frame.width/2 - 32.5, y: superView.frame.height/2 - 32.5, width: 65, height: 65))
        let iconImageView = UIImageView(frame: CGRect(x: superView.frame.width/2 - 32.5, y: superView.frame.height/2 - 32.5, width: 65, height: 65))
        //iconImageView.image = #imageLiteral(resourceName: "loaderLogo")
        
        if isVisible {
            superView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            activityIndicator.color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
        } else {
            superView.backgroundColor = .clear
            activityIndicator.color = .clear
        }
        
        superView.tag = 9000
        activityIndicator.type = .circleStrokeSpin
        activityIndicator.startAnimating()
        superView.addSubview(iconImageView)
        superView.addSubview(activityIndicator)
        superView.bringSubviewToFront(activityIndicator)
        superView.bringSubviewToFront(iconImageView)
        kApplicationWindow?.rootViewController?.topMostViewController().view.addSubview(superView)
        //        kApplicationWindow?.addSubview(superView)
    }
    
    @objc class func hideLoading() {
        let kApplicationWindow = Utility.getAppDelegate()!.window
        if let activityView = kApplicationWindow?.viewWithTag(9000) {
            activityView.removeFromSuperview()
        }
    }
    
    
    
    
    
    class func getAppDelegate() -> SceneDelegate? {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        return sceneDelegate
    }
    
    
    class func getSceneDelegate() -> SceneDelegate? {
        let scenecDelegate = UIApplication.shared.delegate as? SceneDelegate
        return scenecDelegate
    }
    
}
