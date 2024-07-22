//
//  Settings.swift
//  Testing Weather App
//
//  Created by Caedmon Myers on 5/18/23.
//

import SwiftUI

struct Settings: View {
    @State var appIcons = ["Purple Glow", "Sunshine", "Sunn!", "Stormy Skies", "Night Glow", "Cacti"]
    var body: some View {
        ScrollView {
            VStack {
                ForEach(appIcons, id:\.self) { icon in
                    Button {
                        if icon == "Purple Glow" {
                            UIApplication.shared.setAlternateIconName(nil)
                        }
                        else {
                            UIApplication.shared.setAlternateIconName(icon)
                        }
                    } label: {
                        ZStack {
                            Color.black
                                .cornerRadius(20)
                            
                            HStack {
                                Image("\(icon) 1")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 50)
                                    .cornerRadius(10)
                                
                                Text(icon)
                                    .foregroundColor(.white)
                            }.padding(10)
                            
                        }.padding(10)
                    }
                }
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
