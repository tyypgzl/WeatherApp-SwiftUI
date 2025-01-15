//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Tayyip Güzel on 14.01.2025.
//

import Alamofire
import SwiftUI

@Observable
class WeatherViewModel {
    var loading: Bool = false
    var weather: Weather?
    var error: Error?
    
    var forecastDays: [Forecastday]? {
        weather?.forecast?.forecastday
    }
    
    var currentForecastDay: Forecastday? {
        weather?.forecast?.forecastday?.first
    }
    
    func iconUrl(icon: String? = nil, smallImage: Bool = false) -> URL? {
        if let cdnUrl = icon ?? weather?.current?.condition?.icon {
            let url = "https:\(cdnUrl.replacingOccurrences(of: "64x64", with: smallImage ? "64x64" : "128x128"))"
            return URL.init(string: url)
        } else {
            return nil
        }
    }
    
    func date(epoch: Double?) -> String? {
        if let epoch = epoch {
            return Date(timeIntervalSince1970: TimeInterval(epoch)).formatted(Date.FormatStyle().weekday(.abbreviated))
        } else {
            return nil
        }
    }
    
    var temp: String {
        if let temp = currentForecastDay?.day?.avgtempC {
            return String(temp);
        }
        else {
            return "0"
        }
    }
    
    var text: String? {
        if let text = weather?.current?.condition?.text {
            return String(text);
        }
        else {
            return nil
        }
    }

    func fetchWeather(city: String) {
        let request = AF.request(
            "https://api.weatherapi.com/v1/forecast.json",
            method: .get,
            parameters:
            [
                "key": "5befa58165b34584871123420251401",
                "q": city,
                "days": 3,
                "aqi": "no",
                "alerts": "no",
            ]
        )
        loading = true
        request.responseDecodable(of: Weather.self) { response in
            switch response.result {
            case let .success(weather):
                self.weather = weather
                self.loading = false
                print("Weather: \(weather)")
            case let .failure(error):
                self.error = error
                print("Error: \(error)")
                self.loading = false
            }
        }
    }
}
