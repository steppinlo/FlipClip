//
//  TabsViewController.swift
//  FlipClip
//
//  Created by Stephanie Lo on 4/14/16.
//  Copyright © 2016 Stephanie Lo. All rights reserved.
//

import Foundation
import UIKit

class TabsViewController: UITabBarController, UITabBarControllerDelegate {
    var camera: UIViewController!
    var videoList: UIViewController!
    var previouslySelectedIndex: NSInteger!
    var completionHandler:((viewController: TabsViewController) -> Void)? = nil
    
    override func viewDidLoad() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.camera = storyboard.instantiateViewControllerWithIdentifier("Camera")
        self.videoList = storyboard.instantiateViewControllerWithIdentifier("VideoList")
        
        let cameraNav = UINavigationController.init(rootViewController: self.camera)
        let videoListNav = UINavigationController.init(rootViewController: self.videoList)
        
        self.delegate = self
        
        self.setViewControllers([videoListNav, cameraNav], animated: false)
        
    }
    
    func updateTabBarItems() {
        self.camera.tabBarItem = UITabBarItem.init(title: "Camera", image: nil, selectedImage: nil)
        self.videoList.tabBarItem = UITabBarItem.init(title: "VideoList", image: nil, selectedImage: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let completionHandler = self.completionHandler {
            completionHandler(viewController: self)
            self.completionHandler = nil
        }
    }
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        print(viewController.dynamicType)
        if viewController.title == "CameraController" {
            self.performSegueWithIdentifier("showModalView", sender: nil)
            return false
        }
        return true
    }
    
    func selectPreviouslySelectedTab() {
        self.selectedIndex = self.previouslySelectedIndex
        self.selectedViewController = self.viewControllers![self.selectedIndex]
        self.tabBarController(self, didSelectViewController: self.selectedViewController!)
    }
    
    func selectTab(anyClass: AnyClass) -> UIViewController? {
        var targetVC: UIViewController? = nil
        if let viewControllers = self.viewControllers {
            for (index, vc) in viewControllers.enumerate() {
                if let nc = vc as? UINavigationController,
                    let _targetVC = nc.viewControllers.first where _targetVC.dynamicType == anyClass {
                        targetVC = _targetVC
                        self.selectedIndex = index
                        self.selectedViewController = vc
                        self.tabBarController(self, didSelectViewController: self.selectedViewController!)
                        break
                }
            }
        }
        return targetVC
    }
    
//    func selectSearchTabWithPushing(newVC: UIViewController) {
//        if let viewControllers = self.viewControllers {
//            for vc in viewControllers {
//                if let targetNC = vc as? UINavigationController, let _ = targetNC.viewControllers.first as? PTXSearchFilterViewController {
//                    // TODO: @@@ Search and Show results
//                    targetNC.pushViewController(newVC, animated: false)
//                    self.selectTab(PTXSearchFilterViewController)
//                }
//            }
//        }
//    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        if self.selectedIndex > 0 {
            self.previouslySelectedIndex = self.selectedIndex
        }
    }

    
}