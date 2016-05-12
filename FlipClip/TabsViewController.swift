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
    var profile: UIViewController!
    var previouslySelectedIndex: NSInteger!
//    var cameraDelegate: CameraControllerDelegate?
    
    override func viewDidLoad() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.videoList = storyboard.instantiateViewControllerWithIdentifier("VideoList")
        self.profile = storyboard.instantiateViewControllerWithIdentifier("Profile")
        let videoListNav = UINavigationController.init(rootViewController: self.videoList)
        let profileNav = UINavigationController.init(rootViewController: self.profile)
        
        self.delegate = self
        
        self.setViewControllers([videoListNav, self.camera, profileNav], animated: false)
        self.updateTabBarItems()
        
    }
    
    func updateTabBarItems() {
        self.camera.tabBarItem = UITabBarItem.init(title: "Camera", image: UIImage(named: "first"), selectedImage: nil)
        self.videoList.tabBarItem = UITabBarItem.init(title: "VideoList", image: UIImage(named: "second"), selectedImage: nil)
        self.profile.tabBarItem = UITabBarItem.init(title: "Profile", image: UIImage(named: "second"), selectedImage: nil)
        
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
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        if self.selectedIndex > 0 {
            self.previouslySelectedIndex = self.selectedIndex
        }
    }

    
}