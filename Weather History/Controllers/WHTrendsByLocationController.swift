//
//  WHWeatherTrendsByLocationController.swift
//  Weather History
//
//  Created by Hanna Karnaukh on 7/29/18.
//  Copyright © 2018 Hanna Karnaukh. All rights reserved.
//

import Foundation

enum ColumnHeaders: Int {
    case month = 0, tmax, tmin, airFrostDays, rain, sunHours, provisional
}

class WHTrendsByLocationController {
    
    func readStringFromURL(index: Int, completion: @escaping ((WeatherTrendsByLocation?)) -> Void) {
        guard let url = URL(string: WHDataManager.shared.baseURLString + WHDataManager.shared.referencesMeteorologicalStations[index] + ".txt") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let string = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    self.getWeatherForAllYear(contentFromURL: string) { weatherTrendsOnYear in
                        let fullWether = WeatherTrendsByLocation(location: WHDataManager.shared.referencesMeteorologicalStations[index], yearlyWeather: weatherTrendsOnYear)
                        completion(fullWether)}
                }
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func getWeatherForAllYear(contentFromURL: String, completionHandler: @escaping (([WeatherTrendsOnYear])) -> Void) {
        var oldYear = 0
        var weatherForYears = [WeatherTrendsOnYear]()
        let yearsWeather = contentFromURL.components(separatedBy: "\n")
        
        var parsedYearsData = [[String]]()
        
        for (index, row) in yearsWeather.enumerated() {
            var monthData = parseToColumnsValue(yearData: row)
            guard let currentYear = Int(monthData[0]) else {
                continue
            }
            monthData.removeFirst()
            if currentYear == oldYear {
                parsedYearsData.append(monthData)
            } else {
                if oldYear != 0 {
                weatherForYears.append(WHDataManager.shared.weatherOnYearController.formDataForYear(yearsWeather: parsedYearsData, year: oldYear))
                }
                oldYear = currentYear
                parsedYearsData = [monthData]
            }
            if index == yearsWeather.count - 1 {
                let weatherController = WHDataManager.shared.weatherOnYearController
                let weatherForYear = weatherController.formDataForYear(yearsWeather: parsedYearsData, year: currentYear)
                weatherForYears.append(weatherForYear)
            }
        }
        completionHandler(weatherForYears)
    }
    
    /**Parse row string to columns value in [String]*/
    func parseToColumnsValue (yearData: String) -> [String] {
        var columnsValues = [String]()
        var value = ""
        for (index, sign) in yearData.enumerated() {
            if sign != " " {
                value.append(sign)
            }
            if sign == " " || index == yearData.count - 1 {
                if value != "" {
                    columnsValues.append(value)
                }
                value = ""
            }
        }
        return columnsValues
    }
}
