//
//  Daily.swift
//  Testing Weather App
//
//  Created by Caedmon Myers on 5/11/23.
//

import SwiftUI
import WeatherKit

struct Daily: View {
    @State var loopingWeather: [DayWeather]
    @State var isFahrenheit = false
    
    @State var isPortrait = true
    
    @State var offsetX = CGFloat(0)
    @State var offset = CGSize.zero
    
    var body: some View {
        let gesture = DragGesture(minimumDistance: 0)
            .onChanged { _ in
                self.isFahrenheit = true
            }
            .onEnded { _ in
                self.isFahrenheit = false
            }
        
        VStack {
                VStack(spacing: 0) {
                    ForEach(loopingWeather, id:\.self.date) { weatherEntry in
                        HStack(spacing: 0) {
                            HStack {
                                //Text(String(DateFormatter.localizedString(from: weatherEntry.date, dateStyle: .none, timeStyle: .short)).replacingOccurrences(of: ":00 ", with: ""))
                                
                                Text(weekFormatter.string(from: weatherEntry.date))
                                    //.font(.caption)
                                
                                /*VStack {
                                    Spacer()
                                    
                                    Image(systemName: weatherEntry.symbolName)
                                        .font(.title)
                                    
                                }*/
                                
                                
                                /*if !isFahrenheit {
                                 Text("\(String(format: "%.0f", weatherEntry.temperature.value))°")
                                 }
                                 else {
                                 Text("\(String(format: "%.0f", weatherEntry.temperature.converted(to: .fahrenheit).value))℉")
                                 }*/
                                Spacer()
                            }.frame(width: 120)
                            
                            
                            
                            /*Color.white
                                .frame(width: 1, height: .infinity)
                                .shadow(color: .white, radius: 3)*/
                            
                            Spacer()
                            
                            Group {
                                Spacer()
                                    .frame(width: 7)
                                
                                Text("\(String(format: "%.0f", weatherEntry.lowTemperature.converted(to: abs(offset.width) == 10 ? .fahrenheit: .celsius).value))\(abs(offset.width) == 10 ? "°": "°")")
                                    .opacity(0.5)
                                
                                Spacer()
                                    .frame(width: 5)
                                
                                //Text("\(String(format: "%.0f", weatherEntry.highTemperature.converted(to: isPortrait ? offset.width == -210 ? .fahrenheit: .celsius: offset.width == -475 ? .fahrenheit: .celsius).value))°")
                                
                                Text("\(String(format: "%.0f", weatherEntry.highTemperature.converted(to: abs(offset.width) == 10 ? .fahrenheit: .celsius).value))\(abs(offset.width) == 10 ? "°": "°")")
                                
                                Spacer()
                                    .frame(width: 7)
                            }
                            
                            
                            /*Color.white
                                .frame(width: 1, height: .infinity)
                                .shadow(color: .white, radius: 3)*/
                            
                            HStack {
                                Spacer()
                                
                                
                                
                                
                                // The thingy you were working on
                                
                                Menu {
                                    if isPortrait && UIDevice.current.userInterfaceIdiom != .pad && UIDevice.current.userInterfaceIdiom != .mac {
                                        infoThing2(lowTemp: Int(weatherEntry.lowTemperature.value), highTemp: Int(weatherEntry.highTemperature.value))
                                    }
                                    
                                    Text("\(String(Int(weatherEntry.precipitationChance * 100)))%")
                                    
                                    Button {
                                        impact.impactOccurred()
                                        offset.width = 10
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                            offset.width = 0
                                        }
                                    } label: {
                                        Text("Show Fahrenheit")
                                    }
                                    
                                } label: {
                                    if !isPortrait || UIDevice.current.userInterfaceIdiom != .phone {
                                        infoThing2(lowTemp: Int(weatherEntry.lowTemperature.value), highTemp: Int(weatherEntry.highTemperature.value))
                                    }
                                    else {
                                        Image(systemName: "info.circle")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 25)
                                    }
                                }

                                /*if isPortrait {
                                    Menu {
                                        infoThing2(lowTemp: Int(weatherEntry.lowTemperature.value), highTemp: Int(weatherEntry.highTemperature.value))
                                        Button {
                                            impact.impactOccurred()
                                            offset.width = 10
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                                offset.width = 0
                                            }
                                        } label: {
                                            Text("Show Fahrenheit")
                                        }

                                    } label: {
                                        Image(systemName: "info.circle")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 25)
                                    }
                                }
                                else {
                                    infoThing(lowTemp: Int(weatherEntry.lowTemperature.value), highTemp: Int(weatherEntry.highTemperature.value))
                                        .frame(width: 200)
                                }*/
                                
                                
                                
                                Spacer()
                                
                            }.frame(width: !isPortrait ? 350: 75)
                            
                            /*Color.white
                                .frame(width: 1, height: .infinity)
                                .shadow(color: .white, radius: 3)*/
                            
                            HStack {
                                Spacer()
                                    //.frame(width: 15)
                                
                                Group {
                                    VStack {
                                        Spacer()
                                        
                                        Image(systemName: weatherEntry.symbolName)
                                            .font(.title)
                                            .opacity(offset.width != 0 ? 0.5: 1.0)
                                            .offset(x: offset.width)
                                            .animation(.spring(response: 0.5, dampingFraction: 0.9, blendDuration: 0))
                                            .gesture(
                                                DragGesture()
                                                    .onChanged { value in
                                                        let threshold: CGFloat = 10
                                                        if abs(value.translation.width) > threshold {
                                                            self.offset.width = min(max(value.translation.width, -10), 10)
                                                            
                                                        }
                                                    }
                                                    .onEnded { value in
                                                        let threshold: CGFloat = 10
                                                        lightImpact.impactOccurred()
                                                        if abs(value.translation.width) > threshold {
                                                            impact.impactOccurred()
                                                            
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                                                offset.width = 0
                                                            }
                                                        }
                                                        /*withAnimation {
                                                            self.offset = .zero
                                                        }*/
                                                    }
                                            )
                                        
                                    }
                                }
                                
                                Spacer()
                                    //.frame(width: 15)
                            }.frame(width: 60)
                            
                        }.padding(0).padding(.leading, 10)
                        
                        if weatherEntry.date < Date(timeIntervalSinceNow: 700000) {
                            Color.white
                                .frame(width: .infinity, height: 1)
                                .shadow(color: .white, radius: 3)
                        }
                        
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
                }.foregroundColor(.white)//.padding([.leading, .trailing], 10).padding([.top, .bottom], 5).foregroundColor(.white)
            
        }.onTapGesture {
            // This stays empty to allow the long press gesture to work
        }.onLongPressGesture {
            //impact.impactOccurred()
            //isFahrenheit.toggle()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            if UIDevice.current.orientation.rawValue <= 4 { // This will run code only on Portrait and Landscape changes
                guard let scene = UIApplication.shared.windows.first?.windowScene else { return }
                self.isPortrait = scene.interfaceOrientation.isPortrait
            }
        }
    }
    let weekFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE" // "EEEE" represents the full day of the week
            return formatter
        }()
}


struct infoThing: View {
    @State var lowTemp: Int
    @State var highTemp: Int
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.userInterfaceIdiom == .mac || UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            HStack {
                if (lowTemp+highTemp)/2 >= 11 && (lowTemp+highTemp)/2 <= 20 {
                    Text(cooler[Int.random(in: 0..<4)])
                }
                else if (lowTemp+highTemp)/2 >= 21 && (lowTemp+highTemp)/2 <= 30 {
                    Text(warm[Int.random(in: 0..<4)])
                }
                else if (lowTemp+highTemp)/2 >= 31 && (lowTemp+highTemp)/2 <= 40 {
                    Text(hot[Int.random(in: 0..<4)])
                }
                else if (lowTemp+highTemp)/2 >= 41 && (lowTemp+highTemp)/2 <= 50 {
                    Text(death[Int.random(in: 0..<4)])
                }
                else if (lowTemp+highTemp)/2 >= 1 && (lowTemp+highTemp)/2 <= 10 {
                    Text(cool[Int.random(in: 0..<4)])
                }
                else if (lowTemp+highTemp)/2 >= -9 && (lowTemp+highTemp)/2 <= 0 {
                    Text(cold[Int.random(in: 0..<4)])
                }
                else if (lowTemp+highTemp)/2 >= -19 && (lowTemp+highTemp)/2 <= -10 {
                    Text(almostFrigid[Int.random(in: 0..<4)])
                }
                else if (lowTemp+highTemp)/2 >= -29 && (lowTemp+highTemp)/2 <= -20 {
                    Text(frigid[Int.random(in: 0..<4)])
                }
                else if (lowTemp+highTemp)/2 >= -39 && (lowTemp+highTemp)/2 <= -30 {
                    Text(frigid[Int.random(in: 0..<4)])
                }
                else {
                    Text(frigid[Int.random(in: 0..<4)])
                }
            }
        }
        
        else {
                if (lowTemp+highTemp)/2 >= 11 && (lowTemp+highTemp)/2 <= 20 {
                    Text(cooler[Int.random(in: 0..<4)])
                }
                else if (lowTemp+highTemp)/2 >= 21 && (lowTemp+highTemp)/2 <= 30 {
                    Text(warm[Int.random(in: 0..<4)])
                }
                else if (lowTemp+highTemp)/2 >= 31 && (lowTemp+highTemp)/2 <= 40 {
                    Text(hot[Int.random(in: 0..<4)])
                }
                else if (lowTemp+highTemp)/2 >= 41 && (lowTemp+highTemp)/2 <= 50 {
                    Text(death[Int.random(in: 0..<4)])
                }
                else if (lowTemp+highTemp)/2 >= 1 && (lowTemp+highTemp)/2 <= 10 {
                    Text(cool[Int.random(in: 0..<4)])
                }
                else if (lowTemp+highTemp)/2 >= -9 && (lowTemp+highTemp)/2 <= 0 {
                    Text(cold[Int.random(in: 0..<4)])
                }
                else if (lowTemp+highTemp)/2 >= -19 && (lowTemp+highTemp)/2 <= -10 {
                    Text(almostFrigid[Int.random(in: 0..<4)])
                }
                else if (lowTemp+highTemp)/2 >= -29 && (lowTemp+highTemp)/2 <= -20 {
                    Text(frigid[Int.random(in: 0..<4)])
                }
                else if (lowTemp+highTemp)/2 >= -39 && (lowTemp+highTemp)/2 <= -30 {
                    Text(frigid[Int.random(in: 0..<4)])
                }
                else {
                    Text(frigid[Int.random(in: 0..<4)])
                }
        }
    }
}


struct infoThing2: View {
    @State var lowTemp: Int
    @State var highTemp: Int
    var body: some View {
        infoThing(lowTemp: lowTemp, highTemp: highTemp)
    }
}
