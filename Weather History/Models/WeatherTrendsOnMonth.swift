//
//  WeatherTrendsOnMonth.swift
//  Weather History
//
//  Created by Hanna Karnaukh on 7/28/18.
//  Copyright © 2018 Hanna Karnaukh. All rights reserved.
//

import Foundation

struct WeatherTrendsOnMonth {
    var month: Int
    var maxTemperatureC: Double?
    var minTemperatureC: Double?
    var daysWithAirFrost: Int?
    var rainMm: Double?
    var sunHours: Double?
    
    var isEstimatedMaxTemperatureC: Bool = false
    var isEstimatedMinTemperatureC: Bool = false
    var isEstimatedDaysWithAirFrost: Bool = false
    var isEstimatedRainMm: Bool = false
    var isEstimatedSunHours: Bool = false
    var isSunshineDataFromKippZone: Bool = false
    var isProvisional: Bool = false
    
    var monthSymbol: String? {
        let formatter = DateFormatter()
        var month: String?
        if let months = formatter.monthSymbols {
            month = months[self.month - 1]
        }
        return month
    }
    
    init() {
        month = 0
        maxTemperatureC = 0
        minTemperatureC = 0
        daysWithAirFrost = 0
        rainMm = 0
        sunHours = 0
    }
    
    init(month: Int, maxTemperatureC: Double?, minTemperatureC: Double?, daysWithAirFrost: Int?, rainMm: Double?, sunHours: Double?) {
        self.month = month
        self.maxTemperatureC = maxTemperatureC
        self.minTemperatureC = minTemperatureC
        self.daysWithAirFrost = daysWithAirFrost
        self.rainMm = rainMm
        self.sunHours = sunHours
    }
}
