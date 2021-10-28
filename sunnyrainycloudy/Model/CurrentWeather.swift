//
//  CurrentWeather.swift
//  sunnyrainycloudy
//
//  Created by Lin Myat on 21/07/2021.
//

import UIKit
import Alamofire

class CurrentWeather {
    var _cityName : String!
    var _date: String!
    var _weatherType : String!
    var _currentTemp : String!
    
    var cityName : String{
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    var date : String{
        if _date == nil{
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    
    var weatherType : String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    var currentTemp : String{
        if _currentTemp == nil{
            _currentTemp = "0.0"
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(complete: @escaping DownloadComplete){
//        tell AlemoFire where to download from
//        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
//        let request = AF.request(currentWeatherURL)
//        request.responseJSON { [self] response in
        
        AF.request(CURRENT_WEATHER_URL).responseJSON { response in
            let value = response.value
//               print(result)
            if let dict = value as? Dictionary<String, Any> {
                   
                if let name = dict["name"] as? String{
                        self._cityName = name.capitalized
                        print(self._cityName!)
                    }
                    
                if let weather = dict["weather"] as? [[String: Any]]{
                        if let main = weather[0]["main"] as? String{
                            self._weatherType = main.capitalized
                            print(self._weatherType!)
                        }
                    }
                    
                if let main = dict["main"] as? Dictionary<String, Any> {
                        if let currentTemp = main["temp"] as? Double {
                          
                            let kelvinToFarenheitPreDivision = (currentTemp * (9/5) - 459.67)
                            let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                            
                            self._currentTemp = "\(kelvinToFarenheit)°F"
                            print(self._currentTemp!)
                       }
                    }
                }
            complete()
            }
        
        }
    }

