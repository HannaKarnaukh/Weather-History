//
//  WHMonthTableViewCell.swift
//  Weather History
//
//  Created by Hanna Karnaukh on 8/1/18.
//  Copyright © 2018 Hanna Karnaukh. All rights reserved.
//

import UIKit

class WHMonthTableViewCell: UITableViewCell {

    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var provisionalLabel: UILabel!
    @IBOutlet weak var maxtStarLabel: UILabel!
    @IBOutlet weak var maxtValueLabel: UILabel!
    @IBOutlet weak var mintStarLabel: UILabel!
    @IBOutlet weak var mintValueLabel: UILabel!
    @IBOutlet weak var airFrostStarLabel: UILabel!
    @IBOutlet weak var airFrostValueLabel: UILabel!
    @IBOutlet weak var rainStarLabel: UILabel!
    @IBOutlet weak var rainValueLabel: UILabel!
    @IBOutlet weak var sunHoursStarLabel: UILabel!
    @IBOutlet weak var sunHoursValueLabel: UILabel!
    @IBOutlet weak var sunHoursHashLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    func setValues(weatherForMonth: WeatherTrendsOnMonth) {
        let missingData = AdditionalProperties.isMissingData.rawValue
        
        monthLabel.text = weatherForMonth.monthSymbol
        provisionalLabel.isHidden = !weatherForMonth.isProvisional
        
        maxtValueLabel.text = weatherForMonth.maxTemperatureC == nil ? missingData : "\(weatherForMonth.maxTemperatureC!)"
        mintValueLabel.text = weatherForMonth.minTemperatureC == nil ? missingData : "\(weatherForMonth.minTemperatureC!)"
        airFrostValueLabel.text = weatherForMonth.daysWithAirFrost == nil ? missingData : "\(weatherForMonth.daysWithAirFrost!)"
        rainValueLabel.text = weatherForMonth.rainMm == nil ? missingData : "\(weatherForMonth.rainMm!)"
        sunHoursValueLabel.text = weatherForMonth.sunHours == nil ? missingData : "\(weatherForMonth.sunHours!)"
        
        maxtStarLabel.isHidden = !weatherForMonth.isEstimatedMaxTemperatureC
        mintStarLabel.isHidden = !weatherForMonth.isEstimatedMinTemperatureC
        airFrostStarLabel.isHidden = !weatherForMonth.isEstimatedDaysWithAirFrost
        rainStarLabel.isHidden = !weatherForMonth.isEstimatedRainMm
        sunHoursStarLabel.isHidden = !weatherForMonth.isEstimatedSunHours
        sunHoursHashLabel.isHidden = !weatherForMonth.isSunshineDataFromKippZone
    }
}
