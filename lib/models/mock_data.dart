import 'models.dart';

// ---------------------------------------------------------------------------
// Extra doodle image slots — empty string signals the UI to render a
// category-tinted doodle placeholder instead of a network image.
// ---------------------------------------------------------------------------
const _doodle = '';

// ---------------------------------------------------------------------------
// Products
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
    imageUrl:
        'https://cdn.dummyjson.com/product-images/mobile-accessories/apple-airpods-max-silver/thumbnail.webp',
    extraImages: [_doodle, _doodle, _doodle],
    isFeatured: true,
    description:
        'Experience studio-quality sound wherever you go. The Premium Wireless Pro Headphones 2.0 feature active noise cancellation, a 30-hour battery life, and ultra-comfortable memory foam ear cushions. Compatible with all Bluetooth 5.2 devices, these headphones deliver crisp highs and deep bass for music, calls, and everything in between.',
    specs: const [
      ProductSpec('Connectivity', 'Bluetooth 5.2'),
      ProductSpec('Battery Life', '30 hours'),
      ProductSpec('Noise Cancellation', 'Active (ANC)'),
      ProductSpec('Driver Size', '40 mm'),
      ProductSpec('Weight', '250 g'),
      ProductSpec('Warranty', '1 year'),
    ],
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
    imageUrl:
        "https://cdn.dummyjson.com/product-images/womens-bags/heshe-women's-leather-bag/thumbnail.webp",
    extraImages: [_doodle, _doodle, _doodle],
    isFeatured: true,
    description:
        'Crafted from full-grain genuine leather, this elegant forest green handbag blends timeless style with everyday practicality. Features multiple interior pockets, a secure magnetic clasp, and an adjustable strap. Handmade by local artisans in Douala.',
    specs: const [
      ProductSpec('Material', 'Full-grain genuine leather'),
      ProductSpec('Dimensions', '32 × 24 × 12 cm'),
      ProductSpec('Strap', 'Adjustable, detachable'),
      ProductSpec('Closure', 'Magnetic clasp'),
      ProductSpec('Interior Pockets', '3 (1 zipped)'),
      ProductSpec('Colour', 'Forest Green'),
    ],
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
    imageUrl:
        'https://cdn.dummyjson.com/product-images/kitchen-accessories/boxed-blender/thumbnail.webp',
    extraImages: [_doodle, _doodle, _doodle],
    isFeatured: false,
    description:
        'Brew the perfect cup from anywhere with the Smart Coffee Maker. Schedule brews, adjust temperature, and monitor your coffee from the companion mobile app. Supports 4–12 cup capacity and keeps your coffee warm for up to 2 hours automatically.',
    specs: const [
      ProductSpec('Capacity', '12 cups (1.5 L)'),
      ProductSpec('Power', '1000 W'),
      ProductSpec('Connectivity', 'Wi-Fi + Bluetooth'),
      ProductSpec('Keep Warm', 'Up to 2 hours'),
      ProductSpec('Filter', 'Reusable mesh'),
      ProductSpec('Warranty', '2 years'),
    ],
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
    imageUrl:
        'https://cdn.dummyjson.com/product-images/mens-shoes/puma-future-rider-trainers/thumbnail.webp',
    extraImages: [_doodle, _doodle, _doodle],
    isFeatured: true,
    description:
        'Designed for speed and comfort, the Swift-Run trainers combine a lightweight mesh upper with responsive foam cushioning. The grippy rubber outsole handles both track and urban terrain. Available in sizes 38–46.',
    specs: const [
      ProductSpec('Upper', 'Breathable mesh'),
      ProductSpec('Sole', 'Rubber outsole'),
      ProductSpec('Cushioning', 'Responsive EVA foam'),
      ProductSpec('Closure', 'Lace-up'),
      ProductSpec('Available Sizes', '38 – 46'),
      ProductSpec('Weight', '280 g (size 42)'),
    ],
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
    imageUrl:
        'https://cdn.dummyjson.com/product-images/skin-care/olay-ultra-moisture-shea-butter-body-wash/thumbnail.webp',
    extraImages: [_doodle, _doodle, _doodle],
    isFeatured: false,
    description:
        'A complete skincare routine in one box. This set includes a gentle foaming cleanser, hydrating toner, vitamin C serum, and nourishing moisturiser — all made with certified organic ingredients sourced from Cameroonian farms. Suitable for all skin types, dermatologist tested, and free from parabens and sulphates.',
    specs: const [
      ProductSpec('Items in Set', '4 products'),
      ProductSpec('Key Ingredient', 'Vitamin C + Shea Butter'),
      ProductSpec('Skin Type', 'All skin types'),
      ProductSpec('Certification', 'Organic certified'),
      ProductSpec('Paraben Free', 'Yes'),
      ProductSpec('Volume', '30 mL – 150 mL per item'),
    ],
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
    imageUrl:
        'https://cdn.dummyjson.com/product-images/home-decoration/table-lamp/thumbnail.webp',
    extraImages: [_doodle, _doodle, _doodle],
    isFeatured: false,
    description:
        'Bring warm Nordic style to your workspace. This LED desk lamp features a solid acacia wood base, touch-sensitive dimmer (3 brightness levels), and a 5 W LED bulb rated for 25,000 hours. USB-C charging port on the base keeps your devices topped up.',
    specs: const [
      ProductSpec('Bulb', 'LED 5 W (included)'),
      ProductSpec('Lifespan', '25,000 hours'),
      ProductSpec('Brightness Levels', '3 (touch dimmer)'),
      ProductSpec('Base Material', 'Acacia wood'),
      ProductSpec('USB Charging', 'USB-C 5 W'),
      ProductSpec('Cable Length', '1.8 m'),
    ],
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
    imageUrl:
        'https://cdn.dummyjson.com/product-images/groceries/red-onions/thumbnail.webp',
    extraImages: [_doodle, _doodle, _doodle],
    isFeatured: false,
    description:
        'Grown without pesticides on the fertile banks of the Mbam river, these vine-ripened tomatoes are harvested fresh every morning and delivered the same day. Rich in flavour, perfect for sauces, salads, and traditional ndolé.',
    specs: const [
      ProductSpec('Origin', 'Bafia, Centre Region'),
      ProductSpec('Farming', 'Organic / pesticide-free'),
      ProductSpec('Harvest', 'Daily (morning)'),
      ProductSpec('Shelf Life', '5 – 7 days (refrigerated)'),
      ProductSpec('Min. Order', '1 kg'),
      ProductSpec('Packaging', 'Eco-friendly basket'),
    ],
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
    imageUrl:
        'https://cdn.dummyjson.com/product-images/laptops/apple-macbook-pro-14-inch-space-grey/thumbnail.webp',
    extraImages: [_doodle, _doodle, _doodle],
    isFeatured: true,
    description:
        'The Laptop Pro 15" packs professional performance into a feather-light 1.4 kg aluminium chassis. With a 12-core CPU, 16 GB RAM, and a stunning 15.3" Liquid Retina display, it handles creative work, programming, and multitasking effortlessly. 18-hour battery life keeps you productive all day.',
    specs: const [
      ProductSpec('Processor', '12-core CPU'),
      ProductSpec('RAM', '16 GB unified memory'),
      ProductSpec('Storage', '512 GB SSD'),
      ProductSpec('Display', '15.3" Liquid Retina, 2560×1664'),
      ProductSpec('Battery', 'Up to 18 hours'),
      ProductSpec('Weight', '1.4 kg'),
    ],
  ),
];

// ---------------------------------------------------------------------------
// Reviews
// ---------------------------------------------------------------------------
final sampleReviews = <ProductReview>[
  // Product 1 — Headphones
  ProductReview(
    id: 'r1',
    productId: '1',
    reviewerName: 'Alain M.',
    rating: 5.0,
    comment:
        'Son exceptionnel, très bon pour les appels. La réduction de bruit est incroyable !',
    date: DateTime(2025, 6, 12),
  ),
  ProductReview(
    id: 'r2',
    productId: '1',
    reviewerName: 'Sandra K.',
    rating: 4.5,
    comment:
        'Great quality and very comfortable for long sessions. Battery lasts all day.',
    date: DateTime(2025, 5, 28),
  ),
  ProductReview(
    id: 'r3',
    productId: '1',
    reviewerName: 'Patrick N.',
    rating: 4.0,
    comment: 'Bon produit mais le sac de transport aurait été apprécié.',
    date: DateTime(2025, 5, 10),
  ),

  // Product 2 — Handbag
  ProductReview(
    id: 'r4',
    productId: '2',
    reviewerName: 'Marie-Claire F.',
    rating: 5.0,
    comment: 'Magnifique sac, cuir de très bonne qualité. Reçu en 2 jours !',
    date: DateTime(2025, 6, 18),
  ),
  ProductReview(
    id: 'r5',
    productId: '2',
    reviewerName: 'Diane T.',
    rating: 4.0,
    comment: 'Beautiful bag, exactly as described. The strap is very sturdy.',
    date: DateTime(2025, 6, 2),
  ),

  // Product 3 — Coffee Maker
  ProductReview(
    id: 'r6',
    productId: '3',
    reviewerName: 'Jean-Paul B.',
    rating: 4.5,
    comment:
        "Préparer le café depuis mon téléphone le matin, c'est magique. Très content.",
    date: DateTime(2025, 7, 1),
  ),
  ProductReview(
    id: 'r7',
    productId: '3',
    reviewerName: 'Estelle O.',
    rating: 4.0,
    comment:
        'Works great, app is intuitive. Would have given 5 stars but setup took a while.',
    date: DateTime(2025, 6, 20),
  ),

  // Product 4 — Trainers
  ProductReview(
    id: 'r8',
    productId: '4',
    reviewerName: 'Rodrigue A.',
    rating: 5.0,
    comment:
        'Super légères et très confortables. Je cours 10 km chaque matin avec.',
    date: DateTime(2025, 7, 5),
  ),
  ProductReview(
    id: 'r9',
    productId: '4',
    reviewerName: 'Chris M.',
    rating: 4.5,
    comment: 'Great fit and grip. The green colour is even nicer in person.',
    date: DateTime(2025, 6, 30),
  ),

  // Product 5 — Skincare
  ProductReview(
    id: 'r10',
    productId: '5',
    reviewerName: 'Nadège E.',
    rating: 5.0,
    comment:
        "Ma peau n'a jamais été aussi douce. Produits 100% naturels, je recommande !",
    date: DateTime(2025, 7, 8),
  ),
  ProductReview(
    id: 'r11',
    productId: '5',
    reviewerName: 'Grace W.',
    rating: 5.0,
    comment:
        'Excellent set. The vitamin C serum is a game-changer for my skin.',
    date: DateTime(2025, 7, 3),
  ),

  // Product 6 — Lamp
  ProductReview(
    id: 'r12',
    productId: '6',
    reviewerName: 'Hervé D.',
    rating: 4.0,
    comment:
        'Très belle lampe, le bois est vraiment de qualité. Lumière douce et agréable.',
    date: DateTime(2025, 6, 14),
  ),

  // Product 7 — Tomatoes
  ProductReview(
    id: 'r13',
    productId: '7',
    reviewerName: 'Bernadette T.',
    rating: 5.0,
    comment:
        'Les meilleures tomates du marché ! Fraîches, livrées tôt le matin.',
    date: DateTime(2025, 7, 10),
  ),
  ProductReview(
    id: 'r14',
    productId: '7',
    reviewerName: 'Mama Nguemo',
    rating: 5.0,
    comment: 'Je commande chaque semaine. Qualité constante, jamais déçue.',
    date: DateTime(2025, 7, 9),
  ),

  // Product 8 — Laptop
  ProductReview(
    id: 'r15',
    productId: '8',
    reviewerName: 'Fabrice L.',
    rating: 5.0,
    comment:
        "Excellent laptop, ultra rapide. Le meilleur achat que j'ai fait cette année.",
    date: DateTime(2025, 6, 25),
  ),
  ProductReview(
    id: 'r16',
    productId: '8',
    reviewerName: 'Emmanuel K.',
    rating: 4.0,
    comment:
        'Very powerful and light. Battery is outstanding. Great value for money.',
    date: DateTime(2025, 6, 18),
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
