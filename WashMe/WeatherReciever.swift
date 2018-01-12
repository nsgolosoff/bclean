    import UIKit
    import CoreLocation
    
    public class WeatherReciever: NSObject {
        
        // Define session
        private let urlSession: URLSession = URLSession.shared
        // Define base url's
        private let urlBase5Days = "http://api.openweathermap.org/data/2.5/forecast?"
        private let urlBaseToday = "http://api.openweathermap.org/data/2.5/weather?"
        // Vars to store weather data
        private var weather5DaysData = NSDictionary()
        private var todayWeather = NSDictionary()
        // Flags to handle errors
        private var didFinish5DaysRequest = Bool()
        private var didFinishTodayRequest = Bool()
        public var didRecievedError = false
        
        // Function, whitch gets 5 days forecast data
        private func getWeatherForecast5Days(userLocation: CLLocation) {
            // Construct request body
            let urlRequest = URL(string: urlBase5Days + "lat=" + String(userLocation.coordinate.latitude) + "&lon=" + String(userLocation.coordinate.longitude) + "&APPID=01610a0de7c606bdcb01cda8856e1c35")
            // Go to get data with request
            let task = urlSession.dataTask(with: urlRequest!) { (data, response, errors) -> Void in
                // Check any errors
                if errors != nil {
                    print(errors!.localizedDescription)
                    self.didRecievedError = true
                } else {
                    // Serialise JSON to dictionary
                    do {
                        self.weather5DaysData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                        self.didFinish5DaysRequest = true
                    } catch{
                        print("There was error when trying to serialize response json")
                        self.didRecievedError = true
                    }
                }
            }
            task.resume()
        }
        
        // Function, whitch gets today weather data
        private func getTodayWeather(userLocation: CLLocation) {
            // Construct request body
            let urlRequest = URL(string: urlBaseToday + "lat=" + String(userLocation.coordinate.latitude) + "&lon=" + String(userLocation.coordinate.longitude) + "&APPID=01610a0de7c606bdcb01cda8856e1c35")
            
            // Go to get data with request
            let task = urlSession.dataTask(with: urlRequest!) { (data, response, errors) -> Void in
                // Check any errors
                if errors != nil {
                    print(errors!.localizedDescription)
                    self.didRecievedError = true
                } else {
                    // Serialise JSON to dictionary
                    do {
                        self.todayWeather = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                        self.didFinishTodayRequest = true
                    } catch{
                        print("There was error when trying to serialize response json")
                        self.didRecievedError = true
                    }
                }
            }
            task.resume()
        }
        
        // Interface function to get 5 days water level
        public func getWaterLevel5Days(inLocation userLocation: CLLocation) -> [Double] {
            var rainLevel = [Double]()
            var daysCounter: Int = 0
            var listElementsCounter: Int = 0
            rainLevel.append(0.0)
            didFinish5DaysRequest = false
            
            // Get weather date
            getWeatherForecast5Days(userLocation: userLocation)
            // Wait until response is recieved
            while !didFinish5DaysRequest && !didRecievedError {}
            
            // Parse through JSON structure
            if let forecastList = weather5DaysData["list"] as? NSArray {
                for forecast in forecastList {
                    if let threeHForecast = forecast as? NSDictionary {
                        if let rain = threeHForecast["rain"] as? NSDictionary {
                            if let threeHRain = rain["3h"] as? Double{
                                rainLevel[daysCounter] += threeHRain
                            }
                        }
                    }
                    listElementsCounter += 1
                    // Groups raind values by 8 (for each day)
                    if (listElementsCounter % 8 == 0) && (daysCounter < 5) {
                        daysCounter += 1
                        rainLevel.append(0.0)
                    }
                }
            }
            return rainLevel
        }
        
        // Interface function to today's water level
        public func getTodayWaterLevel(inLocation userLocation: CLLocation) -> Double {
            var rainLevel: Double = 0.0
            didFinishTodayRequest = false
            
            // Get weather date
            getTodayWeather(userLocation: userLocation)
            // Wait until response is recieved
            while !didFinish5DaysRequest && !didRecievedError {}
            
            // Parse through JSON structure
            if let todayRain = todayWeather["rain"] as? NSDictionary {
                if let threeHrain = todayRain["3h"] as? Double{
                    rainLevel = threeHrain
                }
            }
            return rainLevel
        }
    }
    
    
