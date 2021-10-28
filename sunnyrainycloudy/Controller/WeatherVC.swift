//
//  ViewController.swift
//  sunnyrainycloudy
//
//  Created by Lin Myat on 20/07/2021.
//

import UIKit
import Alamofire
import CoreLocation
class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
   
    
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var currentWeatherLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation : CLLocation!
    
    var currentWeather: CurrentWeather!
    var foreCast : Forecast!
    var foreCasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currentWeather = CurrentWeather()
//        foreCast = Forecast()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        print(CURRENT_WEATHER_URL)
        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        locationAuthStatus()
//    }
    
    
    func locationAuthStatus() {
        if CLLocationManager.locationServicesEnabled() == true {
//            locationManager.requestWhenInUseAuthorization()
//
            //  print(currentLocation.coordinate.latitude, current?Location.coordinate.longitude)
        }else {
            
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func downloadForecastData(complete: @escaping DownloadComplete) {
//        download forecast data for tableview
//        let forecastURL = URL(string: FORECAST_URL)!
        AF.request(FORECAST_URL).responseJSON { response in
            let value = response.value
            if let dict = value as? [String: Any] {
                if let list = dict["list"] as? [[String: Any]] {
                    for obj in list {
                        let forecast = Forecast(dict: obj)
                        self.foreCasts.append(forecast)
                        print(obj)
                    }
                    self.foreCasts.remove(at: 0)
                    self.tableView.reloadData()
                    
                }
                
            }
            complete()
    }
}
   
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foreCasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            let forecast = foreCasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        }else  {
            return WeatherCell()
        }
         
    }
    
    func updateMainUI() {
        dateLbl.text = currentWeather.date
        currentTempLbl.text = "\(currentWeather.currentTemp)"
        currentWeatherLbl.text = currentWeather.weatherType
        locationLbl.text = currentWeather.cityName
        weatherImage.image = UIImage(named: "\(currentWeather.weatherType)")
        
        }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            currentWeather.downloadWeatherDetails { //            UI will setup to load download data
            self.downloadForecastData {
                self.updateMainUI()
            }
        }
        default:
            break
            
            }
        }
    
}

    



