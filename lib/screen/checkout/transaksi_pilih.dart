import 'package:aplikasir/screen/checkout/checkout_first.dart';
import 'package:flutter/material.dart';
import 'package:aplikasir/models/produk_model.dart';
import 'package:aplikasir/api/produk_api.dart';
import 'package:intl/intl.dart';

class TransaksiScreen extends StatefulWidget {
  final int userId;

  const TransaksiScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _TransaksiScreenState createState() => _TransaksiScreenState();
}

class _TransaksiScreenState extends State<TransaksiScreen> {
  final ProdukApi produkApi = ProdukApi();
  final Map<int, int> selectedProducts =
      {}; // Key: Produk ID, Value: Jumlah Dipilih
  List<ProdukModel> produkList = [];
  List<ProdukModel> filteredProdukList = [];
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Transaksi',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                  _filterProduk();
                });
              },
              decoration: InputDecoration(
                hintText: 'Cari nama produk',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<ProdukModel>>(
              future: produkApi.fetchProduk(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('Tidak ada produk yang tersedia.'));
                }

                produkList = snapshot.data!;
                _filterProduk();

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredProdukList.length,
                  itemBuilder: (context, index) {
                    final produk = filteredProdukList[index];
                    return _buildProductCard(context, produk);
                  },
                );
              },
            ),
          ),
          InkWell(
            onTap: () {
              // Check if there are selected products
              if (_getTotalProducts() == 0) {
                // Show Snackbar if no product is selected
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Silakan pilih produk terlebih dahulu.'),
                    backgroundColor: Colors.red,
                  ),
                );
              } else {
                // Proceed to checkout if there are selected products
                final selectedProdukList =
                    selectedProducts.entries.map((entry) {
                  final produk =
                      produkList.firstWhere((p) => p.id == entry.key);
                  return {
                    'produk': produk,
                    'jumlah': entry.value,
                  };
                }).toList();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutFirst(
                      userId: widget.userId,
                      selectedProduk: selectedProdukList, // Corrected variable
                    ),
                  ),
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Jumlah',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        '${_getTotalProducts()} Produk',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Rp ${_getTotalPrice()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.chevron_right,
                        color: Colors.white,
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

  Widget _buildProductCard(BuildContext context, ProdukModel produk) {
    return StatefulBuilder(
      builder: (context, setState) {
        final jumlahDipilih = selectedProducts[produk.id] ?? 0;

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                produk.gambarProduk ?? 'https://via.placeholder.com/150',
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 8),
              Text(
                produk.namaProduk,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                'Harga : ${formatCurrency(produk.hargaJual.toInt())}',
                style: const TextStyle(
                  color: Color.fromRGBO(40, 109, 225, 1),
                  fontSize: 10,
                ),
              ),
              Text(
                'Stok : ${produk.jumlahProduk}',
                style: const TextStyle(
                  color: Color.fromRGBO(40, 109, 225, 1),
                  fontSize: 10,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      if (jumlahDipilih > 0) {
                        setState(() {
                          selectedProducts[produk.id] = jumlahDipilih - 1;
                        });
                        _updateState();
                      }
                    },
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  Text(
                    '$jumlahDipilih',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (jumlahDipilih < produk.jumlahProduk) {
                        setState(() {
                          selectedProducts[produk.id] = jumlahDipilih + 1;
                        });
                        _updateState();
                      }
                    },
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _filterProduk() {
    filteredProdukList = produkList
        .where((produk) =>
            produk.namaProduk.toLowerCase().contains(searchQuery) ||
            produk.kodeProduk.toLowerCase().contains(searchQuery))
        .toList();
  }

  int _getTotalProducts() {
    return selectedProducts.values.fold(0, (sum, item) => sum + item);
  }

  double _getTotalPrice() {
    return selectedProducts.entries.fold(
      0.0,
      (sum, entry) {
        final produk = produkList.firstWhere((p) => p.id == entry.key);
        return sum + (produk.hargaJual * entry.value);
      },
    );
  }

  void _updateState() {
    setState(() {});
  }

  String formatCurrency(int amount) {
    final format =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return format.format(amount);
  }
}
