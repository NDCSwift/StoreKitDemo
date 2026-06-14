//
    // Project: StoreKitDemo
    //  File: SubView.swift
    //  Created by Noah Carpenter
    //  🐱 Follow me on YouTube! 🎥
    //  https://www.youtube.com/@NoahDoesCoding
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
    //  Dream Big, Code Bigger
    

import SwiftUI
import StoreKit
import Foundation
import Combine

struct SubView: View {
    
    @StateObject private var model = SubViewModel()
    var body: some View {
        
        VStack{
            Text(model.isSubscribed ? "Subbed" : "Not Subbed")
                .font(.title)
            
            if let product = model.product {
                Button {
                    Task { await model.purchase()}
                } label: {
                    Text(model.isSubscribed ? "Subbed" : "subscribe for \(product.displayPrice)")
                        .buttonStyle(.borderedProminent)
                        
                }
                .disabled(model.isSubscribed)
            }
        }
            }
}


@MainActor
final class SubViewModel: ObservableObject {
    private let SubProductIdentifier = "com.example.app.monthly"
    
    @Published var product: Product?
    @Published var isSubscribed = false
    
    init() {
        Task {
            await loadProduct()
            await updateSubStatus()
        }
    }
    
    func loadProduct() async {
        if let loaded = try? await Product.products(for: [SubProductIdentifier]).first {
            product = loaded
        }
    }
    
    func purchase() async {
        guard let product else { return }
        
        if case .success(let result) = try? await product.purchase(),
           case .verified(let trasaction) = result {
            await trasaction.finish()
            await updateSubStatus()
        }
    }
    
    func updateSubStatus() async{
        if let result = await Transaction.latest(for: SubProductIdentifier),
           case .verified(let transaction) = result {
            let active = (transaction.revocationDate == nil) && (transaction.expirationDate.map{ $0 > Date()} ?? true)
            isSubscribed = active
        } else {
            isSubscribed = false
        }
    }
    
    private func listenForTransaction() {
        Task { for await update in Transaction.updates {
            
            if case .verified(let transaction) = update,
               transaction.productID == SubProductIdentifier {
                await transaction.finish()
                await updateSubStatus()
            }
        }}
    }
    
}


#Preview {
    SubView()
}
