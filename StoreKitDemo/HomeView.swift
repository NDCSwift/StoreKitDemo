//
    // Project: StoreKitDemo
    //  File: HomeView.swift
    //  Created by Noah Carpenter
    //  🐱 Follow me on YouTube! 🎥
    //  https://www.youtube.com/@NoahDoesCoding
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
    //  Dream Big, Code Bigger
    

import SwiftUI
import StoreKit

struct HomeView: View {
    private let iapProductID = "com.example.app.samplefeature"
    private let subProductID = "com.example.app.monthly"
    
    @State private var isIAPPurchased = false
    @State private var isSubPurchased = false
    
    
    var body: some View {
        
        NavigationStack {
            NavigationLink("IAP demo"){
                ContentView()
            }
            Text(isIAPPurchased ? "IAP PURCHASED" : "NOT PURCHASED")
            
            NavigationLink("SUB DEMO"){
                SubView()
            }
            Text(isSubPurchased ? "SUB PURCHASED" : "NOT PURCHASED")
        }
        .task {
            await checkIAPPurchse()
            await checkSubPurchase()
        }
        
    }
    
    private func checkIAPPurchse() async {
        if let result = await Transaction.latest(for: iapProductID),
           case .verified(let transaction) = result {
            isIAPPurchased = (transaction.revocationDate == nil) && !transaction.isUpgraded
        } else {
            isIAPPurchased = false
        }
    }
    
    private func checkSubPurchase() async {
        if let result = await Transaction.latest(for: subProductID),
           case .verified(let transaction) = result {
            let active = (transaction.revocationDate == nil) && (transaction.expirationDate.map { $0 > Date() } ?? true)
            isSubPurchased = active
        } else {
            isSubPurchased = false
        }
    }
    
}

#Preview {
    HomeView()
}
