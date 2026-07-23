// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Smart Market';

  @override
  String get appTagline =>
      'Connecter Acheteurs et Vendeurs en Toute Confiance.';

  @override
  String get splashTitle => 'Marché Intelligent';

  @override
  String get splashFresh => 'FRAIS';

  @override
  String get splashLocal => 'LOCAL';

  @override
  String get splashSecure => 'SÉCURISÉ';

  @override
  String get splashPoweredBy => 'PROPULSÉ PAR SECURE237';

  @override
  String get navMarket => 'Marché';

  @override
  String get navSearch => 'Recherche';

  @override
  String get navSellers => 'Vendeurs';

  @override
  String get navCategories => 'Catégories';

  @override
  String get navSell => 'Vendre';

  @override
  String get navOrders => 'Commandes';

  @override
  String get navProfile => 'Profil';

  @override
  String get homeBannerTitle => 'Jusqu\'à 40% de\nRéduction';

  @override
  String get homeBannerSubtitle =>
      'Les meilleures offres du marché aujourd\'hui';

  @override
  String get homeRecommended => 'Recommandé pour Vous';

  @override
  String get homeViewAll => 'Voir Tout';

  @override
  String get homeSellTitle => 'Vendez sur Smart Marketplace';

  @override
  String get homeSellBody =>
      'Atteignez des milliers d\'acheteurs au Cameroun. Démarrez votre activité en quelques minutes.';

  @override
  String get homeSellCta => 'Commencer';

  @override
  String get homeSaleBadge => 'PROMO';

  @override
  String get homeSearchHint => 'Rechercher produits, prix, vendeurs…';

  @override
  String get homeMarketPrices => 'Prix du Marché';

  @override
  String get homeCategoryAll => 'Tout';

  @override
  String get homeCategoryVegetables => 'Légumes';

  @override
  String get homeCategoryGrains => 'Céréales';

  @override
  String get homeCategoryOilsFats => 'Huiles & Graisses';

  @override
  String get homeCategorySweeteners => 'Édulcorants';

  @override
  String get searchHint => 'Rechercher produits, prix…';

  @override
  String get searchPopularSearches => 'Recherches Populaires';

  @override
  String searchNoResults(String query) {
    return 'Aucun résultat pour \"$query\"';
  }

  @override
  String searchResultCount(int count, String query) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count résultats pour \"$query\"',
      one: '1 résultat pour \"$query\"',
    );
    return '$_temp0';
  }

  @override
  String get searchSuggestionTomatoes => 'Tomates';

  @override
  String get searchSuggestionMaizeFlour => 'Farine de Maïs';

  @override
  String get searchSuggestionRice => 'Riz';

  @override
  String get searchSuggestionSugar => 'Sucre';

  @override
  String get searchSuggestionCookingOil => 'Huile de Cuisson';

  @override
  String get sellersTitle => 'Vendeurs de Confiance';

  @override
  String get sellersVerified => 'Vérifié';

  @override
  String sellersFoundCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vendeurs trouvés',
      one: '1 vendeur trouvé',
    );
    return '$_temp0';
  }

  @override
  String get productSellerInfo => 'Informations sur le Vendeur';

  @override
  String get productSeller => 'Vendeur';

  @override
  String get productLocation => 'Localisation';

  @override
  String get productRating => 'Note';

  @override
  String productReviews(int count) {
    return '$count avis';
  }

  @override
  String productPer(String unit) {
    return 'par $unit';
  }

  @override
  String get productPriceComparison => 'Comparaison des Prix';

  @override
  String productOtherSellers(String category) {
    return 'Autres vendeurs en $category';
  }

  @override
  String get productViewSellerProfile => 'Voir le Profil du Vendeur';

  @override
  String get productContactSeller => 'Contacter le Vendeur';

  @override
  String get sellerRating => 'Note';

  @override
  String get sellerReviews => 'Avis';

  @override
  String get sellerProducts => 'Produits';

  @override
  String get sellerPhone => 'Téléphone';

  @override
  String get sellerStatus => 'Statut';

  @override
  String get sellerVerifiedStatus => 'Vendeur Vérifié';

  @override
  String sellerCallButton(String name) {
    return 'Appeler $name';
  }

  @override
  String get sellerSendMessage => 'Envoyer un Message';

  @override
  String get sellerListedProducts => 'Produits Listés';

  @override
  String get languageToggleLabel => 'English';

  @override
  String get onboardingSkip => 'Ignorer';

  @override
  String get onboardingNext => 'Suivant';

  @override
  String get onboardingGetStarted => 'Commencer';

  @override
  String get onboarding1Title => 'Trouver & Comparer';

  @override
  String get onboarding1Body =>
      'Trouvez facilement les produits dont vous avez besoin et comparez les prix en temps réel pour obtenir la meilleure valeur.';

  @override
  String get onboarding2Title => 'Connectez-vous aux Vendeurs';

  @override
  String get onboarding2Body =>
      'Découvrez des vendeurs locaux de confiance près de chez vous, consultez leurs profils et contactez-les directement.';

  @override
  String get onboarding3Title => 'Restez Informé';

  @override
  String get onboarding3Body =>
      'Recevez des alertes de prix du marché et des mises à jour sur les tendances pour toujours savoir quand acheter ou vendre.';
}
