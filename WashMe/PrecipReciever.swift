//
//  PrecipReciever.swift
//  WashMe
//
//  Created by MBA-1301 on 17.09.17.
//  Copyright © 2017 Никита Голосов. All rights reserved.
//


import UIKit
import CoreLocation

public class PrecipReciever: NSObject {
    
    // Define session
    private let urlSession: URLSession = URLSession.shared
    // Define base url's
    private let apikey = "eyCaJw62ogy3c387is1GZFoGOGz395zy"
    private let urlLocalKey1 = "http://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=eyCaJw62ogy3c387is1GZFoGOGz395zy&q="
    private let urlLocalKey2 = "&language=ru-ru&details=false&toplevel=false"
    
    
    private let urlCurrent1 = "http://dataservice.accuweather.com/currentconditions/v1/"
    private let urlCurrent2 = "?apikey=eyCaJw62ogy3c387is1GZFoGOGz395zy&language=en-us&details=true"
    
    private let urlForecast1 = "http://dataservice.accuweather.com/forecasts/v1/daily/5day/"
    private let urlForecast2 = "?apikey="
    private let urlForecast3 = "&language=en-us&details=true&metric=true"
    
    // Vars to store weather data
    private var keyData = NSDictionary()
    private var currentData = NSArray()
    private var forecastData = NSDictionary()
    private var fr : NSArray? = nil
    
    
    // Flags to handle errors
    public var didFinishTodayRequest = false
    public var didFinishForecastRequest = false
    public var didFinishKeyRequest = false
    public var didRecievedError = false
    public var didFinishParsingCurrent = false
    public var didFinishParsingForecast = false
    

    
    
    
    public var localkey: String = ""
public var Past24 = Double()
    public var LocName = String()
    
    public var rainforecast = NSArray()
    public var someInts = [Double]()
    public var rainforecast2 = Double()
   
    public var Time1 = Int64()
     public var Time2 = Int64()
    
    private var difference = Double()
    private var Val1 = Double()
    private var Val2 = Double()
    
    public var count = Int()
public var didFinishResult = false
    
    
    
    
    enum PrecipError: Error {
        case connectionError
        case jsonError
  
    }
    
    

    
    // Function, whitch gets Localkey for current location
    public func getLocalKeyFromAPI(userLocation: CLLocation) {
        // Construct request body
        self.didRecievedError = false
         self.didFinishKeyRequest = false
        let urlRequest = URL(string: urlLocalKey1 + String(userLocation.coordinate.latitude) + "%2C" + String(userLocation.coordinate.longitude) + urlLocalKey2)
    
        print (urlRequest)
        // Go to get data with request
        let task = urlSession.dataTask(with: urlRequest!) { (data, response, errors) -> Void in
            // Check any errors
            if errors != nil {
                print(errors!.localizedDescription)
                self.didRecievedError = true
                 self.didFinishKeyRequest = true
          
              
            } else {
                // Serialise JSON to dictionary
                do {
                    print ("data:")
                    print(data)
                    print ("response:")
                    print(response)
                    
                    self.keyData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    
                    
                    if let Key = self.keyData["Key"] as? String{
                        self.localkey = Key
                        
                    } else { self.didRecievedError = true}
                    if let locname = self.keyData["LocalizedName"] as? String {self.LocName = locname}
                    if (self.LocName == "") {if let locname = self.keyData["EnglishName"] as? String {self.LocName = locname} else {self.didRecievedError = true}}
                
                    print(self.localkey)
                    print ("success key")
                   
                    
                    self.didFinishKeyRequest = true
                } catch{
                    print("There was error when trying to serialize response json")
                    self.didRecievedError = true
                    self.didFinishKeyRequest = true
                }
        
            }
            
        }
        
        
        task.resume()
        
        
}

    public func getLocName() -> String
    {
    return self.LocName
    }
    
    
    
    
    public func getCurrent (userLocation: CLLocation) {
    // construct request

        self.didRecievedError = false
        self.didFinishTodayRequest = false
        let urlRequest = URL(string: urlCurrent1 + self.localkey + urlCurrent2)
     
        print ("++++++",  urlRequest)
        
    
        let task = urlSession.dataTask(with: urlRequest!) { (data, response, errors) -> Void in
            // Check any errors
            if errors != nil {
                print(errors!.localizedDescription)
                self.didRecievedError = true
                self.didFinishTodayRequest = true
            } else {
                // Serialise JSON to dictionary
                do {
                
                    // let cData = as? Nsarray если нил, то выкидываем ошибку
                    // если не нил то присваиваем
                    
                    if let currentdata = try JSONSerialization.jsonObject(with: (data)!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray {self.currentData = currentdata}
                    else {self.didRecievedError = true}
           
                 self.didFinishTodayRequest = true
                    }
                catch{
                    print("There was error when trying to serialize response json")
                    self.didRecievedError = true
                    self.didFinishTodayRequest = true
                }
            }

        }
           task.resume()
        
    }
    public func parseCurrent (){
        self.didRecievedError = false
        didFinishParsingCurrent = false
        print ("CURrrrrererererererererent")
        //   print (self.currentData)
        
        if let All = self.currentData[0] as? NSDictionary {
            if let Summary = All ["PrecipitationSummary"] as? NSDictionary {
                if let PastAll = Summary["Past24Hours"] as? NSDictionary {
                    if let PastAllMetric = PastAll["Metric"] as? NSDictionary{
                        
                        self.Past24 = (PastAllMetric["Value"] as? Double)!}
                    else { self.didRecievedError = true}
                    
                }
            
            
                else {self.didRecievedError = true}
            } else {self.didRecievedError = true}
            

            
                    if let time1 = All["EpochTime"] as? Int64 {self.Time1 = time1}
                    else {self.didRecievedError = true}
            
            print (self.Time1)
        } else {self.didRecievedError = true }
        print ("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        print(self.Past24)
        didFinishParsingCurrent = true

        

    
    
    }
    
    private func calculateTime(t1:Int64,t2:Int64) -> Int
    {    let time_dif = ((t1 - t2)/3600)
        var n = Int()
        if (time_dif<9)
        {if (time_dif<1){n = 0}
        else {
            if (time_dif<3){n = 1}
            else {
                if (time_dif<6){n = 3}
                else {n = 6}
            }}}
            
        else {
            if (time_dif<12){n=9} else {
                if(time_dif<18){n=12} else {
                    if (time_dif<24){n=18} else {n=24}
                }}}
        
        print(n)
    return (n)
    }
    
    
    public func parseForecast()
    {
        self.didRecievedError = false
        self.someInts.removeAll()
        self.didFinishParsingForecast = false
     
        if let All = self.forecastData["DailyForecasts"] as? NSArray
        
        {
            if let firstd = All[0] as? NSDictionary
                {if let time2 = firstd["EpochDate"] as? Int64 {self.Time2=time2}
                    else {self.didRecievedError = true}}
                        else {self.didRecievedError = true}
            
        
            print(self.Time2)
     
      if (!self.didRecievedError)
      {
          let n =  calculateTime(t1: self.Time1, t2: self.Time2)
            
            switch n {
                
            case 0:
                print("00")
                if let DayNight = All[0] as? NSDictionary {
                    if let Day = DayNight["Day"] as? NSDictionary {
                        if let Rain = Day["Rain"] as? NSDictionary{
                            if let Val = Rain["Value"] as? Double {
                                self.someInts.append(Val) }}}
                    
                    
                    if let Night = DayNight["Night"] as? NSDictionary {
                        if let Rain = Night["Rain"] as? NSDictionary{
                            if let Val = Rain["Value"] as? Double {
                                self.someInts.append(Val)
                            }}}
                }
                
            case 1:
                print("11")
                if let All = self.currentData[0] as? NSDictionary {
                    if let Summary = All ["PrecipitationSummary"] as? NSDictionary {
                        if let PastAll = Summary["PastHour"] as? NSDictionary {
                            if let PastAllMetric = PastAll["Metric"] as? NSDictionary{
                                
                                self.difference = (PastAllMetric["Value"] as? Double)!}}}}
                
                
                if let DayNight = All[0] as? NSDictionary {
                    if let Day = DayNight["Day"] as? NSDictionary {
                        if let Rain = Day["Rain"] as? NSDictionary{
                            if let Val = Rain["Value"] as? Double {
                                self.Val1 = Val
                            }}}
                    
                    if let Night = DayNight["Night"] as? NSDictionary {
                        if let Rain = Night["Rain"] as? NSDictionary{
                            if let Val = Rain["Value"] as? Double {
                                self.Val2 = Val
                            }}}
                    
                }
                if (self.difference>(self.Val1+self.Val2))
                {self.someInts.append(1)
                    self.someInts.append(1)
                }
                else
                {self.someInts.append(Val1-difference)
                    self.someInts.append(Val2)}

                
                
            default:
                print(n)
                var str = "Past"
                str += String(n)
                str+="Hours"
              print(str)
                if let All = self.currentData[0] as? NSDictionary {
                    if let Summary = All ["PrecipitationSummary"] as? NSDictionary {
                        if let PastAll = Summary[str] as? NSDictionary {
                            if let PastAllMetric = PastAll["Metric"] as? NSDictionary{
                                
                                self.difference = (PastAllMetric["Value"] as? Double)!}}}}
                
                
                if let DayNight = All[0] as? NSDictionary {
                    if let Day = DayNight["Day"] as? NSDictionary {
                        if let Rain = Day["Rain"] as? NSDictionary{
                            if let Val = Rain["Value"] as? Double {
                                self.Val1 = Val
                            }}}
                    
                    if let Night = DayNight["Night"] as? NSDictionary {
                        if let Rain = Night["Rain"] as? NSDictionary{
                            if let Val = Rain["Value"] as? Double {
                                self.Val2 = Val
                                
                                
                                
                            }}}
                    
                }
                if (self.difference>(self.Val1+self.Val2))
                {self.someInts.append(1)
                    self.someInts.append(1)
                }
                else {self.someInts.append(Val1-difference)
                    self.someInts.append(Val2)}
             
            }
        
            for i in 1...4 {
                if let DayNight = All[i] as? NSDictionary {
                    if let Day = DayNight["Day"] as? NSDictionary {
                        if let Rain = Day["Rain"] as? NSDictionary{
                            if let Val = Rain["Value"] as? Double {
                                self.someInts.append(Val) }}}
                    
                    
                    if let Night = DayNight["Night"] as? NSDictionary {
                        if let Rain = Night["Rain"] as? NSDictionary{
                            if let Val = Rain["Value"] as? Double {
                                self.someInts.append(Val)
                                
                                
                            }}}
                    
                }
            }
            
            
   
        }
      
      else {print("parsing forecast error")
            self.didFinishParsingForecast = true}
        print ("forecast")
        print (self.someInts)
        self.didFinishParsingForecast = true
        }
        
        //the following else is for "if let All = self.forecastData"
        else {self.didFinishParsingForecast = true
        self.didRecievedError = true}
        
    }
    
    
    public func getForecast (userLocation: CLLocation)

    {   self.didRecievedError = false
        self.didFinishForecastRequest = false
        

        let urlRequest = URL(string: urlForecast1 + localkey + urlForecast2 + apikey + urlForecast3)
        
    
        
        let task = urlSession.dataTask(with: urlRequest!) { (data, response, errors) -> Void in
            
            // Check any errors
            if errors != nil {
                print(errors!.localizedDescription)
                self.didRecievedError = true
            } else {
                
                // Serialise JSON to dictionary
                do {
                    
                    if let forecastdata = try JSONSerialization.jsonObject(with: (data)!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                    {self.forecastData = forecastdata
                    self.didFinishForecastRequest = true
                    }
                    else {self.didRecievedError = true}
                    
                    
                    
                    
                  
                }
            catch{
                    print("There was error when trying to serialize response json")
                    self.didRecievedError = true
                }
            }
            
        }
        task.resume()
        
        
        
        
        
    }
    
    public func general(userLocation: CLLocation) throws -> Int     {
        
        getLocalKeyFromAPI(userLocation: userLocation)
        while (didFinishKeyRequest == false ) {print ("жду получение ключа")}
        if (self.didRecievedError == true) {
            
            
            print ("ошибка key request")
           throw PrecipError.connectionError}
     
   
        
        getCurrent(userLocation: userLocation)
        getForecast(userLocation: userLocation)
        while (didFinishTodayRequest == false) {print ("жду today request")}
        if (self.didRecievedError == true) {
            print ("ошибка today request")
            throw PrecipError.connectionError}
            
        parseCurrent()
        
        
        while (!didFinishForecastRequest) {print ("жду forecast request")}
        if (self.didRecievedError == true) {
            print ("ошибка forecast request")
            throw PrecipError.connectionError}
        parseForecast()
      
        while ((didFinishParsingCurrent && didFinishParsingForecast) == false )
        {if (didFinishParsingCurrent == false) {print ("жду parsing current")}
            if (didFinishParsingForecast == false) {print("жду parsing forecast")}}
        if (self.didRecievedError == true) {
             print ("ошибка parsing")
            throw PrecipError.connectionError}

            result()
            return self.count
     
    }
    
    public func result() {
        didFinishResult = false
    self.someInts.insert(self.Past24, at: 0)
        print ("result")
        print(self.someInts)
        var sum = Double()
        var sum2 = Double()
        if (someInts[0]>4) {print("говно не мойся, много выпало за 24часа")
        self.count = 99
        } else {
        var newsomeInts = [Double]()
        for i in stride(from: 1, to: 10, by: 2)
        {newsomeInts.append(someInts[i]+someInts[i+1])
        }
            print(newsomeInts)
           
         for m in 0..<newsomeInts.count
         {
            sum += newsomeInts[m]}
        
        if (sum<7) {
            for m in 0..<newsomeInts.count {
                if (newsomeInts[m]>5)
            {print("супер дождь в день, столько дней будет чистой")
                print(m+1)
                self.count = m+1 } }
            print ("больше 5 дней быстро на мойку")
            self.count = 100
        
                    }
            
        else {
            if (sum<15)
        { for m in 0..<newsomeInts.count
        {
            sum2 += newsomeInts[m]
            if (sum2<7){}
            else {
                print(m + 1)
                print("столько дней будет чистой")
                self.count = m+1
                break}
            }
            } else {print("полное говно дождей >15")
            self.count = 99
            }
            }
       
        }
        
       didFinishResult = true
       
    }
    
    public func past24 () -> String
    {return String(self.someInts[0])}
    public func ints () -> String {return String(describing: self.someInts)}
    
    }
