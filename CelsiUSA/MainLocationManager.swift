//
//  MainLocationManager.swift
//  CelsiUSA
//
//  Created by Caedmon Myers on 21/6/23.
//

import Foundation
import CoreLocation
import WeatherKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    
    @Published var location: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus

    override init() {
        authorizationStatus = locationManager.authorizationStatus
        super.init()

        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
  
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
}



class WeatherViewModel: ObservableObject {
    private let weatherService = WeatherService()
    @Published var currentWeather: CurrentWeather?
    @Published var currentLocation: CLLocation?
    
    init() {
        currentLocation = CLLocationManager().location // Assuming you have location data available
        Task {
            await getWeather()
        }
    }

    func getWeather() async {
        do {
            let weather = try await weatherService.weather(for: currentLocation ?? CLLocation(latitude: 0.0, longitude: 0.0))
            self.currentWeather = CurrentWeather(
                temperature: weather.currentWeather.temperature.value,
                condition: weather.currentWeather.condition.rawValue,
                symbolName: weather.currentWeather.symbolName
            )
        } catch {
            print("Failed to get weather: \(error.localizedDescription)")
        }
    }
}

struct CurrentWeather {
    let temperature: Double
    let condition: String
    let symbolName: String
}
