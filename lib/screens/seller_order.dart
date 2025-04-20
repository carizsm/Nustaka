import 'package:flutter/material.dart';

class SellerOrderPage extends StatelessWidget {
  const SellerOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Daftar Order",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8B0000),
            ),
          ),
          const SizedBox(height: 20),
          
          // Order Status Summary
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildOrderStatus("5", "Semua Pesanan"),
              _buildOrderStatus("1", "Menunggu Pembayaran"),
              _buildOrderStatus("1", "Siap Dikirim"),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildOrderStatus("2", "Dalam Perjalanan"),
              _buildOrderStatus("0", "Dibatalkan"),
            ],
          ),
          const SizedBox(height: 20),
          
          const Divider(),
          const SizedBox(height: 10),
          
          // All Orders Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Semua Order",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButton<String>(
                value: "Semua",
                items: const [DropdownMenuItem(value: "Semua", child: Text("Semua ▼"))],
                onChanged: (value) {},
              ),
            ],
          ),
          const SizedBox(height: 10),
          
          // Order List
          _buildOrderItem(
            "INV/20250204/XXX/3456789812",
            "Eldwin Fikhar Ananda",
            "13 Sep, 14:55",
            "Pesanan Diproses",
            "Sate Madura",
            "2pcs",
            ["Reguler - Golek", "Tangerang"],
          ),
          _buildOrderItem(
            "INV/20250204/XXX/3459719811",
            "Azriel",
            "12 Sep, 12:32",
            "Menunggu Pembayaran",
            "Sate Madura",
            "1pcs",
            ["Reguler - Golek", "Bandung"],
          ),
          _buildOrderItem(
            "INV/20250204/XXX/3459719811",
            "Leonardy",
            "10 Sep, 09:00",
            "Dalam Perjalanan",
            "Sate Madura",
            "1pcs",
            ["Reguler - Golek", "Ciamis"],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderStatus(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildOrderItem(
    String invoice,
    String customer,
    String deadline,
    String status,
    String product,
    String quantity,
    List<String> details,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  invoice,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  status,
                  style: TextStyle(
                    color: _getStatusColor(status),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(customer),
            const SizedBox(height: 8),
            
            Text(
              "Batas Respons",
              style: TextStyle(color: Colors.grey[600]),
            ),
            Text(
              deadline,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            
            const Divider(),
            const SizedBox(height: 8),
            
            Text(
              product,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("Jumlah Pembelian : $quantity"),
            const SizedBox(height: 8),
            
            for (var detail in details)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    if (detail == details.first)
                      const Icon(Icons.check_box_outline_blank, size: 18)
                    else
                      const Icon(Icons.check_box, size: 18),
                    const SizedBox(width: 8),
                    Text(detail),
                  ],
                ),
              ),
            const SizedBox(height: 12),
            
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD9A25F),
                ),
                child: const Text("Konfirmasi Resi"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pesanan Diproses":
        return Colors.orange;
      case "Menunggu Pembayaran":
        return Colors.blue;
      case "Dalam Perjalanan":
        return Colors.green;
      default:
        return Colors.black;
    }
  }
}