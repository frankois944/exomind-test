//
//  WeatherViewController.swift
//  exomind-test
//
//  Created by macartevacances on 27/09/2021.
//

import UIKit

class WeatherViewController: UIViewController, WeatherViewContractProtocol {

    // MARK: Properties
    
    let presenter: WeatherPresenterContractProtocol = WeatherPresenter()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attach(view: self)
    }
    
    // MARK: - Actions
    
    // MARK: - Contract
    
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
