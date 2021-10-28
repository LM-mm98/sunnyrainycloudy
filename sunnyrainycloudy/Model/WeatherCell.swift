//
//  WeatherCell.swift
//  sunnyrainycloudy
//
//  Created by Lin Myat on 22/07/2021.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTempLbl: UILabel!
    @IBOutlet weak var lowTempLbl: UILabel!
    
    func configureCell(forecast : Forecast){
        lowTempLbl.text = "\(forecast.lowTemp)"
        highTempLbl.text = "\(forecast.highTemp)"
        weatherType.text = forecast.weatherType
        weatherIcon.image = UIImage(named: forecast.weatherType)
        dayLbl.text = forecast.date
    }

}
