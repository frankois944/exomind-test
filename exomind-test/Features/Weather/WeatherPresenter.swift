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
    var updateMessageTimer: Timer?
    
    private(set) var weatherItems = [WeatherDataObject]()
    
    let cities = ["Rennes", "Paris", "Nantes", "Bordeaux", "Lyon"]
    
    // MARK: Message for progression
    
    var currentMessageIndex = 0
    let message = ["Nous téléchargeons les données…",
                   "C’est presque fini…",
                   "Plus que quelques secondes avant d’avoir le résultat…"]
    
    // MARK: - Init
    
    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
    }
    
    // MARK: - Contract
    
    func loadWeather() {
        startTimerMessage()
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
            self?.stopTimerMessage()
        }
    }
    
    // MARK: - Timer for progress message
    
    private func startTimerMessage() {
        showProgressMessage()
        updateMessageTimer = Timer.scheduledTimer(withTimeInterval: 6, repeats: true, block: { [weak self] timer in
            self?.showProgressMessage()
        })
    }
    
    private func showProgressMessage() {
        view.showProgressMessage(message[currentMessageIndex])
        currentMessageIndex+=1
        if currentMessageIndex >= message.count {
            currentMessageIndex = 0
        }
    }
    
    private func stopTimerMessage() {
        updateMessageTimer?.invalidate()
        updateMessageTimer = nil
        view.showProgressMessage(nil)
    }
    
    // MARK: - MVP attachment
    
    func attach(view: WeatherViewContractProtocol) {
        self.view = view
    }
    
    func detach() {
        self.view = nil
        self.weatherService.cancelGettingData()
        self.stopTimerMessage()
    }
    
    // MARK: - Cleanup
    
    deinit {
        #if DEBUG
        print("DEINIT \(self)")
        #endif
    }
    
}
