//
//  ViewController2.swift
//  WashMe
//
//  Created by Никита Голосов on 22.10.17.
//  Copyright © 2017 Никита Голосов. All rights reserved.
//

import Foundation
import UIKit
class ViewController2: UIViewController {
    
    
    let instaButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.showsTouchWhenHighlighted = true
        button.backgroundColor = .clear
        button.tintColor = .white
        button.setImage(#imageLiteral(resourceName: "glyph-logo_May2016"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        button.addTarget(self, action: #selector (goToInstaPage), for: .touchUpInside)

        return button
        
    
        
    }()
    @objc func goToInstaPage() {
        
        
        
        guard let url = URL(string: "https://www.instagram.com/bcleanapp") else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    let VKButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.backgroundColor = .clear
        button.showsTouchWhenHighlighted = true
        button.tintColor = .white
        button.setImage(#imageLiteral(resourceName: "VK_Logo"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left:-2 , bottom:0 , right: 0)
        button.addTarget(self, action: #selector (goToVKPage), for: .touchUpInside)
        
        return button
        
        
        
    }()
    
    @objc func goToVKPage() {
        
        
        
        guard let url = URL(string: "https://vk.com/bcleanapp") else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    let FBButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.showsTouchWhenHighlighted = true
        button.backgroundColor = .clear
        button.tintColor = .white
        button.setImage(#imageLiteral(resourceName: "FB_logo"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 9, left:0 , bottom:13 , right: 8)
        button.addTarget(self, action: #selector (goToFBPage), for: .touchUpInside)
        
        return button
        
        
        
    }()
    
    
    @objc func goToFBPage() {
        
    
        
        guard let url = URL(string: "https://www.facebook.com/bcleanapp") else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        
    }
    
    
    let contactUS: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 18
        button.layer.borderWidth = 0.5
        button.clipsToBounds = true
        button.backgroundColor = .clear
        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        
        
        
      
        
       
        button.setImage(#imageLiteral(resourceName: "pencil1"), for: .normal)
       
        button.imageView?.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.imageView?.widthAnchor.constraint(equalToConstant: 20).isActive = true
        button.imageView?.leftAnchor.constraint(equalTo: button.leftAnchor, constant: 50).isActive = true
        button.setTitle("Написать разработчикам", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left:0 , bottom:0 , right: 10)
        button.setBackgroundColor(color: UIColor.black.withAlphaComponent(0.05), forState: .highlighted)
        button.tintColor = .white
        

        button.addTarget(self, action: #selector (cntcUs), for: .touchUpInside)
           
        return button
        
    }()
    
 let popUpControl = settupPopUp()
    
    @objc func cntcUs() {
        
        
        popUpControl.callPopUp()
    }
    
   
override func viewDidLoad() {
    
   
    
    super.viewDidLoad()
view.backgroundColor = UIColor.clear
    
    
    setupButtonViews()



    }
    
    
    func setupButtonViews () {
        
        view.addSubview(instaButton)
        view.addSubview(VKButton)
        view.addSubview(FBButton)
        view.addSubview(contactUS)
       
        
        instaButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30).isActive = true
        instaButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        instaButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        instaButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        VKButton.centerYAnchor.constraint(equalTo: instaButton.centerYAnchor).isActive = true
        VKButton.rightAnchor.constraint(equalTo: instaButton.leftAnchor, constant: -30).isActive = true
        VKButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        VKButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        FBButton.centerYAnchor.constraint(equalTo: instaButton.centerYAnchor).isActive = true
        FBButton.leftAnchor.constraint(equalTo: instaButton.rightAnchor, constant: 30).isActive = true
        FBButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        FBButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        contactUS.topAnchor.constraint(equalTo: instaButton.bottomAnchor, constant: 60).isActive = true
        contactUS.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        contactUS.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        contactUS.heightAnchor.constraint(equalToConstant: 50).isActive = true
     
    }
    

}
