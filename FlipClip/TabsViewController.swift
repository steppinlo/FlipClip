//
//  TabsViewController.swift
//  FlipClip
//
//  Created by Stephanie Lo on 4/14/16.
//  Copyright © 2016 Stephanie Lo. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer
import MobileCoreServices
import AVFoundation

class TabsViewController: UITabBarController, UITabBarControllerDelegate {
    var camera = CameraController()
    var videoList: UIViewController!
    var previouslySelectedIndex: NSInteger!
//    var cameraDelegate: CameraControllerDelegate?
    
    override func viewDidLoad() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.videoList = storyboard.instantiateViewControllerWithIdentifier("VideoList")
        let videoListNav = UINavigationController.init(rootViewController: self.videoList)
        
        self.delegate = self
        
        self.setViewControllers([videoListNav, self.camera], animated: false)
        self.updateTabBarItems()
        
    }
    
    func updateTabBarItems() {
        self.camera.tabBarItem = UITabBarItem.init(title: "Camera", image: UIImage(named: "first"), selectedImage: nil)
        self.videoList.tabBarItem = UITabBarItem.init(title: "VideoList", image: UIImage(named: "second"), selectedImage: nil)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if viewController.classForCoder == CameraController.self {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Camera") as! CameraController
            presentViewController(vc, animated: true, completion: nil)
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