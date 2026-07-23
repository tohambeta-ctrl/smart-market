import 'models.dart';

// ---------------------------------------------------------------------------
// DummyJSON CDN thumbnails — free, no-auth, no rate-limit for prototyping.
// Pattern: https://cdn.dummyjson.com/products/images/{id}/thumbnail.webp
// We pick IDs that visually match the product category.
// ---------------------------------------------------------------------------
String _img(int id) =>
    'https://cdn.dummyjson.com/products/images/$id/thumbnail.webp';

// ---------------------------------------------------------------------------
// Products — Cameroon market context, prices in XAF
// ---------------------------------------------------------------------------
final sampleProducts = <Product>[
  Product(
    id: '1',
    name: 'Premium Wireless Pro Headphones 2.0',
    category: 'Electronics',
    price: 45000,
    unit: 'pcs',
    location: 'Yaoundé, Centre',
    sellerName: 'TechHub Cameroon',
    sellerId: 's1',
    rating: 4.7,
    reviewCount: 214,
    imageUrl: _img(1), // headphones
    isFeatured: true,
  ),
  Product(
    id: '2',
    name: 'Classic Leather Handbag – Forest Green',
    category: 'Fashion',
    price: 32500,
    unit: 'pcs',
    location: 'Douala, Littoral',
    sellerName: 'Mode Afrique',
    sellerId: 's2',
    rating: 4.5,
    reviewCount: 98,
    imageUrl: _img(25), // bag
    isFeatured: true,
  ),
  Product(
    id: '3',
    name: 'Smart Coffee Maker with App Control',
    category: 'Home',
    price: 85000,
    originalPrice: 110000,
    unit: 'pcs',
    location: 'Bafoussam, Ouest',
    sellerName: 'Électro Marché',
    sellerId: 's3',
    rating: 4.3,
    reviewCount: 55,
    imageUrl: _img(71), // kitchen appliance
    isFeatured: false,
  ),
  Product(
    id: '4',
    name: 'Swift-Run Athletic Trainers – Sport Green',
    category: 'Sports',
    price: 18000,
    unit: 'pcs',
    location: 'Douala, Littoral',
    sellerName: 'Sport Vert',
    sellerId: 's4',
    rating: 4.6,
    reviewCount: 173,
    imageUrl: _img(48), // sneakers
    isFeatured: true,
  ),
  Product(
    id: '5',
    name: 'Organic Glow Skincare Essentials',
    category: 'Beauty',
    price: 12500,
    unit: 'set',
    location: 'Yaoundé, Centre',
    sellerName: 'Beauté Naturelle',
    sellerId: 's5',
    rating: 4.8,
    reviewCount: 302,
    imageUrl: _img(85), // skincare
    isFeatured: false,
  ),
  Product(
    id: '6',
    name: 'Minimalist LED Desk Lamp – Nordic Wood',
    category: 'Home',
    price: 9800,
    unit: 'pcs',
    location: 'Ngaoundéré, Adamawa',
    sellerName: 'MaisonPlus',
    sellerId: 's6',
    rating: 4.4,
    reviewCount: 67,
    imageUrl: _img(76), // lamp / home decor
    isFeatured: false,
  ),
  Product(
    id: '7',
    name: 'Fraîches Tomates du Village',
    category: 'Food',
    price: 1500,
    unit: 'kg',
    location: 'Bafia, Centre',
    sellerName: 'Ferme Bio Mbam',
    sellerId: 's7',
    rating: 4.9,
    reviewCount: 411,
    imageUrl: _img(6), // food / produce
    isFeatured: false,
  ),
  Product(
    id: '8',
    name: 'Laptop Pro 15" Ultra Slim',
    category: 'Electronics',
    price: 380000,
    originalPrice: 450000,
    unit: 'pcs',
    location: 'Douala, Littoral',
    sellerName: 'TechHub Cameroon',
    sellerId: 's1',
    rating: 4.6,
    reviewCount: 89,
    imageUrl: _img(2), // laptop
    isFeatured: true,
  ),
];

// ---------------------------------------------------------------------------
// Sellers
// ---------------------------------------------------------------------------
final sampleSellers = <Seller>[
  const Seller(
    id: 's1',
    name: 'TechHub Cameroon',
    location: 'Douala, Littoral',
    category: 'Electronics',
    rating: 4.7,
    reviewCount: 303,
    isVerified: true,
    phone: '+237 6 70 00 00 01',
  ),
  const Seller(
    id: 's2',
    name: 'Mode Afrique',
    location: 'Douala, Littoral',
    category: 'Fashion',
    rating: 4.5,
    reviewCount: 98,
    isVerified: true,
    phone: '+237 6 70 00 00 02',
  ),
  const Seller(
    id: 's3',
    name: 'Électro Marché',
    location: 'Bafoussam, Ouest',
    category: 'Home & Appliances',
    rating: 4.3,
    reviewCount: 55,
    isVerified: false,
    phone: '+237 6 70 00 00 03',
  ),
  const Seller(
    id: 's4',
    name: 'Sport Vert',
    location: 'Douala, Littoral',
    category: 'Sports & Fitness',
    rating: 4.6,
    reviewCount: 173,
    isVerified: true,
    phone: '+237 6 70 00 00 04',
  ),
  const Seller(
    id: 's5',
    name: 'Beauté Naturelle',
    location: 'Yaoundé, Centre',
    category: 'Beauty & Wellness',
    rating: 4.8,
    reviewCount: 302,
    isVerified: true,
    phone: '+237 6 70 00 00 05',
  ),
  const Seller(
    id: 's6',
    name: 'MaisonPlus',
    location: 'Ngaoundéré, Adamawa',
    category: 'Home & Décor',
    rating: 4.4,
    reviewCount: 67,
    isVerified: false,
    phone: '+237 6 70 00 00 06',
  ),
  const Seller(
    id: 's7',
    name: 'Ferme Bio Mbam',
    location: 'Bafia, Centre',
    category: 'Fresh Produce',
    rating: 4.9,
    reviewCount: 411,
    isVerified: true,
    phone: '+237 6 70 00 00 07',
  ),
];
