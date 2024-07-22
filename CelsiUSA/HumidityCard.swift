//
//  HumidityCard.swift
//  Testing Weather App
//
//  Created by Caedmon Myers on 5/24/23.
//

import SwiftUI
import WeatherKit

struct HumidityCard: View {
    @State var weather: Weather?
    
    @State var dewPointF = false
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 2)
                .foregroundColor(.white)
                .shadow(color: .white, radius: 3)
            
            VStack(spacing: 0) {
                HStack {
                    Label("Humidity", systemImage: "humidity.fill")
                        .foregroundColor(.white)
                        .opacity(0.5)
                        .padding(8)
                        .font(.caption)
                    
                    Spacer()
                }
                
                Spacer()
                
                //Text("\(String(format: "%.0f", weather.currentWeather))\(feelsLikeF ? "℉": "°")")
                
                HStack {
                    Spacer()
                    
                    Text("\(Int((weather?.currentWeather.humidity ?? 0) * 100))%")
                    //weather.dailyForecast.first?.precipitation
                    //.padding(7)
                    //.font(.system(size: 50, design: .rounded))
                        .foregroundColor(.white)
                        .font(.system(size: 35, design: .rounded))
                        .bold()
                        .padding(.trailing, 15)
                    
                    Spacer()
                }
                
                Text("The dew point is \(Int(weather?.currentWeather.dewPoint.converted(to: dewPointF ? .fahrenheit: .celsius).value ?? 0))\(dewPointF ? "℉": "°") right now.")
                    .foregroundColor(.white)
                
                
                Spacer()
            }/*.onAppear() {
              var measureres = weather.dailyForecast
              for measure in measureres {
              measurer = Int(weather.dailyForecast.last?.precipitation!) + measurer
              }
              }*/
            
        }
        .padding(.top, 10)
        .onTapGesture(perform: {
            // Here for the long press
        })
        .onLongPressGesture {
            impact.impactOccurred()
            
            dewPointF = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                dewPointF = false
            }
        }
    }
}

struct HumidityCard_Previews: PreviewProvider {
    static var previews: some View {
        HumidityCard()
    }
}
