import UIKit
import CoreLocation



class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate{
    

    @IBOutlet weak var tView0: UITableView!
    
    var tabMas = ["",""]
    let separator : UIView = {
        let sep = UIView()
        sep.translatesAutoresizingMaskIntoConstraints = false
        sep.backgroundColor = UIColor.init(white: 1, alpha: 0.2)
        return sep
    }()
    

    var varik: PageViewViewController?

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return tabMas.count
        
    }
    
     public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool
     {return false}
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        
        
        let headerView = UIView()
        
        let headerTitle: UILabel = {
            let label = UILabel()
            label.text = weatherAPI.getLocName()
            label.font = UIFont.boldSystemFont(ofSize: 25)
       
            label.textColor = UIColor.white
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.backgroundColor = .clear
            
            return label
        }()
        
       
        
       
        headerView.addSubview(headerTitle)
        
        headerTitle.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -100).isActive = true
        headerTitle.leftAnchor.constraint(equalTo: headerView.leftAnchor).isActive = true
        headerTitle.rightAnchor.constraint(equalTo: headerView.rightAnchor).isActive = true
        
        
        
        
        
        headerView.backgroundColor = .clear
        return headerView
        
        
        
       
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.frame.height/2.5
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        

//
        
      
        return UIView()
    }
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return view.frame.height/6
//    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        
        
    {
        
       
        
            let cell0 = tableView.dequeueReusableCell(withIdentifier: "cell0", for: indexPath)
        
        let text1: UILabel = {
            let text = UILabel()
            text.text = tabMas[indexPath.row]
            text.textColor = UIColor.init(white: 1, alpha: 0.9)
            text.font = UIFont.systemFont(ofSize: 15)
            
            text.textAlignment = .center
            text.translatesAutoresizingMaskIntoConstraints = false
            text.backgroundColor = .clear
            
          text.numberOfLines = 0
        return text }()
        
     
        
        //addin subviews and constraints for incell elements
        cell0.contentView.addSubview(text1)
        cell0.contentView.addSubview(separator)
        
        text1.topAnchor.constraint(equalTo: cell0.contentView.topAnchor).isActive = true
        text1.bottomAnchor.constraint(equalTo: cell0.contentView.bottomAnchor).isActive = true
        text1.leftAnchor.constraint(equalTo: cell0.contentView.leftAnchor, constant: 30).isActive = true
        text1.rightAnchor.constraint(equalTo: cell0.contentView.rightAnchor, constant: -30).isActive = true
        
        separator.topAnchor.constraint(equalTo: cell0.contentView.topAnchor).isActive = true
        separator.leadingAnchor.constraint(equalTo: cell0.contentView.leadingAnchor, constant: 30).isActive = true
        separator.trailingAnchor.constraint(equalTo: cell0.contentView.trailingAnchor, constant: -30).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
     

        
        

            return cell0
    
 
    }
    

    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    
    
    
    
  

    @IBOutlet weak var logo: UIImageView!
    // Define all labels
    

    

   
        
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var day1Label: UILabel!
  
    @IBOutlet weak var day2Label: UILabel!
    @IBOutlet weak var day3Label: UILabel!
    @IBOutlet weak var day4Label: UILabel!
    @IBOutlet weak var day5Label: UILabel!

   
   
    
   
 
    // Define location manager to grab user coords
    //var didFindLocation : Bool = false
    var locationManager: CLLocationManager?
    public var currentLocation: CLLocation?
    // Create API communicator instance
    let weatherFromAPI = WeatherReciever()
    let weatherAPI = PrecipReciever()
    @IBOutlet weak var Photo: UIImageView!
    

   
   public let utilityQueue = DispatchQueue.global(qos: .utility)
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        

      

             super.viewDidLoad()

  
        
        view.backgroundColor = UIColor.clear
   
        
        tView0.backgroundColor = UIColor.clear
        
        tView0.estimatedRowHeight = 84
        tView0.rowHeight = UITableViewAutomaticDimension
        tView0.alpha = 0
      
        
        
        
        
        
        

        
        
        
        
    
        
        // Define and setup location manager
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager?.distanceFilter = 100
        
        

            locationManager?.startUpdatingLocation()

        

        // Start looking for location in each time app is shown
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationWillEnterForeground, object: nil, queue: OperationQueue.main)
        { [unowned self] notification in
           
                self.locationManager?.startUpdatingLocation()

   
           
            
        }
      
    

        
    
       

        
    }
    
   
    


    

   
    
   
    
    
    
    
    
    // Runs when location manager updates user location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
   
    
      var dif: Double = locations[0].timestamp .timeIntervalSinceNow
        if ((dif > -1)) {
   
           
    let st = CLLocationManager.authorizationStatus()
//            print("DJNDJNDJNDKLNDLKNDLKNDLKNLKDNKLDNKLNDKNDKNDKLNDL")
//            print(st)
            
            
    // Save current location
            
        self.currentLocation = locations[0]
        
//         Deactivate location updating
         locationManager?.stopUpdatingLocation()
     
        print (currentLocation?.timestamp ?? "none")
         print([locations[0].timestamp .timeIntervalSinceNow])
    
        print (currentLocation?.coordinate.latitude ?? "error")
        print (currentLocation?.coordinate.longitude ?? "error")
        print("/n")
            
           // weatherAPI.getLocalKeyFromAPI(userLocation: currentLocation!)
    
          
            
    
        //for testing when calls have expired
            
            let UICount = try? weatherAPI.general(userLocation: currentLocation!)
          
            
            switch UICount {
            case 99?:
               
             
              
             

              varik?.changeBackground2()
                //tabMas[0] = weatherAPI.getLocName()
               // imageMas[0] = #imageLiteral(resourceName: "logo.png")
                tabMas[0] = "Сегодня лучше не мыть"
                tabMas[1] = "Машина останется чистой всего на пару дней"
               // tabMas[3] = weatherAPI.ints()
              RainAnimations()

             CloudsAnimation2()
             
             tView0.reloadData()
                
                
              
                
                
            case 100?:
                
                varik?.changeBackground()
               //imageMas[0] = #imageLiteral(resourceName: "logo.png")
//                tabMas[0] = weatherAPI.getLocName()
                CloudsAnimation()
                tabMas[0] = "Самое время помыть!"
                tabMas[1] = "Машина будет чистой более 5 дней"
               // tabMas[3] = weatherAPI.ints()
              
               
                //lname.text = weatherAPI.getLocName()
                CloudsAnimation()
                tView0.reloadData()
                
            case nil:
            
                let errorView = self.storyboard!.instantiateViewController(withIdentifier: "ErrorViewController")
                self.show(errorView , sender: errorView)
                
                
            default :
                
                varik?.changeBackground()
//                tabMas[0] = weatherAPI.getLocName()
              
                tabMas[0] = "Можно помыть"
                tabMas[1] = "Машина будет чистой 3-4 дня"
                //tabMas[3] = weatherAPI.ints()
            
                //lname.text = weatherAPI.getLocName()
                CloudsAnimation()
                tView0.reloadData()
                
                
 
            }
         
                
           
            
            
            
        //RainAnimations()
           // CloudsAnimation()
            //CloudsAnimation2()
                
                
     // ***************** OLD
 
      
          

            
          
            UIView.animate(withDuration: 1, animations: {
                self.tView0.alpha = 1
            })
            
            
        }
            
       

            
 
    else {
            print (locations[0].timestamp)
        print ( [locations[0].timestamp .timeIntervalSinceNow] )
     print (locations[0].coordinate.latitude)
            print ("error")
        }
        
    
    
}


    // Handle location manager errors
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        // Show error view
        let errorView = self.storyboard!.instantiateViewController(withIdentifier: "ErrorViewController")
        self.show(errorView , sender: errorView)
        print ("location manager throws an error")
       
        
    }
    // Rain Animation
    func RainAnimations() {
        let rain = Rain.get(with: #imageLiteral(resourceName: "logo.png"))
        rain.emitterPosition = CGPoint(x: view.frame.width / 2, y:0)
        rain.emitterSize = CGSize(width: view.frame.width * 4, height:2)
        view.layer.insertSublayer(rain, below: tView0.layer)
        
        
    }
    // Clouds animation
    func CloudsAnimation() {
        let clouds = Clouds.get(with: #imageLiteral(resourceName: "облако1.png"))
        clouds.emitterPosition = CGPoint(x: -view.frame.width, y:70)
        clouds.emitterSize = CGSize(width: view.frame.width, height:2)
        view.layer.insertSublayer(clouds, below: tView0.layer)
        
     }
    
    func CloudsAnimation2() {
        let clouds2 = Clouds2.get(with:#imageLiteral(resourceName: "580b585b2edbce24c47b263e.png"))
        clouds2.emitterPosition = CGPoint(x: -view.frame.width, y:70)
        clouds2.emitterSize = CGSize(width: view.frame.width, height:2)
        view.layer.insertSublayer(clouds2, below: tView0.layer)
       // self.view.layer.insertSublayer(self.avPlayerLayer, below: self.button1.layer)
        
    }
    
    
 /*   func locationManager(_ manager: CLLocationManager,
                                  didChangeAuthorization status: CLAuthorizationStatus)
    
    
    {
        var shouldIAllow = false
        var locationStatus = " "
        switch status {
        case CLAuthorizationStatus.restricted:
            locationStatus = "Restricted Access to location"
        case CLAuthorizationStatus.denied:
            locationStatus = "User denied access to location"
        case CLAuthorizationStatus.notDetermined:
            locationStatus = "Status not determined"
        default:
            locationStatus = "Allowed to location Access"
            shouldIAllow = true
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LabelHasbeenUpdated"), object: nil)
        
        
        
        if (shouldIAllow == true) {
            NSLog("Location to Allowed")
            // Start location services
            locationManager?.startUpdatingLocation()
        } else {
            NSLog("Denied access: \(locationStatus)")

            let alert = UIAlertView(title: "Службы геолокации отключены", message: "Разрешите программе bClean использовать геоданные", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
        }}
    
    */
    
}






