//
//  Constants.swift
//  sunnyrainycloudy
//
//  Created by Lin Myat on 21/07/2021.
//

import Foundation
let BASE_URL = "https://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "8efcdd44e185665dd6e981780e952314"

let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=8efcdd44e185665dd6e981780e952314"

typealias DownloadComplete = () -> ()

let FORECAST_URL = "https://api.openweathermap.org/data/2.5/forecast?lat=\(Location.sharedInstance.latitude!)8&lon=\(Location.sharedInstance.longitude!)&appid=8efcdd44e185665dd6e981780e952314"
