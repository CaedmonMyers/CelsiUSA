//
//  CelsiUSAApp.swift
//  CelsiUSA
//
//  Created by Caedmon Myers on 21/6/23.
//

import SwiftUI

@main
struct CelsiUSAApp: App {
    @StateObject
    private var purchaseManager = PurchaseManager()
    
    @StateObject var locationManager = LocationManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationManager)
                .environmentObject(purchaseManager)
                .task {
                    await purchaseManager.updatePurchasedProducts()
                }
        }
    }
}

