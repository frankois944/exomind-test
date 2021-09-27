//
//  WeatherService.swift
//  exomind-test
//
//  Created by macartevacances on 27/09/2021.
//

import Moya
import RxMoya
import RxSwift

class WeatherService: WeatherServiceProtocol {

    var cancellable: Disposable?
    
    func getWeather(cityName: String, delay: Int) -> Observable<WeatherDataObject> {
        return Observable<WeatherDataObject>.create { (producer) -> Disposable in
            let provider = MoyaProvider<OpenWeatherApi>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
            let cancellable = provider.request(.getWeatherFromCity(cityName: cityName)) { moyaResult in
                switch moyaResult {
                case .success(let result):
                    do {
                        let jsonObj = try result.map(GetWeatherFromCityResponse.self)
                        producer.onNext(.init(api: jsonObj))
                    } catch {
                        producer.onError(error)
                    }
                case .failure(let error):
                    producer.onError(error)
                }
                producer.onCompleted()
            }
            return Disposables.create {
                cancellable.cancel()
            }
        }.delay(.seconds(delay), scheduler: MainScheduler.instance)
    }
    
    func getWeathers(citiesName: [String],
                     delay: Int,
                     onProgression: @escaping ((Int, Int) -> Void),
                     onCompletion: @escaping (Result<[WeatherDataObject], Error>) -> Void) {
        
        var arrayWeather = [WeatherDataObject]()
        var currentItem = 0
        let obs = citiesName.map { city in
            getWeather(cityName: city, delay: citiesName.firstIndex(of: city) == 0 ? 0 : delay)
        }
        // cancel previous API request if needed
        cancelGettingData()
        // For chainable API request, using Rx programming is the best solution (and cleanest)
        // Concat run one by one the API call and stop when an error occure
        cancellable = Observable.concat(obs).subscribe { response in
            arrayWeather.append(response)
            currentItem+=1
            onProgression(currentItem, citiesName.count)
        } onError: { [weak self] error in
            onCompletion(.failure(error))
            // stop the download at the first error
            self?.cancelGettingData()
        } onCompleted: {
            onCompletion(.success(arrayWeather))
        } onDisposed: {
        }
    }
    
    func cancelGettingData() {
        cancellable?.dispose()
        cancellable = nil
    }
    
    deinit {
        cancelGettingData()
    }
}
