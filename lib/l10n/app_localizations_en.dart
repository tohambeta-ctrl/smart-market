// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Smart Market';

  @override
  String get appTagline => 'Connecting Buyers and Sellers with Confidence.';

  @override
  String get splashTitle => 'Smart Marketplace';

  @override
  String get splashFresh => 'FRESH';

  @override
  String get splashLocal => 'LOCAL';

  @override
  String get splashSecure => 'SECURE';

  @override
  String get splashPoweredBy => 'POWERED BY SECURE237';

  @override
  String get navMarket => 'Market';

  @override
  String get navSearch => 'Search';

  @override
  String get navSellers => 'Sellers';

  @override
  String get homeSearchHint => 'Search products, prices, sellers…';

  @override
  String get homeMarketPrices => 'Market Prices';

  @override
  String get homeCategoryAll => 'All';

  @override
  String get homeCategoryVegetables => 'Vegetables';

  @override
  String get homeCategoryGrains => 'Grains';

  @override
  String get homeCategoryOilsFats => 'Oils & Fats';

  @override
  String get homeCategorySweeteners => 'Sweeteners';

  @override
  String get searchHint => 'Search products, prices…';

  @override
  String get searchPopularSearches => 'Popular Searches';

  @override
  String searchNoResults(String query) {
    return 'No results for \"$query\"';
  }

  @override
  String searchResultCount(int count, String query) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count results for \"$query\"',
      one: '1 result for \"$query\"',
    );
    return '$_temp0';
  }

  @override
  String get searchSuggestionTomatoes => 'Tomatoes';

  @override
  String get searchSuggestionMaizeFlour => 'Maize Flour';

  @override
  String get searchSuggestionRice => 'Rice';

  @override
  String get searchSuggestionSugar => 'Sugar';

  @override
  String get searchSuggestionCookingOil => 'Cooking Oil';

  @override
  String get sellersTitle => 'Trusted Sellers';

  @override
  String get sellersVerified => 'Verified';

  @override
  String sellersFoundCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sellers found',
      one: '1 seller found',
    );
    return '$_temp0';
  }

  @override
  String get productSellerInfo => 'Seller Information';

  @override
  String get productSeller => 'Seller';

  @override
  String get productLocation => 'Location';

  @override
  String get productRating => 'Rating';

  @override
  String productReviews(int count) {
    return '$count reviews';
  }

  @override
  String productPer(String unit) {
    return 'per $unit';
  }

  @override
  String get productPriceComparison => 'Price Comparison';

  @override
  String productOtherSellers(String category) {
    return 'Other sellers in $category';
  }

  @override
  String get productViewSellerProfile => 'View Seller Profile';

  @override
  String get productContactSeller => 'Contact Seller';

  @override
  String get sellerRating => 'Rating';

  @override
  String get sellerReviews => 'Reviews';

  @override
  String get sellerProducts => 'Products';

  @override
  String get sellerPhone => 'Phone';

  @override
  String get sellerStatus => 'Status';

  @override
  String get sellerVerifiedStatus => 'Verified Seller';

  @override
  String sellerCallButton(String name) {
    return 'Call $name';
  }

  @override
  String get sellerSendMessage => 'Send Message';

  @override
  String get sellerListedProducts => 'Listed Products';

  @override
  String get languageToggleLabel => 'Français';
}
