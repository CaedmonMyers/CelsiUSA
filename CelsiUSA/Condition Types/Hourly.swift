//
//  Hourly.swift
//  Testing Weather App
//
//  Created by Caedmon Myers on 5/10/23.
//

import SwiftUI
import WeatherKit

let impact = UIImpactFeedbackGenerator(style: .medium)
let softImpact = UIImpactFeedbackGenerator(style: .soft)
let lightImpact = UIImpactFeedbackGenerator(style: .light)

struct Hourly: View {
    @State var loopingWeather: [HourWeather]
    @State var minuteWeather: [MinuteWeather]
    @State var isFahrenheit = false
    @State var presentMenu = false
    var body: some View {
        let gesture = DragGesture(minimumDistance: 0)
            .onChanged { _ in
                self.isFahrenheit = true
            }
            .onEnded { _ in
                self.isFahrenheit = false
            }
        
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(loopingWeather, id:\.self.date) { weatherEntry in
                        VStack {
                            Text(String(DateFormatter.localizedString(from: weatherEntry.date, dateStyle: .none, timeStyle: .short)).replacingOccurrences(of: ":00 ", with: ""))
                            
                            VStack {
                                Spacer()
                                
                                Menu {
                                    Text("\(String(Int(weatherEntry.precipitationChance * 100)))% Chance of Rain")
                                    
                                    Button {
                                        isFahrenheit.toggle()
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                            isFahrenheit.toggle()
                                        }
                                    } label: {
                                        Text("Show Fahrenheit")
                                    }

                                    
                                    //Text("Minute Forecast")
                                } label: {
                                    Image(systemName: weatherEntry.symbolName)
                                        .font(.title)
                                }
                                
                            }
                            
                            Spacer()
                                .frame(height: 10)
                            
                            if !isFahrenheit {
                                Text("\(String(format: "%.0f", weatherEntry.temperature.value))°")
                            }
                            else {
                                Text("\(String(format: "%.0f", weatherEntry.temperature.converted(to: .fahrenheit).value))℉")
                            }
                            
                        }.padding(5)
                            .onTapGesture {
                                presentMenu = true
                            }
                            /*.sheet(isPresented: $presentMenu) {
                                VStack {
                                    ForEach(minuteWeather, id:\.self.date) { minuteEntry in
                                        Text(minuteEntry.precipitation.description)
                                            .foregroundColor(.black)
                                    }
                                }
                            }*/
                    }
                    /*VStack {
                     Image(systemName: weather.hourlyForecast.first!.symbolName)
                     .font(.system(size: 30, design: .rounded))
                     .foregroundColor(.white)
                     
                     Text(String(format: "%.0f", weather.hourlyForecast.last!.temperature.value))
                     Text(String(weather.hourlyForecast.last!.date.description))
                     .font(.title3)
                     .foregroundColor(.white)
                     }*/
                }.padding([.leading, .trailing], 10).padding([.top, .bottom], 5).foregroundColor(.white)
            }
        }
        .onTapGesture {
            // This stays empty to allow the long press gesture to work
        }.onLongPressGesture {
            impact.impactOccurred()
            isFahrenheit.toggle()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                isFahrenheit.toggle()
            }
        }
    }
}

