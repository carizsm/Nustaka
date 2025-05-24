import 'package:flutter/material.dart';
import 'notification_page.dart';
import 'wishlist_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String selectedCategory = 'Semua';

  final categories = [
    'Semua',
    'Jawa Timur',
    'Madura',
    'Jawa Barat',
    'Kalimantan Selatan',
  ];

  // Data produk
  final List<Product> allProducts = [
    Product(
      title: "Sate Madura Haji Nanang",
      price: "Rp 35.000",
      rating: "4.8 • 100+ terjual",
      location: "Madura",
      imagePath: "assets/images/sate_madura.png",
      category: "Madura",
      iconPath: ""
    ),
    Product(
      title: "Mie Kocok",
      price: "Rp 30.000",
      rating: "4.7 • 100+ terjual",
      location: "Bandung, Jawa Barat",
      imagePath: "assets/images/mie_kocok.png",
      category: "Jawa Barat",
      iconPath: "assets/icons/makanan.png"
    ),
    Product(
      title: "Bakso Malang Jl. Keraton",
      price: "Rp 18.000",
      rating: "4.5 • 10rb+ terjual",
      location: "Jawa Timur",
      imagePath: "assets/images/bakso_malang.png",
      category: "Jawa Timur",
      iconPath: ""
    ),
    Product(
      title: "Batagor",
      price: "Rp 15.000",
      rating: "4.9 • 100+ terjual",
      location: "Bandung, Jawa Barat",
      imagePath: "assets/images/batagor.png",
      category: "Jawa Barat",
      iconPath: "assets/icons/makanan.png"
    ),
    Product(
      title: "Sepatu Kulit",
      price: "Rp 150.000",
      rating: "4.8 • 50+ terjual",
      location: "Garut, Jawa Barat",
      imagePath: "assets/images/sepatu_kulit.png",
      category: "Jawa Barat",
      iconPath: "assets/icons/kerajinan.png",
    ),
    Product(
      title: "Baju Batik Megamendung",
      price: "Rp 140.000",
      rating: "4.7 • 100+ terjual",
      location: "Cirebon, Jawa Barat",
      imagePath: "assets/images/batik_megamendung.png",
      category: "Jawa Barat",
      iconPath: "assets/icons/kerajinan.png",
    ),
  ];

  List<Product> get filteredProducts {
    if (selectedCategory == 'Semua') return allProducts;
    return allProducts.where((p) => p.category == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF86A340),
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Container(
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xFF86A340), width: 1),
            ),
            child: TextField(
              style: const TextStyle(color: Colors.red),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 12),
                hintText: 'Cari barang...',
                hintStyle: const TextStyle(color: Colors.red),
                prefixIcon: const Icon(Icons.search, color: Colors.red),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),

      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kategori',
                  style: TextStyle(
                    color: Color(0xFF86A340),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  iconEnabledColor: Color(0xFF86A340),
                  dropdownColor: Colors.white,
                  value: selectedCategory,
                  style: TextStyle(color: Color(0xFF86A340)),
                  items: categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category, style: TextStyle(color: Color(0xFF86A340))),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(10),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.75,
              children: filteredProducts.map((product) {
                return selectedCategory == "Jawa Barat"
                    ? buildSimpleCard(product)
                    : buildProductCard(product);
              }).toList(),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF86A340),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const WishlistPage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Wishlist'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Transaction'),
        ],
      ),
    );
  }

  // Card tampilan umum (Semua, Madura, dll)
  Widget buildProductCard(Product product) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(
              product.imagePath,
              height: 130,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.title, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(product.price, style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 14),
                    SizedBox(width: 4),
                    Text(product.rating, style: TextStyle(fontSize: 12)),
                  ],
                ),
                SizedBox(height: 5),
                Text(product.location, style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Card tampilan untuk kategori Jawa Barat
  Widget buildSimpleCard(Product product) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(
              product.imagePath,
              height: 130,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      product.iconPath,
                      height: 20,
                      width: 20,
                      errorBuilder: (context, error, stackTrace) => SizedBox(), // Prevent crash if icon not found
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        product.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  product.location,
                  style: TextStyle(color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Product {
  final String title;
  final String price;
  final String rating;
  final String location;
  final String imagePath;
  final String category;
  final String iconPath;

  Product({
    required this.title,
    required this.price,
    required this.rating,
    required this.location,
    required this.imagePath,
    required this.category,
    required this.iconPath,
  });
}
