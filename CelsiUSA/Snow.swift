//
//  Snow.swift
//  Testing Weather App
//
//  Created by Caedmon Myers on 5/24/23.
//

import SwiftUI

struct Snow: View {
    @State private var snowflakes: [Snowflake] = []
    
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ForEach(snowflakes) { flake in
                    SnowflakeView(flake: flake, screenSize: proxy.size)
                        .animation(.linear(duration: flake.duration))
                        .blur(radius: 5)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + flake.duration) {
                                snowflakes.removeAll { $0.id == flake.id }
                            }
                        }
                }
            }
            .onReceive(timer) { _ in
                snowflakes.append(Snowflake())
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct Snowflake: Identifiable {
    let id = UUID()
    var xPos: CGFloat
    let duration: Double

    init() {
        xPos = CGFloat.random(in: 0..<UIScreen.main.bounds.width)
        duration = Double.random(in: 4...8)
    }
}

struct SnowflakeView: View {
    let flake: Snowflake
    let screenSize: CGSize
    
    @State private var progress: CGFloat = 0
    @State private var xOffset: CGFloat = 0
    
    var body: some View {
        Circle()
            .frame(width: 10, height: 10)
            .foregroundColor(.white)
            .opacity(0.85)
            .position(x: flake.xPos + xOffset, y: progress * screenSize.height)
            .onAppear {
                withAnimation(.linear(duration: flake.duration)) {
                    progress = 1
                    xOffset = CGFloat.random(in: -50...50)
                }
            }
    }
}

