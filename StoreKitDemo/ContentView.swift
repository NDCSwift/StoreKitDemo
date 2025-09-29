//
    // Project: StoreKitDemo
    //  File: ContentView.swift
    //  Created by Noah Carpenter
    //  🐱 Follow me on YouTube! 🎥
    //  https://www.youtube.com/@NoahDoesCoding97
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
    //  Dream Big, Code Bigger
    

import SwiftUI
import StoreKit
import Combine
import Foundation

struct ContentView: View {
    @StateObject private var store = StoreViewModel()
    var body: some View {
        VStack {

            Text(store.isPurchased ? "Feature Unlocked" : "Locked")
                .font(.title)
            
            if let product = store.product {
                Button {
                    Task { await store.purchase() }
                } label : {
                    Text(store.isPurchased ? "Purchased" : "Buy \(product.displayPrice)")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(store.isPurchased)
            }
            else {
                Text("loading store")
            }
            
            
        }
        .padding()
    }
}


@MainActor
final class StoreViewModel: ObservableObject {
    private let productIdentifier = "com.example.app.samplefeature"
    
    @Published var product: Product?
    @Published var isPurchased = false
    
    init() {
        Task {
            await loadProduct()
            await updatePurchaseStatus()
        }
    }
    
    func loadProduct() async {
        if let loaded = try? await Product.products(for: [productIdentifier]).first {
            product = loaded
        }
    }
    
    func purchase() async {
        guard let product else { return }
        
        if case .success(let result) = try? await product.purchase(),
           case .verified(let trasaction) = result {
            await trasaction.finish()
            await updatePurchaseStatus()
        }
    }
    
    func updatePurchaseStatus() async{
        if let result = await Transaction.latest(for: productIdentifier),
           case .verified(let transaction) = result {
            isPurchased = (transaction.revocationDate == nil)
        } else {
            isPurchased = false
        }
    }
    
    private func listenForTransaction() {
        Task { for await update in Transaction.updates {
            
            if case .verified(let transaction) = update,
               transaction.productID == productIdentifier {
                await transaction.finish()
                await updatePurchaseStatus()
            }
        }}
    }
    
}


#Preview {
    ContentView()
}
