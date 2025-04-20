import 'package:flutter/material.dart';

class SellerTransactionPage extends StatelessWidget {
  const SellerTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Riwayat Transaksi",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8B0000),
            ),
          ),
          const SizedBox(height: 20),
          
          // Completed Orders
          const Text(
            "Pesanan Selesai",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          
          _buildTransactionItem(
            "INV/20250204/XXX/34512389814",
            "Michelle",
            "Sate Madura",
            "2pcs",
            "Reguler - GoJek",
            "Palembang",
            "12 Sep, 16:45",
          ),
          _buildTransactionItem(
            "INV/20250204/XXX/34567890631",
            "Jordan Bernando",
            "Sate Madura",
            "2pcs",
            "Reguler - GoJek",
            "Serang",
            "12 Sep, 16:45",
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(
    String invoice,
    String customer,
    String product,
    String quantity,
    String shipping,
    String address,
    String arrival,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              invoice,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              customer,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            
            Text(
              product,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            Text("Jumlah Pembelian : $quantity"),
            const SizedBox(height: 8),
            
            Row(
              children: [
                const Icon(Icons.push_pin, size: 16),
                const SizedBox(width: 4),
                Text(shipping),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16),
                const SizedBox(width: 4),
                Text(address),
              ],
            ),
            const SizedBox(height: 12),
            
            const Divider(),
            const SizedBox(height: 8),
            
            Text(
              "Tiba pada",
              style: TextStyle(color: Colors.grey[600]),
            ),
            Text(
              arrival,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}