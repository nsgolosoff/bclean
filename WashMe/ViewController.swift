import UIKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate{
    
    
    

    @IBOutlet weak var tView0: UITableView!
    
    var tabMas = ["Загрузка", "","","",""]
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        
        
    {return 4}
    
     public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool
     {return false}
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        
        
    {
        if (indexPath.item == 0){
            let cell0 = tableView.dequeueReusableCell(withIdentifier: "cell0", for: indexPath)

            cell0.textLabel?.textColor = UIColor.white
            cell0.textLabel?.adjustsFontSizeToFitWidth = true
            cell0.backgroundColor = UIColor.clear
           cell0.textLabel?.textAlignment = .center
            cell0.textLabel?.text = tabMas[indexPath.item]
            print("0")
            print (indexPath)
            return cell0
        }
       
        else {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        
cell1.textLabel?.textAlignment = .center
            cell1.textLabel?.adjustsFontSizeToFitWidth = true
            
            
        cell1.textLabel?.textColor = UIColor.black
            cell1.backgroundColor = UIColor.clear
    
        cell1.textLabel?.text = tabMas[indexPath.item]
        return cell1
        }
 
    }
    
    
    
    
    
    
    
    
  

    @IBOutlet weak var logo: UIImageView!
    // Define all labels
    

    

   
        
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var day1Label: UILabel!
    @IBOutlet weak var lname: UILabel!
    @IBOutlet weak var day2Label: UILabel!
    @IBOutlet weak var day3Label: UILabel!
    @IBOutlet weak var day4Label: UILabel!
    @IBOutlet weak var day5Label: UILabel!

    @IBOutlet weak var washLabel: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var bClean: UILabel!
    @IBOutlet weak var Line1: UILabel!
    @IBOutlet weak var Line2: UILabel!
   
    
   
 
    // Define location manager to grab user coords
    //var didFindLocation : Bool = false
    var locationManager: CLLocationManager?
    public var currentLocation: CLLocation?
    // Create API communicator instance
    let weatherFromAPI = WeatherReciever()
    let weatherAPI = PrecipReciever()
    @IBOutlet weak var Photo: UIImageView!
    let font = UIFont(name: "Lobster", size: 24)

   
   public let utilityQueue = DispatchQueue.global(qos: .utility)
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        

      

             super.viewDidLoad()

        
  
        view.backgroundColor = UIColor.clear
        tView0.backgroundColor = UIColor.clear
        

        
        
        
        
    
        
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
      
    

        // logo , main text , design lines starting settings
        info.center.y = self.view.frame.width - 40
       bClean.alpha = 0.01
        
        Line1.alpha = 0
        Line2.alpha = 0
        
    
       

        
    }
    
   
    


    
    
    
    
    
    // ANIMATIONS *************
   // logo and main text animation
    func labelanimation () {
        
        UIView.animate(withDuration: 2.0, animations: {
            self.bClean.alpha = 1
            self.info.alpha = 1
            
            
        }, completion: nil)
    }
    
   
    //main text 2nd animation
    
    func infoanimation () {
        
        
        UIView.animate(withDuration: 0.9, delay: 1.3,  animations: {
        
        self.info.center.y = self.view.frame.width - 122
        }, completion: nil)
    
        
    }
    
    // lines animation 
    
    
    func linesanimation () {
    
        
        
        UIView.animate(withDuration: 1, delay: 1.4,  animations: {
          
        self.Line1.alpha = 0.28
            self.Line2.alpha = 0.28
            
        
        }, completion: nil)
    
        
        
        
    }

    
    
   
    
    
    
    
    
    // Runs when location manager updates user location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
   
    
      var dif: Double = locations[0].timestamp .timeIntervalSinceNow
        if ((dif > -1)) {
   
           
    let st = CLLocationManager.authorizationStatus()
            print("DJNDJNDJNDKLNDLKNDLKNDLKNLKDNKLDNKLNDKNDKNDKLNDL")
            print(st)
            
            
    // Save current location
            
        self.currentLocation = locations[0]
        
        // Deactivate location updating
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
               
                tabMas[0] = weatherAPI.getLocName()
                tabMas[1] = "Сегодня лучше не мыть"
                tabMas[3] = weatherAPI.ints()
                
         
             tView0.reloadData()
                

                
                
                
            case 100?:
               
                tabMas[0] = weatherAPI.getLocName()
                tabMas[1] = "Самое время помыть"
                tabMas[3] = weatherAPI.ints()
              
               
                lname.text = weatherAPI.getLocName()
                tView0.reloadData()
                
            case nil:
            
                let errorView = self.storyboard!.instantiateViewController(withIdentifier: "ErrorViewController")
                self.show(errorView , sender: errorView)
                
                
            default :
                
                tabMas[0] = weatherAPI.getLocName()
                tabMas[1] = "Столько дней будет чистой:"
                tabMas[2] = String( UICount!)
                tabMas[3] = weatherAPI.ints()
            
                lname.text = weatherAPI.getLocName()
                tView0.reloadData()
 
            }
         
                

            
                
                
      /* ***************** OLD
       
        // Get weather data with API
        let rainLevels5Days: [Double] = weatherFromAPI.getWaterLevel5Days(inLocation: currentLocation!)
        let todayrainLevel: Double = weatherFromAPI.getTodayWaterLevel(inLocation: currentLocation!)
        
        // Check if there were errors when getting weather data
        if !weatherFromAPI.didRecievedError {
            // Update labels
            if (rainLevels5Days.count >= 5){
                day1Label.text = String(format: "%.3f", rainLevels5Days[0])
                day2Label.text = String(format: "%.3f", rainLevels5Days[1])
                day3Label.text = String(format: "%.3f", rainLevels5Days[2])
                day4Label.text = String(format: "%.3f", rainLevels5Days[3])
                day5Label.text = String(format: "%.3f", rainLevels5Days[4])
            }
            todayLabel.text = String(format: "%.3f", todayrainLevel)
          
          
            
            let sum=rainLevels5Days[0]+rainLevels5Days[1]+rainLevels5Days[2]+rainLevels5Days[3]+rainLevels5Days[4]
            
            let mess1: String="Сегодня отличный день, чтобы помыть машину!"
            let mess2: String="Машина будет чистой несколько дней"
            let mess3: String="Сегодня лучше не мыть машину"
              washLabel.text=String(format: "%.3f", sum)
            info.alpha = 0.1
           
            if (sum<7) {info.text=mess1} else {if (sum<15) {info.text=mess2} else {info.text=mess3}}
            
            
            
        
   
        } else {
            // If there were errors, show error view
            let errorView = self.storyboard!.instantiateViewController(withIdentifier: "ErrorViewController")
            self.show(errorView , sender: errorView)
        }
        
 */
               // labelanimation()
                
             //   infoanimation()
            
            
            
            
            
           //     linesanimation()
            
      
          

            
            
            
        
        
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






