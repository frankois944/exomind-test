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
    var updateMessageTimer: Timer?
    var isLoading = false
    let delayGettingData = 10
    let delayShowProgressMessage: TimeInterval = 6
    let weatherService: WeatherServiceProtocol

    // MARK: Data
    
    private(set) var weatherItems = [WeatherDataObject]()
    
    // MARK: City to search
    
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
        guard isLoading == false else { return }
        isLoading = true
        
        startTimerMessage()
        weatherService.getWeathers(citiesName: cities, delay: delayGettingData) { [weak self] current, total in
            // forward to the view the progression
            self?.view.progressUpdated(current: Double(current) / Double(total))
        } onCompletion: { [weak self] result in
            switch result {
            case .success(let weatherObj):
                self?.forwardSuccess(data: weatherObj)
            case .failure(let error):
                self?.forwardError(error)
            }
            self?.stopTimerMessage()
            self?.isLoading = false
        }
    }
    
    private func forwardSuccess(data: [WeatherDataObject]) {
        weatherItems.removeAll()
        weatherItems.append(contentsOf: data)
        view.weatherLoaded(items: weatherItems)
    }
    
    private func forwardError(_ error: Error) {
        // error should be a human readable message, we need a enum with managed error case (ie: Network error)
        view.showErrorMessage(error)
        view.showProgressMessage(nil)
        view.progressUpdated(current: 0)
        view.weatherLoaded(items: [])
    }
    
    // MARK: - Timer for progress message
    
    private func startTimerMessage() {
        showProgressMessage()
        updateMessageTimer = Timer.scheduledTimer(withTimeInterval: delayShowProgressMessage,
                                                  repeats: true,
                                                  block: { [weak self] timer in
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
        weatherService.cancelGettingData()
        stopTimerMessage()
        view = nil
    }
    
    // MARK: - Cleanup
    
    deinit {
        #if DEBUG
        print("DEINIT \(self)")
        #endif
    }
    
}
