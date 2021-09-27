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
    @IBOutlet weak var messageIndicatorLabel: UILabel!
    @IBOutlet weak var progressIndicatorContainerView: UIView!
    
    // MARK: Properties
    
    let presenter: WeatherPresenterContractProtocol = WeatherPresenter(weatherService: WeatherService())
    private var progressIndicatorView: ButtonProgressBar!
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attach(view: self)
        presenter.loadWeather()
    }
    
    private func initProgressBar() {
        progressIndicatorView = ButtonProgressBar(frame: progressIndicatorContainerView.bounds)
        progressIndicatorContainerView.addSubview(progressIndicatorView)
        progressIndicatorView.addTarget(self, action: #selector(doLoadWeather), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initProgressBar()
    }

    // MARK: - Actions
    
    @IBAction func doLoadWeather(_ sender: Any) {
        presenter.loadWeather()
    }
    
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
        progressIndicatorView.setTitle("Recommencer", for: .normal)
    }
    
    func progressUpdated(current: Int, total: Int) {
        let progress = CGFloat(current) / CGFloat(total)
        progressIndicatorView.setProgress(progress: progress, false)
        progressIndicatorView.setTitle("\(Int(progress * 100)) %", for: .normal)
    }
    
    func showProgressMessage(_ message: String?) {
        messageIndicatorLabel.text = message
    }
}
