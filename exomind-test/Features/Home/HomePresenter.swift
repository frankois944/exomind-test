//
//  HomePresenter.swift
//  exomind-test
//
//  Created by macartevacances on 27/09/2021.
//

class HomePresenter: HomePresenterContractProtocol {
    
    // MARK: - Properties
    
    var view: HomeViewContractProtocol!

    // MARK: - Init
    
    init() {
    }
    
    // MARK: - Contract
    
    func goToWeather() {
        view.navigateToWeatherScreen()
    }
    
    // MARK: - MVP attachment
    
    func attach(view: HomeViewContractProtocol) {
        self.view = view
    }
    
    func detach() {
        self.view = nil
    }
    
    // MARK: - Cleanup
    
    deinit {
        #if DEBUG
        print("DEINIT \(self)")
        #endif
    }
}
