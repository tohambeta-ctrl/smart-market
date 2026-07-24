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
  String get navCategories => 'Categories';

  @override
  String get navSell => 'Sell';

  @override
  String get navOrders => 'Orders';

  @override
  String get navProfile => 'Profile';

  @override
  String get homeBannerTitle => 'Up to 40% Off\nFresh Produce';

  @override
  String get homeBannerSubtitle => 'Shop today\'s best market deals';

  @override
  String get homeBannerCta => 'SHOP NOW';

  @override
  String get homeRecommended => 'Recommended for You';

  @override
  String get homeViewAll => 'View All';

  @override
  String get homeSellTitle => 'Sell on Smart Marketplace';

  @override
  String get homeSellBody =>
      'Reach thousands of buyers in Cameroon today. Start your business in minutes.';

  @override
  String get homeSellCta => 'Get Started';

  @override
  String get homeSaleBadge => 'SALE';

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
  String get productDescription => 'Description';

  @override
  String get productSpecifications => 'Specifications';

  @override
  String get productReviewsTitle => 'Reviews & Ratings';

  @override
  String get productAddToCart => 'Add to Cart';

  @override
  String get productBuyNow => 'Buy Now';

  @override
  String get productReadMore => 'Read more';

  @override
  String get productReadLess => 'Read less';

  @override
  String productAllReviews(int count) {
    return 'See all $count reviews';
  }

  @override
  String get productNoReviews => 'No reviews yet.';

  @override
  String productImageAlt(int index) {
    return 'Product image $index';
  }

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

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingGetStarted => 'Get Started';

  @override
  String get onboarding1Title => 'Find & Compare';

  @override
  String get onboarding1Body =>
      'Easily find the products you need and use real-time price comparisons to ensure you\'re getting the best value.';

  @override
  String get onboarding2Title => 'Connect with Sellers';

  @override
  String get onboarding2Body =>
      'Discover trusted local sellers near you, view their profiles, and contact them directly with confidence.';

  @override
  String get onboarding3Title => 'Stay Informed';

  @override
  String get onboarding3Body =>
      'Get live market price alerts and trend updates so you always know when to buy or sell at the right moment.';

  @override
  String get authTitle => 'Smart Marketplace';

  @override
  String get authTagline =>
      'The most trusted digital bridge for commerce in Cameroon.';

  @override
  String get authTabLogin => 'LOGIN';

  @override
  String get authTabSignUp => 'SIGN UP';

  @override
  String get authRoleBuyer => 'BUYER';

  @override
  String get authRoleSeller => 'SELLER';

  @override
  String get authEmailOrPhone => 'Email or Phone Number';

  @override
  String get authPassword => 'Password';

  @override
  String get authConfirmPassword => 'Confirm Password';

  @override
  String get authFullName => 'Full Name';

  @override
  String get authForgotPassword => 'Forgot Password?';

  @override
  String get authLoginButton => 'Login';

  @override
  String get authSignUpButton => 'Sign Up';

  @override
  String get authOrContinueWith => 'OR CONTINUE WITH';

  @override
  String get authGoogle => 'GOOGLE';

  @override
  String get authFacebook => 'FACEBOOK';

  @override
  String get authSecurePaymentsVia => 'SECURE PAYMENTS VIA';

  @override
  String get authLoginSuccess => 'Welcome back!';

  @override
  String get authSignUpSuccess => 'Account created successfully!';

  @override
  String get authErrorEmptyFields => 'Please fill in all fields.';

  @override
  String get authErrorPasswordMismatch => 'Passwords do not match.';

  @override
  String get authErrorShortPassword =>
      'Password must be at least 6 characters.';

  @override
  String get authSignInRequired => 'Sign in required';

  @override
  String get authSignInRequiredMessage =>
      'Please sign in or create an account to continue.';

  @override
  String get authSignIn => 'Sign In';

  @override
  String get authCreateAccount => 'Create Account';

  @override
  String get authContinueAsGuest => 'Continue as Guest';

  @override
  String get authBackToApp => '← Back to App';

  @override
  String get profileGuestName => 'Guest User';

  @override
  String get profileSignInRegister => 'Sign In / Register';

  @override
  String get profileSignOut => 'Sign Out';

  @override
  String get profileAccount => 'Account';

  @override
  String get profileMyProfile => 'My Profile';

  @override
  String get profileAddresses => 'Addresses';

  @override
  String get profilePaymentMethods => 'Payment Methods';

  @override
  String get profileShopping => 'Shopping';

  @override
  String get profileWishlist => 'Wishlist';

  @override
  String get profileOrderHistory => 'Order History';

  @override
  String get profileMyStore => 'My Store';

  @override
  String get profilePreferences => 'Preferences';

  @override
  String get profileNotifications => 'Notifications';

  @override
  String get profileHelpSupport => 'Help & Support';

  @override
  String get profileAbout => 'About Smart Market';

  @override
  String get categoriesSearchHint => 'Search categories...';

  @override
  String get categoriesExplore => 'Explore Categories';

  @override
  String get categoriesBannerBadge => 'SPECIAL OFFER';

  @override
  String get categoriesBannerTitle => 'Up to 30% off on\nAgriculture tools';

  @override
  String get categoriesShopNow => 'SHOP NOW';
}
