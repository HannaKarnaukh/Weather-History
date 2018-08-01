//
//  WHWeatherTrendsOnMonthController.swift
//  Weather History
//
//  Created by Hanna Karnaukh on 7/29/18.
//  Copyright © 2018 Hanna Karnaukh. All rights reserved.
//

import Foundation

enum AdditionalProperties: String {
    case isEstimated = "*"
    case isFromKippZone = "#"
    case isMissingData = "---"
    case isProvisional = "Provisional"
}

struct StringBoolValue {
    var string: String
    var bool: Bool
}

class WHTrendsOnMonthController {
    
    func formDataForMonth(monthsWeather: [String]) -> WeatherTrendsOnMonth {
        var weatherForMonth = WeatherTrendsOnMonth()
        var valueIsEstimated: StringBoolValue
        
        for (index, value) in monthsWeather.enumerated() {
            valueIsEstimated = value.isEstimatedValue()
            switch index {
            case ColumnHeaders.month.rawValue:
                weatherForMonth.month = Int(valueIsEstimated.string) ?? 1
                
            case ColumnHeaders.tmax.rawValue:
                weatherForMonth.isEstimatedMaxTemperatureC = valueIsEstimated.bool
                weatherForMonth.maxTemperatureC = Double(valueIsEstimated.string)
                
            case ColumnHeaders.tmin.rawValue:
                weatherForMonth.isEstimatedMinTemperatureC = valueIsEstimated.bool
                weatherForMonth.minTemperatureC = Double(valueIsEstimated.string)
                
            case ColumnHeaders.airFrostDays.rawValue:
                weatherForMonth.isEstimatedDaysWithAirFrost = valueIsEstimated.bool
                weatherForMonth.daysWithAirFrost = Int(valueIsEstimated.string)
                
            case ColumnHeaders.rain.rawValue:
                weatherForMonth.isEstimatedRainMm = valueIsEstimated.bool
                weatherForMonth.rainMm = Double(valueIsEstimated.string)
                
            case ColumnHeaders.sunHours.rawValue:
                var sunHoursValue = valueIsEstimated.string
                weatherForMonth.isEstimatedSunHours = valueIsEstimated.bool
                let valueIsFromKippZone = valueIsEstimated.string.isFromKippZone()
                sunHoursValue = valueIsFromKippZone.string
                weatherForMonth.isSunshineDataFromKippZone = valueIsFromKippZone.bool
                weatherForMonth.sunHours = Double(sunHoursValue)
                
            case ColumnHeaders.provisional.rawValue:
                let cleanValue = String(value.filter { !"\r".contains($0) })
                if cleanValue == AdditionalProperties.isProvisional.rawValue {
                    weatherForMonth.isProvisional = true
                }
            default:
                continue
            }
        }
        return weatherForMonth
    }
}

extension String {
    /** returning value without star */
    func isEstimatedValue() -> StringBoolValue {
        var value = self
        var isEstimeted = false
        value = String(value.filter { !"\r".contains($0) })
        if value.hasSuffix(AdditionalProperties.isEstimated.rawValue) {
            value.removeLast()
            isEstimeted = true
        }
        return StringBoolValue(string: value, bool: isEstimeted)
    }
    
    /** returning value without star */
    func isFromKippZone() -> StringBoolValue {
        var value = self
        var isFromKippZone = false
        if self.hasSuffix(AdditionalProperties.isFromKippZone.rawValue) {
            value.removeLast()
            isFromKippZone = true
        }
        return StringBoolValue(string: value, bool: isFromKippZone)
    }
}
