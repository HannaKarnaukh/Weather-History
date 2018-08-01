//
//  WHLocationTableViewController.swift
//  Weather History
//
//  Created by Hanna Karnaukh on 8/1/18.
//  Copyright © 2018 Hanna Karnaukh. All rights reserved.
//

import UIKit

class WHLocationTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        setUpTableView()
        self.title = "Meteorological Stations"
        // Do any additional setup after loading the view.
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "WHLocationTableViewCell", bundle: nil), forCellReuseIdentifier: "WHLocationTableViewCell")
    }
    
    // MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WHDataManager.shared.referencesMeteorologicalStations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WHLocationTableViewCell", for: indexPath) as! WHLocationTableViewCell
        let locationName = WHDataManager.shared.referencesMeteorologicalStations[indexPath.row]
        cell.locationNameLabel.text = locationName.firstUppercased()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let yearsController = WHYearsViewController(nibName: "WHYearsViewController", bundle: nil)
        yearsController.selectedLocation = indexPath.row
        self.navigationController?.pushViewController(yearsController, animated: true)
    }
}

extension String {
    func firstUppercased() -> String{
        var value = self
        let first = value.removeFirst()
        let firstUpper = String(first).uppercased()
        value.insert(Character(firstUpper), at: .init(encodedOffset: 0))
        return value
    }
}
