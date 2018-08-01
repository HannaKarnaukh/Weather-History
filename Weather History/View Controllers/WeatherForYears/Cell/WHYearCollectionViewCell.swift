//
//  WHYearCollectionViewCell.swift
//  Weather History
//
//  Created by Hanna Karnaukh on 7/29/18.
//  Copyright © 2018 Hanna Karnaukh. All rights reserved.
//

import UIKit

class WHYearCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var rainMMLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setValues(weatherOnYear: WeatherTrendsOnYear) {
        let missingData = AdditionalProperties.isMissingData.rawValue
        yearLabel.text = "\(weatherOnYear.year) year"
        minTemperatureLabel.text = weatherOnYear.minTemperatureC == nil ? missingData : "\(weatherOnYear.minTemperatureC!)C"
        maxTemperatureLabel.text = weatherOnYear.maxTemperatureC == nil ? missingData : "\(weatherOnYear.maxTemperatureC!)C"
        rainMMLabel.text = weatherOnYear.rainMm == nil ? missingData : "\(weatherOnYear.rainMm!)mm"
    }
    
}
