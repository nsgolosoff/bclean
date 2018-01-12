//
//  ViewController2.swift
//  WashMe
//
//  Created by Никита Голосов on 22.10.17.
//  Copyright © 2017 Никита Голосов. All rights reserved.
//

import Foundation
import UIKit
class ViewController2: UIViewController,UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tview: UITableView!
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        
        
    {return 2}
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        
        
    {let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = "ячейка"
        cell.backgroundColor = UIColor.clear
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell2?.backgroundView?.backgroundColor = UIColor.clear
      
        cell2?.textLabel?.text = "яч"
        
        return cell2!}
    
override func viewDidLoad() {
    
    
    
    super.viewDidLoad()
tview.backgroundColor = UIColor.clear

    

}
}
