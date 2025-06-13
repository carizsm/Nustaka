import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../models/product.dart'; // pastikan nama class-nya sesuai
import 'seller_order.dart';
import 'seller_transaction.dart';
import 'seller_tambah_produk.dart';
import 'seller_statistik_toko.dart';
import 'seller_statistik_produk.dart';
import 'seller_profil.dart';
import 'seller_user_data.dart';
import 'seller_edit_produk.dart';
import 'seller_notification.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF9EB23B),
        elevation: 0,
        title: const Text(
          'Halo, Penjual',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SellerNotificationPage()),
              );
            },
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Order'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Transaction'),
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
                  MaterialPageRoute(builder: (_) => TambahProdukPage()),
                );
              },
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }
}

class SellerHomeContent extends StatefulWidget {
  const SellerHomeContent({super.key});

  @override
  State<SellerHomeContent> createState() => _SellerHomeContentState();
}

class _SellerHomeContentState extends State<SellerHomeContent> {
  List<FullyEnrichedProduct> _products = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final result = await ApiService().getMyProducts();
      setState(() {
        _products = result;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(child: Text(_error!, style: const TextStyle(color: Colors.red)));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDashboard(context),
          const SizedBox(height: 24),
          const Text("Produk", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          if (_products.isEmpty)
            const Text("Belum ada produk.")
          else
            ..._products.map((product) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildProductCard(
                context,
                image: product.imageUrl ?? 'assets/images/placeholder.png',
                name: product.name,
                price: 'Rp ${product.price}',
                rating: '${product.rating} • ${product.totalSold} terjual',
                visible: product.visible ?? true,
              ),
            )),
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
            const Text('Dashboard', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            const Text('Hari ini', style: TextStyle(fontSize: 16)),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SellerStatistikToko()),
                );
              },
              child: const Text('Lihat Statistik toko >', style: TextStyle(color: Colors.green)),
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
              Text(number, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
              const SizedBox(height: 4),
              Text(label),
              if (subtitle.isNotEmpty)
                Text('Potensi $subtitle', style: const TextStyle(fontSize: 12, color: Colors.green)),
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
                    children: [
                      Expanded(
                        child: Text(name,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Icon(
                        visible ? Icons.visibility : Icons.visibility_off,
                        size: 20,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(price, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(rating, style: const TextStyle(fontSize: 12)),
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
                                builder: (_) => SellerStatistikProduk(
                                  namaProduk: name,
                                  lokasi: "Tidak ada data",
                                  deskripsi: "-",
                                  harga: price,
                                  gambar: image,
                                  terjual: 0,
                                  dilihat: 0,
                                  dipesan: 0,
                                  rating: 0,
                                  ulasan: {},
                                ),
                              ),
                            );
                          },
                          child: const Text('Statistik'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditProdukPage(
                                  namaProduk: name,
                                  deskripsi: "-",
                                  detail: "-",
                                  harga: price.replaceAll(RegExp(r'[^0-9]'), ''),
                                  stok: 0,
                                  satuan: "Pcs",
                                  visible: visible,
                                  gambar: image,
                                ),
                              ),
                            );
                          },
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
