# 🛒 StoreKit Demo
A beginner-friendly introduction to in-app purchases with StoreKit 2 in SwiftUI.

---

## 🤔 What this is
This project demonstrates how to implement a basic in-app purchase flow using StoreKit 2. It covers fetching products from App Store Connect, presenting them in a SwiftUI store view, handling purchase transactions, and unlocking content after a successful purchase. The ideal starting point before tackling subscriptions or advanced IAP patterns.

## ✅ Why you'd use it
- **StoreKit 2 basics** — Shows how to use `Product.products(for:)` and `product.purchase()` with Swift concurrency
- **Purchase flow** — Handles the full lifecycle from product fetch to transaction verification to content unlock
- **SwiftUI store UI** — Demonstrates how to build a clean paywall or store screen with native SwiftUI components

## 📺 Watch on YouTube
[![Watch on YouTube](https://img.shields.io/badge/YouTube-Watch%20the%20Tutorial-red?style=for-the-badge&logo=youtube)](https://youtu.be/BI-ohzQ7GuI)

> This project was built for the [NoahDoesCoding YouTube channel](https://www.youtube.com/@NoahDoesCoding97).

---

## 🚀 Getting Started

### 1. Clone the Repo
```bash
git clone https://github.com/NDCSwift/StoreKitDemo.git
cd StoreKitDemo
```

### 2. Open in Xcode
Double-click `StoreKitDemo.xcodeproj`.

### 3. Set Your Development Team
In Xcode: **TARGET → Signing & Capabilities → Team** — select your team.

### 4. Update the Bundle Identifier
Change `com.example.MyApp` to a unique reverse-domain ID matching your App Store Connect app.

## 🛠️ Notes
- Use the included `.storekit` configuration file for local Simulator testing without a live App Store Connect app.
- If code signing fails, verify your Team and Bundle ID are correct.

## 📦 Requirements
- Xcode 15+
- iOS 16+

📺 [Watch the guide on YouTube](https://youtu.be/BI-ohzQ7GuI)
