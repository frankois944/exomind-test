//
//  HomeViewController.swift
//  exomind-test
//
//  Created by macartevacances on 27/09/2021.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: Properties
    
    let presenter: HomePresenterContractProtocol = HomePresenter()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attach(view: self)
    }
    
    // MARK: - Actions
    
    @IBAction func goToshowWeather(_ sender: Any) {
        presenter.goToWeather()
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

// MARK: - Contract

extension HomeViewController: HomeViewContractProtocol {
    
    func navigateToWeatherScreen() {
        performSegue(withIdentifier: "goToshowWeather", sender: nil)
    }
    
}
