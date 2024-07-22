//
//  BG Gradients.swift
//  Testing Weather App
//
//  Created by Caedmon Myers on 5/10/23.
//

import SwiftUI
import SpriteKit

let nightColors = [Color(hex: "37466D"), Color(hex: "4547B1")]
let dayColors = [Color(hex: "6BBAF3"), Color(hex: "456CCF")]
let cloudColors = [Color(hex: "A0AEBE"), Color(hex: "5B7CA3")]
let drizzleColors = [Color(hex: "5B6DBA"), Color(hex: "383838")]
let snowColors = [Color(hex: "9796CD"), Color(hex: "D2D2D2")]
let rainColors = [Color(hex: "6B92C0"), Color(hex: "515E80")]
let partCloudColors = [Color(hex: "85B0E2"), Color(hex: "D0D0D0")]
let thunderstormColors = [Color(hex: "565656"), Color(hex: "2B5382")]

let sunColors = [Color(hex: "FFF4C8"), Color(hex: "4569B1"), Color(hex: "2376D7")]

// Gradients need to be added for all of these
let addingColors = [Color(.systemBlue)]

struct BG_Gradients: View {
    @State var colorSet = sunColors
    @State var currentConditions: String
    //@State var currentConditions = "Clear"
    
    @State var colorDictionary = [
        "Clear": dayColors,
        "Mostly Clear": dayColors,
        "Sun": sunColors,
        "Cloudy": cloudColors,
        "Partly Cloudy": partCloudColors,
        "Mostly Cloudy": cloudColors,
        "Thunderstorm": thunderstormColors,
        "Rain": rainColors,
        "Drizzle": drizzleColors,
        "Invalid": addingColors,
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: colorDictionary[currentConditions] ?? dayColors), startPoint: .top, endPoint: .bottom)
            
            if currentConditions == "Rain" {
                Rain()
            }
            if currentConditions == "Thunderstorm" {
                Rain()
                LightningView()
            }
            if currentConditions == "Snow" {
                Snow()
            }
        }.ignoresSafeArea()
    }
}

struct BG_Gradients2: View {
    @State var colorSet = sunColors
    @State var currentConditions: String
    //@State var currentConditions = "Clear"
    
    @State var colorDictionary = [
        "Clear": dayColors,
        "Sun": sunColors,
        "Cloudy": cloudColors,
        "Partly Cloudy": partCloudColors,
        "Mostly Cloudy": cloudColors,
        "Thunderstorm": thunderstormColors,
        "Rain": rainColors,
        "Drizzle": drizzleColors,
        "Snow": snowColors,
        "Invalid": addingColors,
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: colorDictionary[currentConditions] ?? dayColors), startPoint: .top, endPoint: .bottom)
            
            if currentConditions == "Rain" {
                Rain()
            }
            if currentConditions == "Thunderstorm" {
                Rain()
                LightningView()
            }
            if currentConditions == "Snow" {
                Snow()
            }
        }.ignoresSafeArea()
    }
}



struct BG_Gradients_Previews: PreviewProvider {
    static var previews: some View {
        BG_Gradients(currentConditions: "Clear")
    }
}
