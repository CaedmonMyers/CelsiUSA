//
//  Pressure.swift
//  Testing Weather App
//
//  Created by Caedmon Myers on 5/19/23.
//

import SwiftUI

import SwiftUI

struct PressureScaleView: View {
    let minValue: CGFloat = 700.0
    let maxValue: CGFloat = 1200.0
    var scaleDegrees: Double
    //var scaleDegrees = 1000.0
    
    //let currentPressure: CGFloat // Set the current pressure value here
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .foregroundColor(.white)
                .opacity(0.2)
            
            HStack {
                Color.white
                    .frame(width: 10, height: 3)
                
                Spacer()
            }.rotationEffect(Angle(degrees: ((scaleDegrees-700)/(500))*360))
            
            // Position the current pressure value along the scale
            //Text("\(Int(currentPressure))")
            //    .position(getPositionForPressure())
        }.rotationEffect(Angle(degrees: -90))
    }
    
    // Calculate the position on the partial circle for the current pressure value
    /*func getPositionForPressure() -> CGPoint {
        let startAngle: Double = 180 - (360 - scaleDegrees) / 2
        let endAngle: Double = 180 + (360 - scaleDegrees) / 2
        let angleRange = endAngle - startAngle
        
        let normalizedValue = (currentPressure - minValue) / (maxValue - minValue)
        let degrees = startAngle + normalizedValue * angleRange
        
        let radius = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) / 2 - 20
        let x = radius * cos(degrees * .pi / 180)
        let y = radius * sin(degrees * .pi / 180)
        
        return CGPoint(x: x, y: y)
    }*/
}


