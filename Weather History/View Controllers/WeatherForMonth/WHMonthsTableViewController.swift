//
//  WHMonthsTableViewController.swift
//  Weather History
//
//  Created by Hanna Karnaukh on 8/1/18.
//  Copyright © 2018 Hanna Karnaukh. All rights reserved.
//

import UIKit

class WHMonthsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    //var yearsViewController: WHYearsViewController?
    
    var weatherForMonths: [WeatherTrendsOnMonth]? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .done, target: self, action: #selector(buttonInfoPressed))
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "WHMonthTableViewCell", bundle: nil), forCellReuseIdentifier: "WHMonthTableViewCell")
    }
    
    // MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let weatherForMonths = self.weatherForMonths else {
            return 0
        }
        return weatherForMonths.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weatherForMonths = self.weatherForMonths else {
            return tableView.dequeueReusableCell(withIdentifier: "WHMonthTableViewCell", for: indexPath) as! WHMonthTableViewCell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "WHMonthTableViewCell", for: indexPath) as! WHMonthTableViewCell
        
        let weatherByMonth = weatherForMonths[indexPath.row]
        cell.setValues(weatherForMonth: weatherByMonth)
        return cell
    }
    
    @objc func buttonInfoPressed() {
        let infoController = WHInfoViewController(nibName: "WHInfoViewController", bundle: nil)
        infoController.title = "Informations"
        self.navigationController?.pushViewController(infoController, animated: true)
    }
}
