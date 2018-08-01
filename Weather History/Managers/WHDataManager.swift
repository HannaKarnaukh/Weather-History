//
//  WHDataManager.swift
//  Weather History
//
//  Created by Hanna Karnaukh on 7/29/18.
//  Copyright © 2018 Hanna Karnaukh. All rights reserved.
//

import Foundation

class WHDataManager {
    //MARK: Singleton
    static let shared = WHDataManager()
    private init() {}
    
    let baseURLString = "https://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/"
    let referencesMeteorologicalStations = ["armaghdata", "bradforddata", "cambornedata", "hurndata", "oxforddata", "sheffielddata", "tireedata", "yeoviltondata"]
    
    //MARK: Controllers
    let weatherOnMonthController = WHTrendsOnMonthController()
    let weatherOnYearController = WHTrendsOnYearController()
    let weatherByLocationController = WHTrendsByLocationController()
}
