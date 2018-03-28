//
//  PageViewViewController.swift
//  WashMe
//
//  Created by Никита Голосов on 12.09.17.
//  Copyright © 2017 Никита Голосов. All rights reserved.
//


import UIKit



class PageViewViewController: UIPageViewController, UIPageViewControllerDataSource,UIPageViewControllerDelegate {
    
    var imageView: UIImageView?
   
  
    // setting on all the View controllers
    
    
    
    let separator1: UIView = {
        let sep = UIView()
        sep.translatesAutoresizingMaskIntoConstraints = false
        sep.backgroundColor = .gray
        sep.alpha = 0.25
        return sep
    }()
    
    let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    let backgroundImage2 = UIImageView(frame: UIScreen.main.bounds)
    let weatherIcon: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setImage(#imageLiteral(resourceName: "AW_Stack_RGB"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.alpha = 0.7
        button.addTarget(self, action: #selector (goToWeatherPage), for: .touchUpInside)
        return button
        
    }()
    let InfoIcon: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setImage(#imageLiteral(resourceName: "Slice 1"), for: .normal)
        button.layer.cornerRadius = 17
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 10.0/255, green: 163.0/255, blue: 246.0/255, alpha: 1).cgColor
        button.layer.masksToBounds = true
        button.imageView?.contentMode = .scaleAspectFit
        button.alpha = 1
        button.imageEdgeInsets = UIEdgeInsets(top: 8, left:0 , bottom:8 , right: 0)
        button.setBackgroundColor(color: UIColor.gray.withAlphaComponent(0.35), forState: .highlighted)
        button.addTarget(self, action: #selector (openWalkthru), for: .touchUpInside)
        return button
        
    }()
    
    func openWalkthru() {
 
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let walkThru = WalkThru(collectionViewLayout: layout)
        
        present(walkThru, animated: true, completion: nil)
     
        
    }
    @objc func goToWeatherPage() {
        guard let url = URL(string: "https://www.accuweather.com") else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    

    
    lazy var viewControllerList:[UIViewController] = {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc1 = sb.instantiateViewController(withIdentifier: "mainView") as! ViewController
        vc1.varik = self
        let vc2 = sb.instantiateViewController(withIdentifier: "appinfoView")         
        return [vc1, vc2]
        
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
       
        backgroundImage.image = UIImage(named: "loadingScreen.png")

        
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
 
        
        
        
        
        let pageControl = view.subviews.filter{ $0 is UIPageControl }.first! as! UIPageControl
        //lezt scrollView = view.subviews.filter{ $0 is UIScrollView }.first! as! UIScrollView
        // remove all constraint from view that are tied to pagecontrol
        let const = self.view.constraints.filter { $0.firstItem as? NSObject == pageControl || $0.secondItem as? NSObject == pageControl }
        //
        view.removeConstraints(const)
        //v
        //
        
        pageControl.updateConstraintsIfNeeded()
        
        
        
        //                let pageControl = view.subviews.filter{ $0 is UIPageControl }.first! as! UIPageControl
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        //
        // customize pagecontroll
        
        
        //  contraints and dots setup
        pageControl.backgroundColor = .clear
        pageControl.currentPageIndicatorTintColor = UIColor(red: 10.0/255, green: 163.0/255, blue: 246.0/255, alpha: 1)
        
        if #available(iOS 11.0, *) {
            pageControl.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive=true
            // Fallback on earlier versions
        }
        pageControl.leftAnchor.constraint(equalTo: self.view.leftAnchor,constant: 0).isActive = true
        pageControl.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: 0).isActive = true
        
        pageControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        pageControl.pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.35)
        
        pageControl.isEnabled = false
       
        
        
        
        
        self.view.insertSubview(separator1, aboveSubview: pageControl)
        self.view.insertSubview(weatherIcon, aboveSubview: pageControl)
        self.view.insertSubview(InfoIcon, aboveSubview: pageControl)



        separator1.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -4).isActive=true
        separator1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator1.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        separator1.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true

      
        weatherIcon.leftAnchor.constraint(equalTo: self.view.leftAnchor,constant: 15).isActive = true
        weatherIcon.centerYAnchor.constraint(equalTo: pageControl.centerYAnchor).isActive = true
      
        weatherIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        weatherIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        InfoIcon.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: -15).isActive = true
        InfoIcon.centerYAnchor.constraint(equalTo: pageControl.centerYAnchor).isActive = true
        
        InfoIcon.widthAnchor.constraint(equalToConstant: 34).isActive = true
        InfoIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
      
        
        
        
    }
    
    
    // scrolling through pages functions
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        
        let previousIndex = vcIndex - 1
        //        pageControl.currentPage = previousIndex
        guard previousIndex >= 0 else {return nil}
        
        guard viewControllerList.count > previousIndex else {return nil}
        
        return viewControllerList[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        
        let nextIndex = vcIndex + 1
        
        //        pageControl.currentPage = nextIndex
        guard viewControllerList.count != nextIndex else { return nil}
        
        guard  viewControllerList.count > nextIndex else { return nil }
        
        return viewControllerList[nextIndex]
        
    }
    
    
    
    //     page control dots funcs
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewControllerList.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = viewControllerList.index(of: firstViewController ) else { return 0}
        
        return firstViewControllerIndex
    }
    
    func changeBackground() {
        
        
        backgroundImage2.image = UIImage(named: "main2.png")
      
        backgroundImage2.alpha = 0
       
        self.view.insertSubview(backgroundImage2, aboveSubview: backgroundImage)
        
        self.dataSource = self
        
       
            UIView.animate(withDuration: 1.8, animations: {
            self.backgroundImage2.alpha = 1
            

            })
        
    }
    func changeBackground2() {
        
       
        backgroundImage2.image = UIImage(named: "rainyScreen.png")
        
        backgroundImage2.alpha = 0
        
         self.view.insertSubview(backgroundImage2, aboveSubview: backgroundImage)
        
        self.dataSource = self
        
        
        UIView.animate(withDuration: 1.2, animations: {
            self.backgroundImage2.alpha = 1
            
            
        })
        
       
    }
    
    
}

