import 'package:flutter/material.dart';
import 'seller_order.dart';
import 'seller_transaction.dart';
import 'seller_tambah_produk.dart';
import 'seller_statistik_toko.dart';
import 'seller_statistik_produk.dart';
import 'seller_profil.dart';
import 'seller_user_data.dart';

class SellerHomepage extends StatefulWidget {
  const SellerHomepage({super.key});

  @override
  State<SellerHomepage> createState() => _SellerHomepageState();
}

class _SellerHomepageState extends State<SellerHomepage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const SellerHomeContent(),
    const SellerOrderPage(),
    const SellerTransactionPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF9EB23B),
        elevation: 0,
        title: Text(
          'Halo, $currentUsername',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SellerProfilPage()),
              );
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF9EB23B),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Transaction',
          ),
        ],
        selectedItemColor: Colors.yellowAccent,
        unselectedItemColor: Colors.white,
      ),
      floatingActionButton: _currentIndex == 0
        ? FloatingActionButton(
            backgroundColor: const Color(0xFF9EB23B),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TambahProdukPage(),
                ),
              );
            },
            child: const Icon(Icons.add, color: Colors.white),
          )
        : null,
    );
  }
}

class SellerHomeContent extends StatelessWidget {
  const SellerHomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDashboard(context),
          const SizedBox(height: 24),
          const Text(
            "Produk",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildProductCard(
            context,
            image: 'assets/images/sate_madura.png', // ganti dengan gambar asli
            name: 'Sate Madura',
            price: 'Rp 100.000',
            rating: '4.8 • 100+ terjual',
            visible: true,
          ),
          const SizedBox(height: 16),
          _buildProductCard(
            context,
            image: 'assets/images/sate_travis.png', // ganti dengan gambar asli
            name: 'Sate Madura Mang Travis Asli California ...',
            price: 'Rp 100.000',
            rating: '0 • 0 terjual',
            visible: false,
          ),
        ],
      ),
    );
  }

  Widget _buildDashboard(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Dashboard',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            const Text(
              'Hari ini',
              style: TextStyle(fontSize: 16),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SellerStatistikToko())
                );
              },
              child: const Text(
                'Lihat Statistik toko >',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildDashboardItem('20', 'Pesanan Baru', '+Rp200 rb'),
            const SizedBox(width: 8),
            _buildDashboardItem('12', 'Siap Dikirim', '+Rp65 rb'),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildDashboardItem('0', 'Dibatalkan', ''),
            const SizedBox(width: 8),
            _buildDashboardItem('0', 'Komplain', ''),
          ],
        ),
      ],
    );
  }

  Widget _buildDashboardItem(String number, String label, String subtitle) {
    return Expanded(
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                number,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 4),
              Text(label),
              if (subtitle.isNotEmpty)
                Text(
                  'Potensi $subtitle',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context,
      {required String image,
      required String name,
      required String price,
      required String rating,
      required bool visible}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        visible ? Icons.visibility : Icons.visibility_off,
                        size: 20,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        rating,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SellerStatistikProduk(
                                  namaProduk: name,
                                  lokasi: "Bandung, Jawa Barat",
                                  deskripsi: visible ? "Sate Madura aseli cuy" : "Mang Travis Jualan Sate cuy!",
                                  harga: price,
                                  gambar: image,
                                  terjual: visible ? 56 : 0,
                                  dilihat: visible ? 34 : 0,
                                  dipesan: visible ? 47 : 0,
                                  rating: visible ? 4.9 : 0.0,
                                  ulasan: visible
                                      ? {5: 1034, 4: 24, 3: 6, 2: 3, 1: 1}
                                      : {5: 0, 4: 0, 3: 0, 2: 0, 1: 0},
                                ),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.grey),
                          ),
                          child: const Text('Statistik'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.grey),
                          ),
                          child: const Text('Edit'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
