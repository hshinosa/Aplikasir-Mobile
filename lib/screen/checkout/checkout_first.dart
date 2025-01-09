import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:aplikasir/models/produk_model.dart'; // Ensure this import is present
import 'package:aplikasir/screen/checkout/checkout.dart'; // Adjust if needed
import 'package:aplikasir/api/produk_api.dart'; // Import ProdukApi

class CheckoutFirst extends StatefulWidget {
  final int userId;
  final List<Map<String, dynamic>> selectedProduk;

  const CheckoutFirst({
    Key? key,
    required this.userId,
    required this.selectedProduk,
  }) : super(key: key);

  @override
  State<CheckoutFirst> createState() => _CheckoutFirstState();
}

class _CheckoutFirstState extends State<CheckoutFirst> {
  late ProdukApi produkApi;
  String? selectedPaymentMethod; // Track the selected payment method

  @override
  void initState() {
    super.initState();
    produkApi = ProdukApi(); // Initialize ProdukApi
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Transaksi',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Rincian Produk',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: widget.selectedProduk.map<Widget>((produkItem) {
                    final produk = produkItem['produk'] as ProdukModel;
                    final quantity = produkItem['jumlah'] as int;

                    return FutureBuilder<ProdukModel>(
                      future: produkApi.fetchProdukById(produk.id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // Show loading while fetching data
                        }

                        if (snapshot.hasError) {
                          return Text(
                              'Error: ${snapshot.error}'); // Handle error
                        }

                        final produkData = snapshot.data;

                        if (produkData == null) {
                          return const Text(
                              'Produk tidak ditemukan'); // Handle case where product is null
                        }

                        return Column(
                          children: [
                            _buildProductItem(
                              image: produkData.gambarProduk ??
                                  'https://via.placeholder.com/150',
                              name: produkData.namaProduk,
                              quantity: '$quantity x',
                              price: (produkData.hargaJual * quantity).toInt(),
                            ),
                            const SizedBox(height: 16),
                          ],
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              const Divider(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    formatCurrency(_calculateTotalPrice()),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Metode Pembayaran',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    'Metode Transaksi',
                    style: TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'CASH',
                        groupValue: selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            selectedPaymentMethod = value;
                          });
                        },
                      ),
                      const Text('CASH'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'QRIS',
                        groupValue: selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            selectedPaymentMethod = value;
                          });
                        },
                      ),
                      const Text('QRIS'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 150),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Check if a payment method has been selected
                    if (selectedPaymentMethod == null) {
                      // Show a SnackBar if no payment method is selected
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Silahkan pilih metode pembayaran terlebih dahulu!'),
                        ),
                      );
                    } else {
                      // If a payment method is selected, navigate to the Checkout screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Checkout(
                            userId: widget.userId,
                            selectedProduk: widget.selectedProduk,
                            paymentMethod: selectedPaymentMethod!,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Konfirmasi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Builds the product item row (with image, name, quantity, price)
  Widget _buildProductItem({
    required String image,
    required String name,
    required String quantity,
    required int price,
  }) {
    return Row(
      children: [
        Image.network(
          image,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                quantity,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Text(
          formatCurrency(price),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Calculate total price dynamically based on selected products and quantities
  int _calculateTotalPrice() {
    int total = 0;
    for (var produkItem in widget.selectedProduk) {
      final produk = produkItem['produk'] as ProdukModel;
      final quantity = produkItem['jumlah'] as int;
      total += (produk.hargaJual * quantity).toInt();
    }
    return total;
  }

  // Format currency as IDR
  String formatCurrency(int amount) {
    final format =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return format.format(amount);
  }
}
