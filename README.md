# Smart Market

A mobile platform connecting buyers and sellers with reliable market information, transparent pricing, and trusted trading partners.

## Vision

To become the primary platform where buyers and sellers obtain reliable market information, compare prices, discover business opportunities, and connect directly with trusted trading partners — reducing the time, money, and stress associated with finding products and identifying trustworthy sellers.

> Smart Market is a commercial discovery tool, not a social network. It exists solely to facilitate price transparency and business decision-making.

## Features

- **Market Feed** — Browse live product listings across categories with real-time pricing
- **Price Comparison** — Compare the same product across multiple sellers side by side
- **Seller Discovery** — Find and filter verified, trusted sellers by category and location
- **Seller Profiles** — View seller ratings, reviews, listed products, and contact details
- **Search** — Quickly find products, prices, and sellers

## Screens

| Screen | Description |
|---|---|
| Home | Market feed with category filters and product grid |
| Search | Full-text search with popular suggestions |
| Product Detail | Price hero, seller info, and price comparison table |
| Sellers | Filterable list of sellers with verified badge |
| Seller Profile | Full seller profile with products and contact options |

## Tech Stack

- **Flutter** (iOS & Android)
- **go_router** — declarative navigation
- **cached_network_image** — efficient image loading

## Getting Started

```bash
# Install dependencies
flutter pub get

# Run on a connected device or simulator
flutter run

# Build for release
flutter build apk        # Android
flutter build ipa        # iOS
```

## Project Structure

```
lib/
├── main.dart              # App entry, router, bottom nav
├── theme/
│   └── app_theme.dart     # Colors, typography, component themes
├── models/
│   └── models.dart        # Data models + sample data
├── screens/
│   ├── home_screen.dart
│   ├── search_screen.dart
│   ├── product_detail_screen.dart
│   ├── sellers_screen.dart
│   └── seller_profile_screen.dart
└── widgets/
    └── cards.dart         # ProductCard, SellerCard
```

## Requirements

- Flutter SDK ≥ 3.12
- Dart SDK ≥ 3.12
- Xcode (for iOS builds)
- Android Studio / Android SDK (for Android builds)
