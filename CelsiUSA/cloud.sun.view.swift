//
//  cloud.sun.view.swift
//  Testing Weather App
//
//  Created by Caedmon Myers on 5/30/23.
//

import SwiftUI
import LottieUI

struct cloud_sun_view: View {
    var body: some View {
        LottieView("cloud.sun")
            .loopMode(.loop)
    }
}

struct cloud_sun_view_Previews: PreviewProvider {
    static var previews: some View {
        cloud_sun_view()
    }
}
