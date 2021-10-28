//
//  Location.swift
//  sunnyrainycloudy
//
//  Created by Lin Myat on 22/07/2021.
//

import Foundation
//Singleton Class 
class Location {
    static var sharedInstance = Location()
    private init() { }
    var latitude : Double!
    var longitude : Double!
}
