import 'package:flutter/material.dart';
import 'notification_page.dart';
import 'wishlist_page.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String selectedCategory = 'Pilih atau ketik untuk menambahkan';
  final categories = [
  'Pilih atau ketik untuk menambahkan',
  'Jawa Timur',
  'Madura',
  'Jawa Barat',
  'Kalimantan Selatan',
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF86A340), 
        elevation: 0,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            style: TextStyle(color: Colors.red),
            decoration: InputDecoration(
              hintText: 'Cari barang...',
              hintStyle: TextStyle(color: Colors.red),
              prefixIcon: Icon(Icons.search, color: Colors.red),
              border: InputBorder.none,
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
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person, color: Colors.white),
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
              childAspectRatio: 0.85,
              children: [
                buildProductCard(
                  "Sate Madura Haji Nanang",
                  "Rp 35.000",
                  "4.8 • 100+ terjual",
                  "Madura",
                  "assets/images/sate_madura.png",
                ),
                buildProductCard(
                  "Mie Kocok Mang Ujang",
                  "Rp 30.000",
                  "4.7 • 100+ terjual",
                  "Jawa Barat",
                  "assets/images/mie_kocok.png",
                ),
                buildProductCard(
                  "Bakso Malang Jl. Keraton",
                  "Rp 18.000",
                  "4.5 • 100+ terjual",
                  "Jawa Timur",
                  "assets/images/bakso_malang.png",
                ),
                buildProductCard(
                  "Batagor Pasar Kordon",
                  "Rp 15.000",
                  "4.9 • 100+ terjual",
                  "Jawa Barat",
                  "assets/images/batagor.png",
                ),
              ],
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

  Widget buildProductCard(
  String title,
  String price,
  String rating,
  String location,
  String imagePath,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(
              imagePath,
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
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(price,
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 14),
                    SizedBox(width: 4),
                    Text(
                      rating,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(location,
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
