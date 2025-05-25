import 'package:flutter/material.dart';
import 'seller_homepage.dart';

final Color primaryGreen = Color(0xFF86A340);
final Color secondaryYellow = Color(0xFFECF284);

void main() {
  runApp(MaterialApp(
    home: TambahProdukPage(),
  ));
}

class TambahProdukPage extends StatefulWidget {
  @override
  _TambahProdukPageState createState() => _TambahProdukPageState();
}

class _TambahProdukPageState extends State<TambahProdukPage> {
  bool _visibilityActive = true;
  String _selectedSatuan = 'Pcs';
  String _selectedCurrency = 'Rp';
  TextEditingController _hargaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isHargaEmpty = _hargaController.text.isEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Tambah Produk', style: TextStyle(color: secondaryYellow)),
        backgroundColor: primaryGreen,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: secondaryYellow),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SellerHomepage()),
            );
          },
        ),
        actions: [
          Icon(Icons.search, color: secondaryYellow),
          SizedBox(width: 16),
          Icon(Icons.notifications, color: secondaryYellow),
          SizedBox(width: 16),
          Icon(Icons.account_circle, color: secondaryYellow),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Yuk, isi informasi produkmu', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),

            // Nama Produk
            Text('Nama Produk'),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Ketikkan nama produk kamu disini',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Foto Produk
            Text('Foto Produk'),
            SizedBox(height: 8),
            Container(
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Center(
                child: Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
              ),
            ),
            SizedBox(height: 16),

            // Detail Produk
            Text('Detail Produk'),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Ketikkan detail produk kamu disini',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Deskripsi Produk
            Text('Deskripsi Produk'),
            SizedBox(height: 8),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Ketikkan deskripsi produk kamu disini',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Stok Produk
            Text('Stok Produk'),
            SizedBox(height: 8),
            Row(
              children: [
                DropdownButton<String>(
                  value: _selectedSatuan,
                  items: ['Pcs', 'Kg', 'Ltr'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  selectedItemBuilder: (BuildContext context) {
                    return ['Pcs', 'Kg', 'Ltr'].map((String value) {
                      return Text(
                        value,
                        style: TextStyle(
                          color: primaryGreen, // warna hijau untuk teks yang dipilih
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }).toList();
                  },
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedSatuan = newValue!;
                    });
                  },
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Masukkan jumlah stok produk kamu disini',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Harga Produk
            Text('Harga Produk'),
            SizedBox(height: 8),
            Row(
              children: [
                DropdownButton<String>(
                  value: _selectedCurrency,
                  items: ['Rp', '\$'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  selectedItemBuilder: (BuildContext context) {
                    return ['Rp', '\$'].map((String value) {
                      return Text(
                        value,
                        style: TextStyle(
                          color: primaryGreen, // warna hijau untuk teks yang dipilih
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }).toList();
                  },
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCurrency = newValue!;
                    });
                  },
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _hargaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Atur harga produkmu disini',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (text) {
                      setState(() {}); // supaya "kompetitif" update
                    },
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isHargaEmpty ? Colors.red[100] : Colors.green[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    isHargaEmpty ? 'Belum Kompetitif' : 'Sudah Kompetitif',
                    style: TextStyle(
                      color: isHargaEmpty ? Colors.red[800] : Colors.green[800],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text('Kisaran harga kompetitif : Rp 11.500 - 13.500', style: TextStyle(color: Colors.grey[600])),
            SizedBox(height: 16),

            // Visibilitas Produk
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Visibilitas Produk', style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('Jika aktif, produkmu dapat dicari oleh calon pembeli.', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Switch(
                    value: _visibilityActive,
                    onChanged: (bool value) {
                      setState(() {
                        _visibilityActive = value;
                      });
                    },
                    activeColor: primaryGreen,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Tombol Upload
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    foregroundColor: secondaryYellow,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: Text('Upload Produk'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
