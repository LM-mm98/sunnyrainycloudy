//
//  Forcast.swift
//  sunnyrainycloudy
//
//  Created by Lin Myat on 22/07/2021.
//

import UIKit
import Alamofire

class Forecast {
    var date: String
    var weatherType: String
    var highTemp: String
    var lowTemp: String
    
    init(dict: [String: Any]) {
        let date = dict["dt"] as? Double ?? 0.0
        let unixConvertDate = Date(timeIntervalSince1970: date)
        self.date = unixConvertDate.dayOfTheWeek()
        
        let weather = dict["weather"] as? [[String: Any]]
        let main = weather?[0]["main"] as? String
        self.weatherType = main ?? ""
        
        let tempMain = dict["main"] as? [String: Any] ?? [:]
        let temp_max = tempMain["temp_max"] as? Double ?? 0.0
        let maxKelvinToFarenheitPreDivision = (temp_max * (9/5) - 459.67)
        let maxKelvinToFarenheit = Double(round(10 * maxKelvinToFarenheitPreDivision/10))
        self.highTemp = "\(maxKelvinToFarenheit)°F"
        
        let temp_min = tempMain["temp_min"] as? Double ?? 0.0
        let minKelvinToFarenheitPreDivision = (temp_min * (9/5) - 459.67)
        let minKelvinToFarenheit = Double(round(10 * minKelvinToFarenheitPreDivision/10))
        self.lowTemp = "\(minKelvinToFarenheit)°F"
    }
}

//class Forecast {
//    var _date : String!
//    var _weatherType : String!
//    var _highTemp : String!
//    var _lowTemp : String!
//
//    var date: String{
//        if _date == nil {
//            _date = ""
//        }
//        return _date
//    }
//
//    var weatherType : String{
//        if _weatherType == nil {
//            _weatherType = ""
//        }
//        return _weatherType
//    }
//
//    var highTemp : String{
//        if _highTemp == nil {
//            _highTemp = ""
//        }
//        return _highTemp
//    }
//    var lowTemp : String{
//        if _lowTemp == nil {
//            _lowTemp = ""
//        }
//        return _lowTemp
//    }
//
//    init (weatherDict: Dictionary<String, Any> ) {
//        if let main = weatherDict["main"] as? Dictionary<String, Any> {
//            if let temp_min = main["temp_min"] as? Double{
//                let kelvinToFarenheitPreDivision = (temp_min * (9/5) - 459.67)
//                let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
//
//                self._lowTemp = "\(kelvinToFarenheit)°F"
//            }
//            if let temp_max = main["temp_max"] as? Double{
//                let kelvinToFarenheitPreDivision = (temp_max * (9/5) - 459.67)
//                let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
//
//                self._highTemp = "\(kelvinToFarenheit)°F"
//            }
//        }
//        if let weather = weatherDict["weather"] as? [Dictionary<String, Any>] {
//            if let main = weather[0]["main"] as? String{
//                self._weatherType = main
//            }
//        }
//        if let date = weatherDict["dt"] as? Double {
//            let unixConvertDate = Date(timeIntervalSince1970: date)
//
//            self._date = unixConvertDate.dayOfTheWeek()
//        }
//
//    }
//
//}
extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .full
//        dateFormatter.timeStyle = .full
        dateFormatter.dateFormat = "EEEE, HH:mm"
        return dateFormatter.string(from: self)
    }
}
