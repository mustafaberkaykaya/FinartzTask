//
//  Store.swift
//  finartzTask
//
//  Created by Mustafa Berkay Kaya on 17.08.2021.
//

import Foundation

class Store: ObservableObject {
    
   
    @Published var weatherList: [WeatherViewModel] = [WeatherViewModel]()
    
    func addWeather(_ weather: WeatherViewModel) {
        weatherList.append(weather)
    }
    
}
