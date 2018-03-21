//
//  popUpController.swift
//  WashMe
//
//  Created by Артур on 15.03.2018.
//  Copyright © 2018 Никита Голосов. All rights reserved.
//

import UIKit

class settupPopUp: NSObject {
    
    
    
    let blackview = UIView()
    let iconsMenu : IconsView = {
        let view = IconsView()
        view.backgroundColor = UIColor.init(red: 248.0/255, green: 249.0/255, blue: 244.0/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
       
        return view
    }()
    
    let cancelButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        
        button.layer.cornerRadius = 13
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.setTitleColor(UIColor(red: 10.0/255, green: 163.0/255, blue: 246.0/255, alpha: 1), for: .normal)
        button.tintColor = .white
        button.setBackgroundColor(color: UIColor.gray.withAlphaComponent(0.1), forState: .highlighted)

        return button
    }()
    
  
    
    @objc func callPopUp() {
        
        cancelButton.alpha = 1
        iconsMenu.alpha = 1
        
        if let window = UIApplication.shared.keyWindow {
            
            blackview.backgroundColor = .black
            blackview.alpha = 0
            blackview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector (ColorBack)))
            cancelButton.addTarget(self, action: #selector (ColorBack), for: .touchUpInside)
            
          
            window.addSubview(blackview)
            window.addSubview(iconsMenu)

            window.addSubview(cancelButton)
            
            
            blackview.frame = window.frame

             iconsMenu.frame = CGRect(x: 7, y: window.frame.height, width: window.frame.width-14, height: 150)
          
             cancelButton.frame = CGRect(x: 7, y: window.frame.height+160 , width: window.frame.width-14, height: 50)
          
      cancelButton.layoutIfNeeded()
       
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackview.alpha = 0.3
               

                
                if #available(iOS 11.0, *) {
                    self.cancelButton.bottomAnchor.constraint(equalTo: window.safeAreaLayoutGuide.bottomAnchor,constant: -7).isActive = true
                } else {self.cancelButton.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: -7).isActive = true
                }
                
            

                self.iconsMenu.leftAnchor.constraint(equalTo: window.leftAnchor, constant: 7).isActive = true
                self.iconsMenu.rightAnchor.constraint(equalTo: window.rightAnchor, constant: -7).isActive = true
                self.iconsMenu.heightAnchor.constraint(equalToConstant: 150).isActive = true
                self.iconsMenu.bottomAnchor.constraint(equalTo: self.cancelButton.topAnchor, constant: -7).isActive = true

            

                self.cancelButton.leftAnchor.constraint(equalTo: window.leftAnchor, constant: 7).isActive = true
                self.cancelButton.rightAnchor.constraint(equalTo: window.rightAnchor, constant: -7).isActive = true
                self.cancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
                
             
     
                
                window.layoutIfNeeded()
                
                
            }, completion: nil)
            
        }
        
    }
    
  

    func  ColorBack () {
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            
            self.blackview.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                
                
               
                self.cancelButton.frame = CGRect(x: 7, y: window.frame.height+160 , width: window.frame.width-14, height: 50)

                self.iconsMenu.frame = CGRect(x: 7, y: window.frame.height, width: window.frame.width-14, height: 150)

                window.layoutIfNeeded()
            }
            
         
            
        }) {( completed: Bool) in
            
//            
           self.iconsMenu.alpha = 0
          self.cancelButton.alpha = 0
        }
        
  
    }
    
    
    
    
    
    
    override init() {
        super.init()
       
        

        
    }
 
    
}





