//
//  IAP View.swift
//  Testing Weather App
//
//  Created by Caedmon Myers on 5/22/23.
//

import SwiftUI
import StoreKit

struct IAP_View: View {
    @EnvironmentObject private var purchaseManager: PurchaseManager
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Products")
            ForEach(purchaseManager.products) { product in
                Button {
                    Task {
                        do {
                            try await purchaseManager.purchase(product)
                        } catch {
                            print(error)
                        }
                    }
                } label: {
                    Text("\(product.displayPrice) - \(product.displayName)")
                        .foregroundColor(.white)
                        .padding()
                        .background(.blue)
                        .clipShape(Capsule())
                }
            }
        }.task {
            Task {
                do {
                    try await purchaseManager.loadProducts()
                } catch {
                    print(error)
                }
            }
        }
    }
}
