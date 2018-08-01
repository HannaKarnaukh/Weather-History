//
//  WeatherTrendsOnYear.swift
//  Weather History
//
//  Created by Hanna Karnaukh on 7/28/18.
//  Copyright © 2018 Hanna Karnaukh. All rights reserved.
//

import Foundation

struct WeatherTrendsOnYear {
    var year: Int
    var monthlyWeather: [WeatherTrendsOnMonth]
    
    init(year: Int, monthlyWeather: [WeatherTrendsOnMonth]) {
        self.year = year
        self.monthlyWeather = monthlyWeather
    }
    
    //MARK:- Computing properties
    var maxTemperatureC: Double? {
        let monthWithMaxTC = monthlyWeather.max{a, b in
            if let aMaxT = a.maxTemperatureC, let bMaxT = b.maxTemperatureC {
                return aMaxT > bMaxT
            }
            return false
        }
        guard let montn = monthWithMaxTC else { return nil }
        return montn.maxTemperatureC
    }
    
    var minTemperatureC: Double? {
        let monthWithMinTC = monthlyWeather.min{a, b in
            if let aMaxT = a.maxTemperatureC, let bMaxT = b.maxTemperatureC {
                return aMaxT > bMaxT
            }
            return false
        }
        guard let montn = monthWithMinTC else { return nil }
        return montn.minTemperatureC
    }
        
    var rainMm: Double? {
        return monthlyWeather.reduce(0) {$0 + ($1.rainMm ?? 0)}
    }
}
