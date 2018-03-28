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
    
    let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Нажмите на экран для повторной загрузки"
        label.font = UIFont.systemFont(ofSize: 25)
        
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
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
       
        backgroundImage.image = UIImage(named: "loadingScreen.png")
        self.view.insertSubview(backgroundImage, at: 0)
    
        labelconst()
        
        labelanimation()
      
errorLabel.alpha = 0.1

        // Do any additional setup after loading the view.
    }
    
    
    
    // pushtoReload fade in n out animation
    func labelconst () {
           self.view.insertSubview(errorLabel, aboveSubview: backgroundImage)
        
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        errorLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        errorLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        
    }
    func labelanimation () {
        
       
        
        UIView.animate(withDuration: 1.0, animations: {
            self.errorLabel.alpha = 1
            
            
        }, completion: { (Completed: Bool ) -> Void in
        
            UIView.animate(withDuration: 1.0, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
        
            self.errorLabel.alpha = 0.1
                
            }, completion: { (Completed: Bool ) -> Void in
            
            
            
            
            self.labelanimation() })
            
       
        
        })
        
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
