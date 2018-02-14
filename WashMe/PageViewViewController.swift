//
//  PageViewViewController.swift
//  WashMe
//
//  Created by Никита Голосов on 12.09.17.
//  Copyright © 2017 Никита Голосов. All rights reserved.
//

import UIKit

class PageViewViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var imageView: UIImageView?
    
    // setting on all the View controllers
    
    lazy var viewControllerList:[UIViewController] = {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc1 = sb.instantiateViewController(withIdentifier: "mainView")
        let vc2 = sb.instantiateViewController(withIdentifier: "appinfoView")
        
        
        return [vc1, vc2]
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "main1.png")
        self.view.insertSubview(backgroundImage, at: 0)
        self.dataSource = self
        
        
        if let firstViewController = viewControllerList.first {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
            
        }

        
        
    }
    
    
    func addParallaxToView(vw: UIView) {
        let amount = 100
        
        let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontal.minimumRelativeValue = -amount
        horizontal.maximumRelativeValue = amount
        
        let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        vertical.minimumRelativeValue = -amount
        vertical.maximumRelativeValue = amount
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontal, vertical]
        vw.addMotionEffect(group)
    }
    
    
    
    
    // making page control dots transparent
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        for view in self.view.subviews {
            
            
            if view is UIScrollView {
                
                
                view.frame = UIScreen.main.bounds
                
                
                
            } else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
                
               
            }
            
            
            
        }
    }
    
    
    // scrolling through pages functions
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        
        let previousIndex = vcIndex - 1
        
        guard previousIndex >= 0 else {return nil}
        
        guard viewControllerList.count > previousIndex else {return nil}
        
        return viewControllerList[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        
        let nextIndex = vcIndex + 1
        
        
        guard viewControllerList.count != nextIndex else { return nil}
        
        guard  viewControllerList.count > nextIndex else { return nil }
        
        return viewControllerList[nextIndex]
        
    }
    
    
    
    // page control dots funcs
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewControllerList.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = viewControllerList.index(of: firstViewController ) else { return 0 }
        
        return firstViewControllerIndex
    }
}
