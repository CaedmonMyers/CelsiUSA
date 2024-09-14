//
//  ContentView.swift
//  Testing Weather App
//
//  Created by Caedmon Myers on 5/9/23.
//

import SwiftUI
import CoreLocation
import WeatherKit
import Combine
import LottieUI

 

struct ContentView: View {
    @StateObject private var viewModel: WeatherViewModel
    @State private var bg1 = true
    @EnvironmentObject private var purchaseManager: PurchaseManager
    @EnvironmentObject var locationManager: LocationManager
    
    //@ObservedObject var userLocationHelper = LocationManager.shared
    
    //static let location = CLLocation(latitude: .init(floatLiteral: LocationManager.shared.userLocation?.coordinate.latitude ?? 0.0), longitude: LocationManager.shared.userLocation?.coordinate.longitude ?? 0.0)
    
    @State var weather: Weather?
    
    @State var weatherData: WeatherMetadata?
    
    @State var measurer = 0
    
    @State var showIAP = false
    
    @State var adHeight = CGFloat(50)
    
    /*func getWeather() async {
        guard let location = locationManager.location else {
            // Handle the case where location is nil
            return
        }
        do {
            weather = try await Task {
                try await WeatherService.shared.weather(for: location)
            }.value
        } catch {
            fatalError("\(error)")
        }
    }*/
    
    private let locationManager2 = CLLocationManager()
    
    @State var offsetX = CGFloat(0)
    @State var offset = CGSize.zero
    
    @State var offsetLower1 = CGFloat(0)
    @State var otherOffset = CGSize.zero
    
    @State private var rotation: Angle = .zero
    @State private var showMI: Bool = false
    @State var feelsLikeF = false
    @State var dewPointF = false
    
    @State private var dragAmount = CGSize.zero
    
    @State var visShown = false
    
    
    init() {
        _viewModel = StateObject(wrappedValue: WeatherViewModel(locationManager: LocationManager()))
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ZStack {
                    BG_Gradients(currentConditions: "")
                    ProgressView()
                        .tint(.white)
                }
            } else if let weather = viewModel.weather {
                ZStack {
                    if bg1 {
                        BG_Gradients(currentConditions: weather.currentWeather.condition.description)
                        //BG_Gradients()
                    }
                    else {
                        BG_Gradients2(currentConditions: weather.currentWeather.condition.description)
                        //BG_Gradients()
                    }
                    VStack(spacing: 0) {
                        ScrollView {
                            VStack {
                                Spacer()
                                    .frame(height: 75)
                                
                                
                                //if CLLocationManager.locationServicesEnabled() {
                                switch locationManager2.authorizationStatus {
                                case .notDetermined, .restricted, .denied:
                                    Text("Location Services are disabled. Enjoy this forecast for the Atlantic Ocean.")
                                        .foregroundColor(.white)
                                    //case .authorizedAlways, .authorizedWhenInUse:
                                    //print("Access")
                                case .authorizedAlways:
                                    Text("")
                                case .authorizedWhenInUse:
                                    Text("")
                                @unknown default:
                                    Text("")
                                }
                                //} else {
                                //    Text("Location Services are disabled. Enjoy this forecast for the Atlantic Ocean.")
                                //        .foregroundColor(.white)
                                //}
                                
                                Text(weather.currentWeather.condition.description)
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .padding(10)
                                
                                HStack {
                                    ZStack {
                                        if offset.width != 0 {
                                            Text("\(String(format: "%.0f", weather.currentWeather.temperature.converted(to: .fahrenheit).value))℉")
                                                .font(.system(size: 70, design: .rounded))
                                                .bold()
                                                .foregroundColor(.white)
                                                .onAppear() {
                                                    softImpact.impactOccurred()
                                                }
                                        }
                                        
//                                        cloud_sun_view()
//                                            .opacity(offset.width != 0 ? 0.5: 1.0)
//                                            .offset(x: offset.width)
//                                            .animation(.spring(response: 0.5, dampingFraction: 0.9, blendDuration: 0))
//                                            .gesture(
//                                                DragGesture()
//                                                    .onChanged { value in
//                                                        let threshold: CGFloat = 50
//                                                        if abs(value.translation.width) > threshold {
//                                                            self.offset.width = min(max(value.translation.width, -150), 150)
//                                                        }
//                                                    }
//                                                    .onEnded { value in
//                                                        let threshold: CGFloat = 50
//                                                        if abs(value.translation.width) > threshold {
//                                                            if value.translation.width > 0 {
//                                                                // Swiped to the right
//                                                                //scrollingID = shownID
//                                                                
//                                                                //scrollDistance.scrollTo(scrollingID, anchor: .top)
//                                                                
//                                                            } else {
//                                                                // Swiped to the left
//                                                                //scrollingID = shownID
//                                                                
//                                                                //scrollDistance.scrollTo(scrollingID, anchor: .top)
//                                                            }
//                                                        }
//                                                        withAnimation {
//                                                            self.offset = .zero
//                                                        }
//                                                    }
//                                            )
                                        
                                        Image(systemName: weather.currentWeather.symbolName)
                                         .font(.system(size: 70, design: .rounded))
                                         .foregroundColor(.white)
                                         .opacity(offset.width != 0 ? 0.5: 1.0)
                                         .offset(x: offset.width)
                                         .animation(.spring(response: 0.5, dampingFraction: 0.9, blendDuration: 0))
                                         .gesture(
                                         DragGesture()
                                         .onChanged { value in
                                         let threshold: CGFloat = 50
                                         if abs(value.translation.width) > threshold {
                                         self.offset.width = min(max(value.translation.width, -150), 150)
                                         }
                                         }
                                         .onEnded { value in
                                         let threshold: CGFloat = 50
                                         if abs(value.translation.width) > threshold {
                                         if value.translation.width > 0 {
                                         // Swiped to the right
                                         //scrollingID = shownID
                                         
                                         //scrollDistance.scrollTo(scrollingID, anchor: .top)
                                         
                                         } else {
                                         // Swiped to the left
                                         //scrollingID = shownID
                                         
                                         //scrollDistance.scrollTo(scrollingID, anchor: .top)
                                         }
                                         }
                                         withAnimation {
                                         self.offset = .zero
                                         }
                                         }
                                         )
                                    }
                                    
                                    
                                    Spacer()
                                        .frame(width: 30)
                                    
                                    Text("\(String(format: "%.0f", weather.currentWeather.temperature.value))°")
                                        .font(.system(size: 70, design: .rounded))
                                        .bold()
                                        .opacity(offset.width != 0 ? 0.5: 1.0)
                                        .foregroundColor(.white)
                                }
                                
                                HStack {
                                    if offset.width == 0 {
                                        Text("\(String(format: "%.0f", weather.dailyForecast.first!.lowTemperature.value))°")
                                            .foregroundColor(.white)
                                            .animation(.default)
                                        
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(lineWidth: 1)
                                                .foregroundColor(.white)
                                                .shadow(color: .white, radius: 4)
                                                .frame(width: 150, height: 10)
                                            
                                            //Image(systemName: weather.currentWeather.symbolName)
                                            //    .resizable()
                                            //    .scaledToFit()
                                            HStack {
                                                Spacer()
                                                    .frame(width: (150/(weather.dailyForecast.first!.highTemperature.value - weather.dailyForecast.first!.lowTemperature.value))*(weather.currentWeather.temperature.value - weather.dailyForecast.first!.lowTemperature.value))
                                                
                                                Circle()
                                                    .foregroundColor(.white)
                                                //.bold()
                                                    .frame(width: 10, height: 10)
                                                
                                                Spacer()
                                            }.frame(width: 150)
                                            
                                        }.animation(.default)
                                        
                                        Text("\(String(format: "%.0f", weather.dailyForecast.first!.highTemperature.value))°")
                                            .foregroundColor(.white)
                                            .animation(.default)
                                    }
                                    else {
                                        Text("\(String(format: "%.0f", weather.dailyForecast.first!.lowTemperature.converted(to: .fahrenheit).value))℉")
                                            .foregroundColor(.white)
                                            .animation(.default)
                                        
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(lineWidth: 1)
                                                .foregroundColor(.white)
                                                .shadow(color: .white, radius: 4)
                                                .frame(width: 150, height: 10)
                                            
                                            //Image(systemName: weather.currentWeather.symbolName)
                                            //    .resizable()
                                            //    .scaledToFit()
                                            HStack {
                                                Spacer()
                                                    .frame(width: (150/(weather.dailyForecast.first!.highTemperature.converted(to: .fahrenheit).value - weather.dailyForecast.first!.lowTemperature.converted(to: .fahrenheit).value))*(weather.currentWeather.temperature.converted(to: .fahrenheit).value - weather.dailyForecast.first!.lowTemperature.converted(to: .fahrenheit).value))
                                                
                                                Circle()
                                                    .foregroundColor(.white)
                                                //.bold()
                                                    .frame(width: 10, height: 10)
                                                
                                                Spacer()
                                                
                                            }.frame(width: 150)
                                            
                                        }.animation(.default)
                                        
                                        Text("\(String(format: "%.0f", weather.dailyForecast.first!.highTemperature.converted(to: .fahrenheit).value))℉")
                                            .foregroundColor(.white)
                                            .animation(.default)
                                    }
                                }
                                
                                
                                
                                
                                Hourly(loopingWeather: weather.hourlyForecast.filter({ $0.date >= Date() }).filter({ $0.date <= Date(timeIntervalSinceNow: 86400)}), minuteWeather: weather.minuteForecast?.filter({ $0.date >= Date() }).filter({ $0.date <= Date(timeIntervalSinceNow: 3600)}) ?? [])
                                    .padding(7)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(lineWidth: 2)
                                            .foregroundColor(.white)
                                            .shadow(color: .white, radius: 3)
                                        
                                    }
                                    .padding(15)
                                
                                Daily(loopingWeather: weather.dailyForecast.filter({ $0.date >= Date() }).filter({ $0.date <= Date(timeIntervalSinceNow: 864000)}))
                                //.padding(7)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(lineWidth: 2)
                                            .foregroundColor(.white)
                                            .shadow(color: .white, radius: 3)
                                        
                                    }
                                    .padding(15)
                                
                                
                                LazyVGrid(columns: [GridItem(), GridItem()]) {
                                    // Code for wind
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(lineWidth: 2)
                                            .foregroundColor(.white)
                                            .shadow(color: .white, radius: 3)
                                        
                                        VStack(spacing: 0) {
                                            HStack {
                                                Label("Wind", systemImage: "wind")
                                                    .foregroundColor(.white)
                                                    .opacity(0.5)
                                                    .padding(8)
                                                    .font(.caption)
                                                
                                                Spacer()
                                            }
                                            
                                            Spacer()
                                            
                                            if !showMI {
                                                Text("\(String(format: "%.0f", weather.currentWeather.wind.speed.value))km/h")
                                                //.padding(7)
                                                    .foregroundColor(.white)
                                                    .padding(.trailing, 15)
                                            }
                                            else {
                                                Text("\(String(format: "%.0f", weather.currentWeather.wind.speed.converted(to: .milesPerHour).value))mph")
                                                //.padding(7)
                                                    .foregroundColor(.white)
                                                    .padding(.trailing, 15)
                                                
                                            }
                                            
                                            
                                            ZStack {
                                                Circle()
                                                    .stroke(lineWidth: 1)
                                                    .foregroundColor(.white)
                                                    .frame(width: 110, height: 110)
                                                
                                                Group {
                                                    
                                                    Text("N")
                                                        .offset(x: 0, y: -45)
                                                    
                                                    Text("S")
                                                        .offset(x: 0, y: 45)
                                                    
                                                    Text("E")
                                                        .offset(x: 45, y: 0)
                                                    
                                                    Text("W")
                                                        .offset(x: -45, y: 0)
                                                    
                                                }.foregroundColor(.white)
                                                
                                                Group {
                                                    Circle()
                                                        .fill(Color.white)
                                                        .frame(width: 10, height: 10)
                                                    HStack(spacing: 0) {
                                                        Triangle()
                                                            .fill(Color.white)
                                                            .frame(width: 10, height: 10)
                                                            .rotationEffect(Angle(radians: -Double.pi/2))
                                                        
                                                        ZStack {
                                                            HStack(spacing: 0) {
                                                                Spacer()
                                                                    .frame(width: 55)
                                                                
                                                                VStack(spacing: 0) {
                                                                    Color.white
                                                                        .frame(width: 5, height: 2)
                                                                        .cornerRadius(50)
                                                                        .rotationEffect(Angle(radians: -Double.pi/4))
                                                                        .padding(.bottom, 1)
                                                                    
                                                                    Color.white
                                                                        .frame(width: 5, height: 2)
                                                                        .cornerRadius(50)
                                                                        .rotationEffect(Angle(radians: Double.pi/4))
                                                                        .padding(.top, 1)
                                                                }
                                                                
                                                                //Spacer()
                                                                //    .frame(width: 1)
                                                                
                                                                VStack(spacing: 0) {
                                                                    Color.white
                                                                        .frame(width: 5, height: 2)
                                                                        .cornerRadius(50)
                                                                        .rotationEffect(Angle(radians: -Double.pi/4))
                                                                        .padding(.bottom, 1)
                                                                    
                                                                    Color.white
                                                                        .frame(width: 5, height: 2)
                                                                        .cornerRadius(50)
                                                                        .rotationEffect(Angle(radians: Double.pi/4))
                                                                        .padding(.top, 1)
                                                                }
                                                            }
                                                            
                                                            Color.white
                                                                .frame(width: 70, height: 2)
                                                        }
                                                        
                                                    }.rotationEffect(Angle(radians: (weather.currentWeather.wind.direction.value) * .pi / 180 - Double.pi/2))
                                                }.shadow(color: .black, radius: 1)
                                            }
                                            .rotationEffect(rotation)
                                            
                                            Spacer()
                                        }
                                        
                                    }
                                    .onTapGesture {
                                        //here for the long press to work
                                    }
                                    .onLongPressGesture(perform: {
                                        impact.impactOccurred()
                                        withAnimation {
                                            rotation = Angle(radians: 3.14159)
                                        }
                                        showMI = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                            withAnimation {
                                                rotation = .zero
                                            }
                                            showMI = false
                                        }
                                    })
                                    .gesture(
                                        RotationGesture()
                                            .onChanged { angle in
                                                rotation = angle
                                                // Convert angle to degrees and check if it's more than 90
                                                let degrees = angle.radians * 180 / .pi
                                                if abs(degrees) > 0 {
                                                    showMI = true
                                                }
                                            }
                                            .onEnded { _ in
                                                // Reset rotation after gesture ends
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                                    withAnimation {
                                                        rotation = .zero
                                                    }
                                                    showMI = false
                                                }
                                            }
                                    )
                                    
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(lineWidth: 2)
                                            .foregroundColor(.white)
                                            .shadow(color: .white, radius: 3)
                                        
                                        VStack(spacing: 0) {
                                            HStack {
                                                Label("Feels Like", systemImage: "thermometer")
                                                //Text("Rainfall")
                                                    .foregroundColor(.white)
                                                    .opacity(0.5)
                                                    .padding(8)
                                                    .font(.caption)
                                                
                                                Spacer()
                                            }
                                            
                                            Spacer()
                                            
                                            Text("\(String(format: "%.0f", weather.currentWeather.apparentTemperature.converted(to: feelsLikeF ? .fahrenheit: .celsius).value))\(feelsLikeF ? "℉": "°")")
                                            //.padding(7)
                                                .font(.system(size: 50, design: .rounded))
                                                .foregroundColor(.white)
                                                .padding(.trailing, 15)
                                            
                                            Text(abs(weather.currentWeather.apparentTemperature.value - weather.currentWeather.temperature.value) <= 4 ? "Similar to the actual temperature": weather.currentWeather.apparentTemperature.value - weather.currentWeather.temperature.value < -4 ? "Colder than the actual temperature": weather.currentWeather.apparentTemperature.value - weather.currentWeather.temperature.value > 4 ? "Warmer than the actual temperature": "Unavailable")
                                                .foregroundColor(.white)
                                                .padding(5)
                                            
                                            
                                            Spacer()
                                        }
                                        
                                    }
                                    .onTapGesture {
                                        // Here for the long press
                                    }
                                    .onLongPressGesture {
                                        impact.impactOccurred()
                                        feelsLikeF.toggle()
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                            feelsLikeF = false
                                        }
                                    }
                                    
                                    
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
                                                
                                                Text("\(Int(weather.currentWeather.humidity * 100))%")
                                                //weather.dailyForecast.first?.precipitation
                                                //.padding(7)
                                                //.font(.system(size: 50, design: .rounded))
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 35, design: .rounded))
                                                    .bold()
                                                    .padding(.trailing, 15)
                                                
                                                Spacer()
                                            }
                                            
                                            Text("The dew point is \(Int(weather.currentWeather.dewPoint.converted(to: dewPointF ? .fahrenheit: .celsius).value))\(dewPointF ? "℉": "°") right now.")
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
                                    
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(lineWidth: 2)
                                            .foregroundColor(.white)
                                            .shadow(color: .white, radius: 3)
                                        
                                        VStack(spacing: 0) {
                                            HStack {
                                                Label("Pressure", systemImage: "gauge")
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
                                                
                                                ZStack {
                                                    PressureScaleView(scaleDegrees: weather.currentWeather.pressure.value)
                                                        .frame(width: 100, height: 100)
                                                    
                                                    VStack {
                                                        Text("\(String(Int(weather.currentWeather.pressure.value)))")
                                                            .foregroundColor(.white)
                                                            .bold()
                                                            .font(.system(size: 25, design: .rounded))
                                                        
                                                        Text("hPa")
                                                            .foregroundColor(.white)
                                                    }
                                                }
                                                
                                                /*Text("\(Int(weather.currentWeather.pressure.value))")
                                                 //weather.dailyForecast.first?.precipitation
                                                 //.padding(7)
                                                 //.font(.system(size: 50, design: .rounded))
                                                 .foregroundColor(.white)
                                                 .font(.system(size: 35, design: .rounded))
                                                 .bold()
                                                 .padding(.trailing, 15)*/
                                                
                                                Spacer()
                                            }
                                            
                                            
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
                                        // This metric does not require an alternate measurement
                                    }
                                    
                                    
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(lineWidth: 2)
                                            .foregroundColor(.white)
                                            .shadow(color: .white, radius: 3)
                                        
                                        VStack(spacing: 0) {
                                            HStack {
                                                Label("UV Index", systemImage: "sun.min.fill")
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
                                                
                                                Text("\(weather.currentWeather.uvIndex.value)")
                                                //weather.dailyForecast.first?.precipitation
                                                //.padding(7)
                                                //.font(.system(size: 50, design: .rounded))
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 35, design: .rounded))
                                                    .bold()
                                                //.padding(.trailing, 15)
                                                
                                                Spacer()
                                            }
                                            
                                            Text(weather.currentWeather.uvIndex.value <= 2 ? "Low": weather.currentWeather.uvIndex.value <= 5 ? "Moderate": weather.currentWeather.uvIndex.value <= 10 ? "Very High": "Extreme")
                                                .foregroundColor(.white)
                                                .font(.system(size: 20, design: .rounded))
                                                .bold()
                                            
                                            ZStack {
                                                GeometryReader { geo in
                                                    ZStack {
                                                        HStack {
                                                            Spacer()
                                                            
                                                            LinearGradient(colors: [Color(hex: "30D256"), Color(hex: "FECA06"), Color(hex: "FF4848"), Color(hex: "C158E9")], startPoint: .leading, endPoint: .trailing)
                                                                .frame(width: geo.size.width-30, height: 10)
                                                                .cornerRadius(50)
                                                            
                                                            Spacer()
                                                        }
                                                        
                                                        HStack {
                                                            //Spacer()
                                                            //.frame(width: geo.size.width * CGFloat(weather.currentWeather.uvIndex.value/11))
                                                            
                                                            Circle()
                                                                .fill(Color.white)
                                                                .padding(.leading, geo.size.width * CGFloat(weather.currentWeather.uvIndex.value/11))
                                                                .frame(width: 10, height: 10)
                                                            
                                                            //Spacer()
                                                        }
                                                    }
                                                    
                                                }
                                            }
                                            
                                            
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
                                        // This metric does not require an alternate measurement
                                    }
                                    
                                    
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(lineWidth: 2)
                                            .foregroundColor(.white)
                                            .shadow(color: .white, radius: 3)
                                        
                                        VStack(spacing: 0) {
                                            HStack {
                                                Label("Visibility", systemImage: "eye.fill")
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
                                                
                                                
                                                
                                                Text("\(Int(weather.currentWeather.visibility.converted(to: visShown ? .miles: .kilometers).value))\(visShown ? "mi": "km")")
                                                //weather.dailyForecast.first?.precipitation
                                                //.padding(7)
                                                //.font(.system(size: 50, design: .rounded))
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 35, design: .rounded))
                                                    .bold()
                                                    .padding(.trailing, 15)
                                                
                                                Spacer()
                                            }
                                            
                                            HStack(spacing: 0) {
                                                Image(systemName: "eyes")
                                                    .foregroundColor(.white)
                                                    .scaledToFit()
                                                    .frame(height: 30)
                                                    .rotationEffect(Angle(degrees: 180))
                                                
                                                @State var visHeight = CGFloat(10)
                                                @State var visWidth = CGFloat(25)
                                                @State var visPad = CGFloat(1)
                                                
                                                Color(.white)
                                                    .opacity(weather.currentWeather.visibility.value >= 1.0 ? 1.0: 0.5)
                                                    .cornerRadius(50)
                                                    .padding([.leading, .trailing], visPad)
                                                    .frame(width: visWidth, height: visHeight)
                                                
                                                Color(.white)
                                                    .opacity(weather.currentWeather.visibility.value >= 2.0 ? 1.0: 0.5)
                                                    .cornerRadius(50)
                                                    .padding([.leading, .trailing], visPad)
                                                    .frame(width: visWidth, height: visHeight)
                                                
                                                Color(.white)
                                                    .opacity(weather.currentWeather.visibility.value >= 5.0 ? 1.0: 0.5)
                                                    .cornerRadius(50)
                                                    .padding([.leading, .trailing], visPad)
                                                    .frame(width: visWidth, height: visHeight)
                                                
                                                Color(.white)
                                                    .opacity(weather.currentWeather.visibility.value >= 10.0 ? 1.0: 0.5)
                                                    .cornerRadius(50)
                                                    .padding([.leading, .trailing], visPad)
                                                    .frame(width: visWidth, height: visHeight)
                                                
                                                /*Color(.white)
                                                 .opacity(weather.currentWeather.visibility.value > 10.0 ? 1.0: 0.5)
                                                 .cornerRadius(50)
                                                 .padding([.leading, .trailing], visPad)
                                                 .frame(width: visWidth, height: visHeight)*/
                                            }
                                            
                                            //Text("The dew point is \(Int(weather.currentWeather.dewPoint.converted(to: dewPointF ? .fahrenheit: .celsius).value))\(dewPointF ? "℉": "°") right now.")
                                            //.foregroundColor(.white)
                                            
                                            
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
                                    .onLongPressGesture(minimumDuration: 0.1) {
                                        impact.impactOccurred()
                                        
                                        visShown = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                            visShown = false
                                        }
                                    }
                                    
                                    
                                    /*ZStack {
                                     RoundedRectangle(cornerRadius: 15)
                                     .stroke(lineWidth: 2)
                                     .foregroundColor(.white)
                                     .shadow(color: .white, radius: 3)
                                     
                                     VStack(spacing: 0) {
                                     HStack {
                                     Label("Feels Like", systemImage: "thermometer")
                                     .foregroundColor(.white)
                                     .opacity(0.5)
                                     .padding(8)
                                     .font(.caption)
                                     
                                     Spacer()
                                     }
                                     
                                     Spacer()
                                     
                                     //Text("\(String(format: "%.0f", weather.currentWeather))\(feelsLikeF ? "℉": "°")")
                                     Text(weather.dailyForecast.first?.precipitationAmount.description ?? "Failed")
                                     //.padding(7)
                                     //.font(.system(size: 50, design: .rounded))
                                     .foregroundColor(.white)
                                     .padding(.trailing, 15)
                                     
                                     Text(abs(weather.currentWeather.apparentTemperature.value - weather.currentWeather.temperature.value) <= 4 ? "Similar to the actual temperature": weather.currentWeather.apparentTemperature.value - weather.currentWeather.temperature.value < -4 ? "Colder than the actual temperature": weather.currentWeather.apparentTemperature.value - weather.currentWeather.temperature.value > 4 ? "Warmer than the actual temperature": "Unavailable")
                                     .foregroundColor(.white)
                                     .padding(5)
                                     
                                     
                                     Spacer()
                                     }
                                     
                                     }
                                     .padding(.top, 10)*/
                                }.padding([.leading, .trailing], 15)
                                Group {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(lineWidth: 2)
                                            .foregroundColor(.white)
                                            .shadow(color: .white, radius: 3)
                                        
                                        VStack(spacing: 0) {
                                            HStack {
                                                Label("Beta Info", systemImage: "wrench.and.screwdriver.fill")
                                                    .foregroundColor(.white)
                                                    .opacity(0.5)
                                                    .padding(8)
                                                    .font(.caption)
                                                
                                                Spacer()
                                            }
                                            Text("Thanks for trying out our beta version of the app. Please keep your eye out for any bugs. If you find a bug or have a suggestion, take a screenshot if possible and send it to us either through TestFlight or by email at beta@doorhingeapps.com")
                                                .foregroundColor(.white)
                                            
                                            Text("Also, we've not finished adding all of the background gradients for each type of weather. If you see one that's not correct or missing, screenshot it and send it to us as well.")
                                                .foregroundColor(.white)
                                        }.padding(10)
                                    }.padding([.leading, .trailing], 15)
                                    
                                    Button {
                                        //https://testflight.apple.com/join/y32w5RVw
                                        UIPasteboard.general.string = "https://testflight.apple.com/join/y32w5RVw"
                                    } label: {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(lineWidth: 2)
                                                .foregroundColor(.white)
                                                .shadow(color: .white, radius: 3)
                                            
                                            Text("Copy Invite Link")
                                                .foregroundColor(.white)
                                        }.padding([.leading, .trailing], 15)
                                    }
                                }
                                
                                Group {
                                    Button {
                                        //https://testflight.apple.com/join/y32w5RVw
                                        showSettings = true
                                    } label: {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(lineWidth: 2)
                                                .foregroundColor(.white)
                                                .shadow(color: .white, radius: 3)
                                            
                                            Text("Settings")
                                                .foregroundColor(.white)
                                        }.padding([.leading, .trailing], 15)
                                    }
                                    
                                    Spacer()
                                        .frame(height: 100)
                                }
                                
                            }.sheet(isPresented: $showSettings) {
                                Settings()
                            }
                        }
                    }
                    .refreshable {
                        await viewModel.getWeather()
                        bg1.toggle()
                    }
                    .task {
                        await viewModel.getWeather()
                        bg1.toggle()
                    }
                    .tint(.white)
                    
                    GeometryReader { geo in
                        if !purchaseManager.hasUnlockedPro {
                            HStack {
                                Spacer()
                                    .frame(width: geo.size.width/2-200)
                                
                                VStack(spacing: 0) {
                                    Spacer()
                                    
                                    VStack(spacing: 0) {
                                        
                                        
                                        Spacer()
                                        
                                    }
                                    .frame(width: .infinity, height: adHeight)
                                    .ignoresSafeArea()
                                    .frame(width: 100, height: 100)
                                    .offset(y: dragAmount.height)
                                    .animation(.spring(response: 0.5, dampingFraction: 0.9, blendDuration: 0))
                                    .gesture(
                                        DragGesture()
                                            .onChanged { value in
                                                let threshold: CGFloat = 50
                                                if abs(value.translation.height) > threshold {
                                                    self.dragAmount.height = min(max(value.translation.height, -150), 0)
                                                }
                                            }
                                            .onEnded { value in
                                                let threshold: CGFloat = 50
                                                if abs(value.translation.height) > threshold {
                                                    if value.translation.height > 0 {
                                                        // Swiped to the right
                                                        //scrollingID = shownID
                                                        
                                                        showIAP = true
                                                        
                                                        dragAmount = .zero
                                                        
                                                        //scrollDistance.scrollTo(scrollingID, anchor: .top)
                                                        
                                                    } else {
                                                        // Swiped to the left
                                                        //scrollingID = shownID
                                                        
                                                        showIAP = true
                                                        
                                                        dragAmount = .zero
                                                        
                                                        //scrollDistance.scrollTo(scrollingID, anchor: .top)
                                                    }
                                                }
                                                withAnimation {
                                                    self.dragAmount = .zero
                                                }
                                            }
                                    )
                                    .sheet(isPresented: $showIAP) {
                                        IAP_View()
                                            .environmentObject(purchaseManager)
                                    }
                                }.ignoresSafeArea().frame(width: 400)
                                
                                Spacer()
                                    .frame(width: geo.size.width/2-200)
                            }.frame(width: geo.size.width)
                        }
                    }
                }
                .onAppear {
                    stopWeatherUpdateTimer()
                    
                    self.timer = Timer.publish(every: 20, on: .main, in: .common)
                        .autoconnect()
                        .sink { _ in
                            Task{
                                await viewModel.getWeather()
                            }
                        }
                }
                .onDisappear {
                    // This ensures the timer is cancelled when the view disappears
                    self.timer?.cancel()
                }
            } else {
                Text("Unable to fetch weather data")
                    .foregroundColor(.white)
            }
        }.task {
            await viewModel.getWeather()
        }
    }
    
    @State private var timer: AnyCancellable?

        private func startWeatherUpdateTimer() {
            timer = Timer.publish(every: 300, on: .main, in: .common)
                .autoconnect()
                .sink { _ in
                    if let location = locationManager.location {
                        Task {
                            await viewModel.getWeather()
                        }
                    }
                }
        }

        private func stopWeatherUpdateTimer() {
            timer?.cancel()
            timer = nil
        }
    
    @State var showSettings = false
    
}


/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/
