//
//  WeatherPresenter.swift
//  exomind-test
//
//  Created by macartevacances on 27/09/2021.
//

import Foundation

class WeatherPresenter: WeatherPresenterContractProtocol {
    
    // MARK: - Properties
    
    var view: WeatherViewContractProtocol!
    let weatherService: WeatherServiceProtocol
    
    // MARK: Data
    
    private(set) var weatherItems = [WeatherDataObject]()
    private(set) var cities = ["Paris", "Lyon", "Nancy", "Strasbourg", "Nantes"]
    
    // MARK: - Init
    
    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
    }
    
    // MARK: - Contract
    
    func loadWeather() {
        
        weatherService.getWeathers(citiesName: cities, delay: 10) { [weak self] current, total in
            // forward to the ciew the progression
            self?.view.progressUpdated(current: current, total: total)
        } onCompletion: { [weak self] result in
            switch result {
            case .success(let weatherObj):
                self?.weatherItems.removeAll()
                self?.weatherItems.append(contentsOf: weatherObj)
                self?.view.weatherLoaded(items: self?.weatherItems ?? [])
            case .failure(let error):
                break
            }
        }
    }
    
    // MARK: - MVP attachment
    
    func attach(view: WeatherViewContractProtocol) {
        self.view = view
    }
    
    func detach() {
        self.view = nil
        self.weatherService.cancelGettingData()
    }
    
    // MARK: - Cleanup
    
    deinit {
        #if DEBUG
        print("DEINIT \(self)")
        #endif
    }
    
}
