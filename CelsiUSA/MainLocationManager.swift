//
//  MainLocationManager.swift
//  CelsiUSA
//
//  Created by Caedmon Myers on 21/6/23.
//

import Foundation
import CoreLocation
import WeatherKit
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published var location: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus
    var onLocationUpdate: ((CLLocation) -> Void)?

    override init() {
        authorizationStatus = locationManager.authorizationStatus
        super.init()

        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
  
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.location = location
            onLocationUpdate?(location)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
}



import Foundation
import CoreLocation
import WeatherKit
import Combine

class WeatherViewModel: ObservableObject {
    private let weatherService = WeatherService.shared
    @Published var weather: Weather?
    @Published var isLoading = true
    private var locationManager: LocationManager
    private var cancellables = Set<AnyCancellable>()
    private var lastUpdateTime: Date?
    private let updateInterval: TimeInterval = 60 // 1 minute

    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        
        locationManager.$location
            .compactMap { $0 }
            .sink { [weak self] location in
                Task { @MainActor in
                    await self?.fetchWeatherIfNeeded(for: location)
                }
            }
            .store(in: &cancellables)
    }

    @MainActor
    func fetchWeatherIfNeeded(for location: CLLocation) async {
        guard shouldUpdate() else { return }
        
        isLoading = true
        do {
            weather = try await weatherService.weather(for: location)
            lastUpdateTime = Date()
        } catch {
            print("Failed to get weather: \(error.localizedDescription)")
        }
        isLoading = false
    }

    func getWeather() async {
        if let location = locationManager.location {
            await fetchWeatherIfNeeded(for: location)
        }
    }

    private func shouldUpdate() -> Bool {
        guard let lastUpdateTime = lastUpdateTime else { return true }
        return Date().timeIntervalSince(lastUpdateTime) >= updateInterval
    }
}

struct CurrentWeather {
    let temperature: Double
    let condition: String
    let symbolName: String
}
