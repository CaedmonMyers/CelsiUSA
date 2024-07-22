//
//  Cloud.swift
//  Testing Weather App
//
//  Created by Caedmon Myers on 5/24/23.
//

import SwiftUI

struct CloudsView: View {
    let timer = Timer.publish(every: 7, on: .main, in: .common).autoconnect() // Adjust time as per your requirement
    
    @State private var clouds: [UUID] = []
    
    var body: some View {
        ZStack {
            // Sky color
            //Color.blue
            //    .edgesIgnoringSafeArea(.all)
            
            // Create Cloud Views
            ForEach(clouds, id: \.self) { id in
                CloudView(id: id)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 60) { // Match this with animation duration
                            clouds.removeAll { $0 == id }
                        }
                    }
            }
        }
        .onReceive(timer) { _ in
            clouds.append(UUID())
        }
    }
}

struct CloudView: View {
    let id: UUID
    
    @State private var cloudOffset = UIScreen.main.bounds.width

    var body: some View {
        Image("cloud2") // Use your cloud image name
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            .opacity(0.9)
            .blur(radius: 10)
            .offset(x: cloudOffset, y: -200)
            .onAppear {
                withAnimation(Animation.linear(duration: 60).repeatForever(autoreverses: false)) {
                    cloudOffset = -UIScreen.main.bounds.width
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
                    withAnimation(.none) {
                        cloudOffset = UIScreen.main.bounds.width
                    }
                }
            }
    }
}



