import 'package:flutter/material.dart';
import 'seller_order.dart';
import 'seller_transaction.dart';

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
      backgroundColor: const Color(0xFFF4F898),
      appBar: AppBar(
        title: const Text('Halo, Mang Travis'),
        backgroundColor: const Color(0xFFF4F898),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
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
            icon: Icon(Icons.list_alt),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Transaction',
          ),
        ],
        selectedItemColor: const Color(0xFF8B0000),
        unselectedItemColor: Colors.grey,
      ),
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
          // Dashboard Section
          const Text(
            "Dashboard",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: _buildDashboardCard(
                  "Hari ini",
                  "20",
                  "Potensi +Rp200 rb",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDashboardCard(
                  "Lihat Statistik toko >",
                  "",
                  "",
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          Row(
            children: [
              Expanded(
                child: _buildDashboardCard(
                  "12",
                  "Pesanan Baru",
                  "Siap Dikirim",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDashboardCard(
                  "0",
                  "Dibatalkan",
                  "Komplain",
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Products Section
          const Text(
            "Produk",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildProductCard(
            "Sate Madura",
            "Rp 100.000",
            "4.8 • 100+ terjual",
          ),
          const SizedBox(height: 8),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Statistik"),
              TextButton(
                onPressed: () {},
                child: const Text("Edit"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          _buildProductCard(
            "Sate Madura Mang Travis Asli California ...",
            "Rp 100.000",
            "4.8 • 100+ terjual",
          ),
          const SizedBox(height: 8),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Statistik"),
              TextButton(
                onPressed: () {},
                child: const Text("Edit"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(String title, String value, String subtitle) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14),
            ),
            if (value.isNotEmpty)
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (subtitle.isNotEmpty)
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(String name, String price, String stats) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.fastfood, size: 30),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(price),
                  Text(stats),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}