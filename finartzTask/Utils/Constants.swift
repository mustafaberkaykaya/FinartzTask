//
//  Constants.swift
//  finartzTask
//
//  Created by Mustafa Berkay Kaya on 17.08.2021.
//
import Foundation

struct Constants {
    struct Urls {
        static func weatherByCity(city: String) -> URL? {
            return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city.escaped())&appid=178b7d9834af2d6aec38784cc9f2d6a2&units=metric")
        }
        
        static func weatherUrlAsStringByIcon(icon: String) -> String {
            return "https://openweathermap.org/img/w/\(icon).png"
        }
    }
}
