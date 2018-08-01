//
//  WHWeatherTrendsOnYearController.swift
//  Weather History
//
//  Created by Hanna Karnaukh on 7/29/18.
//  Copyright © 2018 Hanna Karnaukh. All rights reserved.
//

import Foundation

class WHTrendsOnYearController {
    
    func formDataForYear(yearsWeather: [[String]], year: Int) -> WeatherTrendsOnYear {
        var weatherForAllMonths = [WeatherTrendsOnMonth]()
        
        for monthWeather in yearsWeather {
            weatherForAllMonths.append(WHDataManager.shared.weatherOnMonthController.formDataForMonth(monthsWeather: monthWeather))
        }
        return WeatherTrendsOnYear(year: year, monthlyWeather: weatherForAllMonths)
    }
}
