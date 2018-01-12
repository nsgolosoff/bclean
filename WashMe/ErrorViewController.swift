//
//  ErrorViewController.swift
//  WashMe
//
//  Created by Никита Голосов on 02.08.17.
//  Copyright © 2017 Никита Голосов. All rights reserved.
//

import UIKit
import CoreLocation

class ErrorViewController: UIViewController {
    
// defining the labels
    @IBOutlet weak var PushToReloadbutton: UILabel!
    
    
    
    override func viewDidLoad() {
      if (!Reachability.isConnectedToNetwork()){
            let alert = UIAlertView(title: "Интернет недоступен :(", message: "Проверьте соединение с интернетом и попробуйте снова", delegate: nil, cancelButtonTitle: "OK")
            alert.show()}
    
        let status = CLLocationManager.authorizationStatus()
        
        if(status != CLAuthorizationStatus.authorizedWhenInUse) {
            let alert = UIAlertView(title: "Службы геолокации недоступны", message: "Проверьте настройки геолокации и повторите снова", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
      
        }
        
        
        super.viewDidLoad()
        labelanimation()
      
PushToReloadbutton.alpha = 0.1

        // Do any additional setup after loading the view.
    }
    
    
    
    // pushtoReload fade in n out animation
    
    func labelanimation () {
        
       
        
        UIView.animate(withDuration: 1.25, animations: {
            self.PushToReloadbutton.alpha = 0.8
            
            
        }, completion: { (Completed: Bool ) -> Void in
        
            UIView.animate(withDuration: 1.25, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
        
            self.PushToReloadbutton.alpha = 0.1
                
            }, completion: { (Completed: Bool ) -> Void in
            
            
            
            
            self.labelanimation() })
            
       
        
        })
        
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
