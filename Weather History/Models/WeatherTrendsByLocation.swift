//
//  WeatherTrendsByLocation.swift
//  Weather History
//
//  Created by Hanna Karnaukh on 7/29/18.
//  Copyright © 2018 Hanna Karnaukh. All rights reserved.
//

import Foundation

struct WeatherTrendsByLocation {
    var location: String
    var yearlyWeather: [WeatherTrendsOnYear]
    
    init(location: String, yearlyWeather: [WeatherTrendsOnYear]) {
        self.location = location
        self.yearlyWeather = yearlyWeather
    }
}
