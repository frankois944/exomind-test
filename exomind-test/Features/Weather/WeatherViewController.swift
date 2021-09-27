//
//  WeatherViewController.swift
//  exomind-test
//
//  Created by macartevacances on 27/09/2021.
//

import UIKit

class WeatherViewController: UIViewController {

    // MARK: - IBoutlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var progressIndicatorView: ButtonProgressBar!
    @IBOutlet weak var messageIndicatorLabel: UILabel!
    
    // MARK: Properties
    
    let presenter: WeatherPresenterContractProtocol = WeatherPresenter(weatherService: WeatherService())
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attach(view: self)
        presenter.loadWeather()
    }
    
    // MARK: - Actions
    
    // MARK: - Cleanup
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if parent == nil {
            // Force the detach for releasing memory
            presenter.detach()
        }
    }
    
    deinit {
        #if DEBUG
        print("DEINIT \(self)")
        #endif
    }
}

// MARK: - UITableViewDataSource

extension WeatherViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.weatherItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCityTableViewCell.identifier, for: indexPath) as! WeatherCityTableViewCell
        cell.fillData(presenter.weatherItems[indexPath.row])
        return cell
    }
}

// MARK: - WeatherViewContractProtocol

extension WeatherViewController: WeatherViewContractProtocol {
    
    func weatherLoaded(items: [WeatherDataObject]) {
        tableView.reloadData()
    }
    
    func progressUpdated(current: Int, total: Int) {
        
    }
}
