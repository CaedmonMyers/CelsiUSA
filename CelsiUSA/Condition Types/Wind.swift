//
//  Wind.swift
//  Testing Weather App
//
//  Created by Caedmon Myers on 5/12/23.
//

import SwiftUI
import WeatherKit

struct Wind: View {
    @State var weather: Weather?
    
    @State var geo: CGFloat
    
    @State private var rotation: Angle = .zero
    @State private var showKM: Bool = false
    var body: some View {
        if let weather = weather {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.white)
                    .shadow(color: .white, radius: 3)
                
                VStack(spacing: 0) {
                    HStack {
                        Text("Wind")
                            .foregroundColor(.white)
                            .opacity(0.5)
                            .padding(5)
                            .font(.caption)
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    Text("\(String(format: "%.0f", weather.currentWeather.wind.speed.value))km/h")
                        //.padding(7)
                        .foregroundColor(.white)
                        .padding(.trailing, 15)
                    
                    
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
                                            .frame(width: 75)
                                        
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
                                        .frame(width: 90, height: 2)
                                }
                                
                            }.rotationEffect(Angle(radians: (weather.currentWeather.wind.direction.value) * .pi / 180 - Double.pi/2))
                        }.shadow(color: .black, radius: 1)
                    }
                    
                    Spacer()
                }
                
            }
        }
    }
}


