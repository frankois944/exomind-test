//
//  WeatherCityTableViewCell.swift
//  exomind-test
//
//  Created by macartevacances on 27/09/2021.
//

import UIKit
import Kingfisher

class WeatherCityTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var skyImageView: UIImageView!

    // MARK: - Properties
    
    static let identifier = "WeatherCity"
    
    // MARK: - Init
    
    override func prepareForReuse() {
        // clear previous image when reusing cell
        skyImageView.image = nil
    }
    
    // MARK: - Data
    
    func fillData(_ data: WeatherDataObject) {
        cityNameLabel.text = data.cityName
        temperatureLabel.text = "\(data.temperature) °C"
        loadIcon(data: data)
    }
    
    private func loadIcon(data: WeatherDataObject) {
        guard let icon = data.skyIconCode else { return }
        // I'm using Kingfisher for remote ressource download, it's easier and cache friendly
        let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
        skyImageView.kf.indicatorType = .activity
        skyImageView.kf.setImage(with: url)
    }
}
