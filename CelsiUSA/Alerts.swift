//
//  Alerts.swift
//  Pods
//
//  Created by Caedmon Myers on 5/24/23.
//

import SwiftUI
import WeatherKit

struct Alerts: View {
    @State var weather: Weather?
    var body: some View {
        VStack {
            Text(weather?.weatherAlerts?.description ?? "unavailable")
            
            if let weatherAlerts = weather?.weatherAlerts {
                ForEach(weatherAlerts.compactMap { $0 }, id:\.summary) { (oneAlert: WeatherAlert) in
                    Text(oneAlert.summary)
                }
            }
        }
    }
}

struct Alerts_Previews: PreviewProvider {
    static var previews: some View {
        Alerts()
    }
}
