import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'Smart Market'**
  String get appTitle;

  /// Splash screen tagline
  ///
  /// In en, this message translates to:
  /// **'Connecting Buyers and Sellers with Confidence.'**
  String get appTagline;

  /// Splash screen main title
  ///
  /// In en, this message translates to:
  /// **'Smart Marketplace'**
  String get splashTitle;

  /// No description provided for @splashFresh.
  ///
  /// In en, this message translates to:
  /// **'FRESH'**
  String get splashFresh;

  /// No description provided for @splashLocal.
  ///
  /// In en, this message translates to:
  /// **'LOCAL'**
  String get splashLocal;

  /// No description provided for @splashSecure.
  ///
  /// In en, this message translates to:
  /// **'SECURE'**
  String get splashSecure;

  /// No description provided for @splashPoweredBy.
  ///
  /// In en, this message translates to:
  /// **'POWERED BY SECURE237'**
  String get splashPoweredBy;

  /// Bottom nav label for home/market tab
  ///
  /// In en, this message translates to:
  /// **'Market'**
  String get navMarket;

  /// No description provided for @navSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get navSearch;

  /// No description provided for @navSellers.
  ///
  /// In en, this message translates to:
  /// **'Sellers'**
  String get navSellers;

  /// No description provided for @navCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get navCategories;

  /// No description provided for @navSell.
  ///
  /// In en, this message translates to:
  /// **'Sell'**
  String get navSell;

  /// No description provided for @navOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get navOrders;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @homeBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Up to 40% Off\nFresh Produce'**
  String get homeBannerTitle;

  /// No description provided for @homeBannerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Shop today\'s best market deals'**
  String get homeBannerSubtitle;

  /// No description provided for @homeRecommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended for You'**
  String get homeRecommended;

  /// No description provided for @homeViewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get homeViewAll;

  /// No description provided for @homeSellTitle.
  ///
  /// In en, this message translates to:
  /// **'Sell on Smart Marketplace'**
  String get homeSellTitle;

  /// No description provided for @homeSellBody.
  ///
  /// In en, this message translates to:
  /// **'Reach thousands of buyers in Cameroon today. Start your business in minutes.'**
  String get homeSellBody;

  /// No description provided for @homeSellCta.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get homeSellCta;

  /// No description provided for @homeSaleBadge.
  ///
  /// In en, this message translates to:
  /// **'SALE'**
  String get homeSaleBadge;

  /// No description provided for @homeSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search products, prices, sellers…'**
  String get homeSearchHint;

  /// No description provided for @homeMarketPrices.
  ///
  /// In en, this message translates to:
  /// **'Market Prices'**
  String get homeMarketPrices;

  /// No description provided for @homeCategoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get homeCategoryAll;

  /// No description provided for @homeCategoryVegetables.
  ///
  /// In en, this message translates to:
  /// **'Vegetables'**
  String get homeCategoryVegetables;

  /// No description provided for @homeCategoryGrains.
  ///
  /// In en, this message translates to:
  /// **'Grains'**
  String get homeCategoryGrains;

  /// No description provided for @homeCategoryOilsFats.
  ///
  /// In en, this message translates to:
  /// **'Oils & Fats'**
  String get homeCategoryOilsFats;

  /// No description provided for @homeCategorySweeteners.
  ///
  /// In en, this message translates to:
  /// **'Sweeteners'**
  String get homeCategorySweeteners;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search products, prices…'**
  String get searchHint;

  /// No description provided for @searchPopularSearches.
  ///
  /// In en, this message translates to:
  /// **'Popular Searches'**
  String get searchPopularSearches;

  /// No description provided for @searchNoResults.
  ///
  /// In en, this message translates to:
  /// **'No results for \"{query}\"'**
  String searchNoResults(String query);

  /// No description provided for @searchResultCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 result for \"{query}\"} other{{count} results for \"{query}\"}}'**
  String searchResultCount(int count, String query);

  /// No description provided for @searchSuggestionTomatoes.
  ///
  /// In en, this message translates to:
  /// **'Tomatoes'**
  String get searchSuggestionTomatoes;

  /// No description provided for @searchSuggestionMaizeFlour.
  ///
  /// In en, this message translates to:
  /// **'Maize Flour'**
  String get searchSuggestionMaizeFlour;

  /// No description provided for @searchSuggestionRice.
  ///
  /// In en, this message translates to:
  /// **'Rice'**
  String get searchSuggestionRice;

  /// No description provided for @searchSuggestionSugar.
  ///
  /// In en, this message translates to:
  /// **'Sugar'**
  String get searchSuggestionSugar;

  /// No description provided for @searchSuggestionCookingOil.
  ///
  /// In en, this message translates to:
  /// **'Cooking Oil'**
  String get searchSuggestionCookingOil;

  /// No description provided for @sellersTitle.
  ///
  /// In en, this message translates to:
  /// **'Trusted Sellers'**
  String get sellersTitle;

  /// No description provided for @sellersVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get sellersVerified;

  /// No description provided for @sellersFoundCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 seller found} other{{count} sellers found}}'**
  String sellersFoundCount(int count);

  /// No description provided for @productSellerInfo.
  ///
  /// In en, this message translates to:
  /// **'Seller Information'**
  String get productSellerInfo;

  /// No description provided for @productSeller.
  ///
  /// In en, this message translates to:
  /// **'Seller'**
  String get productSeller;

  /// No description provided for @productLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get productLocation;

  /// No description provided for @productRating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get productRating;

  /// No description provided for @productReviews.
  ///
  /// In en, this message translates to:
  /// **'{count} reviews'**
  String productReviews(int count);

  /// No description provided for @productPer.
  ///
  /// In en, this message translates to:
  /// **'per {unit}'**
  String productPer(String unit);

  /// No description provided for @productPriceComparison.
  ///
  /// In en, this message translates to:
  /// **'Price Comparison'**
  String get productPriceComparison;

  /// No description provided for @productOtherSellers.
  ///
  /// In en, this message translates to:
  /// **'Other sellers in {category}'**
  String productOtherSellers(String category);

  /// No description provided for @productViewSellerProfile.
  ///
  /// In en, this message translates to:
  /// **'View Seller Profile'**
  String get productViewSellerProfile;

  /// No description provided for @productContactSeller.
  ///
  /// In en, this message translates to:
  /// **'Contact Seller'**
  String get productContactSeller;

  /// No description provided for @sellerRating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get sellerRating;

  /// No description provided for @sellerReviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get sellerReviews;

  /// No description provided for @sellerProducts.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get sellerProducts;

  /// No description provided for @sellerPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get sellerPhone;

  /// No description provided for @sellerStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get sellerStatus;

  /// No description provided for @sellerVerifiedStatus.
  ///
  /// In en, this message translates to:
  /// **'Verified Seller'**
  String get sellerVerifiedStatus;

  /// No description provided for @sellerCallButton.
  ///
  /// In en, this message translates to:
  /// **'Call {name}'**
  String sellerCallButton(String name);

  /// No description provided for @sellerSendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get sellerSendMessage;

  /// No description provided for @sellerListedProducts.
  ///
  /// In en, this message translates to:
  /// **'Listed Products'**
  String get sellerListedProducts;

  /// Label shown on language toggle button when current language is English
  ///
  /// In en, this message translates to:
  /// **'Français'**
  String get languageToggleLabel;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @onboardingGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboardingGetStarted;

  /// No description provided for @onboarding1Title.
  ///
  /// In en, this message translates to:
  /// **'Find & Compare'**
  String get onboarding1Title;

  /// No description provided for @onboarding1Body.
  ///
  /// In en, this message translates to:
  /// **'Easily find the products you need and use real-time price comparisons to ensure you\'re getting the best value.'**
  String get onboarding1Body;

  /// No description provided for @onboarding2Title.
  ///
  /// In en, this message translates to:
  /// **'Connect with Sellers'**
  String get onboarding2Title;

  /// No description provided for @onboarding2Body.
  ///
  /// In en, this message translates to:
  /// **'Discover trusted local sellers near you, view their profiles, and contact them directly with confidence.'**
  String get onboarding2Body;

  /// No description provided for @onboarding3Title.
  ///
  /// In en, this message translates to:
  /// **'Stay Informed'**
  String get onboarding3Title;

  /// No description provided for @onboarding3Body.
  ///
  /// In en, this message translates to:
  /// **'Get live market price alerts and trend updates so you always know when to buy or sell at the right moment.'**
  String get onboarding3Body;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
