//
//  WHYearsViewController.swift
//  Weather History
//
//  Created by Hanna Karnaukh on 7/29/18.
//  Copyright © 2018 Hanna Karnaukh. All rights reserved.
//

import UIKit
import SDLoader

class WHYearsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    let sdLoader = SDLoader()
    var selectedLocation: Int = 0
    
    var weatherByLocation: WeatherTrendsByLocation? {
        didSet {
            searchingYears = weatherByLocation?.yearlyWeather
        }
    }
    var searchingYears: [WeatherTrendsOnYear]? {
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let locatinName = WHDataManager.shared.referencesMeteorologicalStations[selectedLocation].firstUppercased()
        self.title = locatinName
        readDataFromURL()
        setUpCollectionView()
        setUpSearchBar()
    }
    
    private func readDataFromURL() {
        sdLoader.startAnimating(atView: self.view)
        WHDataManager.shared.weatherByLocationController.readStringFromURL(index: selectedLocation) { weatherTrendsByLocation in
            if weatherTrendsByLocation == nil {
                self.showErrorAlert()
            } else {
                self.weatherByLocation = weatherTrendsByLocation
            }
            self.sdLoader.stopAnimation()
        }
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "WHYearCollectionViewCell" , bundle: nil), forCellWithReuseIdentifier: "WHYearCollectionViewCell")
    }
    
    private func setUpSearchBar() {
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        searchBar.showsCancelButton = true
    }

    private func showErrorAlert() {
        let errorAlert = UIAlertController(title: "", message: "Oops, somesthing went wrong", preferredStyle: .alert)
        self.present(errorAlert, animated: true)
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when){
            errorAlert.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func sortOnYearButtonPressed(_ sender: UIButton) {
        guard let weatherByLocation = self.weatherByLocation else {
            return
        }
        self.weatherByLocation!.yearlyWeather = weatherByLocation.yearlyWeather.reversed()
        collectionView.reloadData()
    }
    
    // MARK: - UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        view.endEditing(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let weatherByLocation = self.weatherByLocation else {
            return
        }
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            searchingYears = weatherByLocation.yearlyWeather
            view.endEditing(true)
            return
        }
        searchingYears = weatherByLocation.yearlyWeather.filter{ String($0.year).contains(searchText)}
    }
    
    // MARK:- UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let searchingYears = self.searchingYears else {
            return 0
        }
        return searchingYears.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let searchingYears = self.searchingYears else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "WHYearCollectionViewCell", for: indexPath) as! WHYearCollectionViewCell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WHYearCollectionViewCell", for: indexPath) as! WHYearCollectionViewCell
        
        let weatherByYear = searchingYears[indexPath.item]
        cell.setValues(weatherOnYear: weatherByYear)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let searchingYears = self.searchingYears else {
            return
        }
        let yearData = searchingYears[indexPath.item]
        let monthController = WHMonthsTableViewController(nibName: "WHMonthsTableViewController", bundle: nil)
        monthController.title = String(yearData.year)
        monthController.weatherForMonths = yearData.monthlyWeather
        self.navigationController?.pushViewController(monthController, animated: true)
    }
    
}
