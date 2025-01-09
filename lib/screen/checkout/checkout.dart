import 'package:aplikasir/screen/checkout/checkout_berhasil.dart';
import 'package:flutter/material.dart';
import 'package:aplikasir/api/transaksi_api.dart';
import 'package:aplikasir/models/transaksi_model.dart';
import 'package:aplikasir/models/produk_model.dart';
import 'package:intl/intl.dart'; // Untuk format currency

class Checkout extends StatefulWidget {
  final int userId;
  final List<Map<String, dynamic>> selectedProduk;
  final String paymentMethod; // Menambahkan metode pembayaran

  const Checkout({
    Key? key,
    required this.userId,
    required this.selectedProduk,
    required this.paymentMethod,
  }) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String amount = '0';
  bool isCredit = false;
  late int totalAmount; // Total jumlah yang perlu dibayar

  @override
  void initState() {
    super.initState();
    totalAmount =
        _calculateTotalAmount(); // Menghitung total amount berdasarkan produk yang dipilih
  }

  // Menghitung total harga berdasarkan produk yang dipilih
  int _calculateTotalAmount() {
    int total = 0;
    for (var produkItem in widget.selectedProduk) {
      final produk = produkItem['produk'] as ProdukModel;
      final quantity = produkItem['jumlah'] as int;
      total += (produk.hargaJual * quantity).toInt(); // Cast to int
    }
    return total;
  }

  // Format mata uang untuk menampilkan harga
  String formatCurrency(int amount) {
    final format =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return format.format(amount);
  }

  void onNumberPressed(String value) {
    setState(() {
      if (amount == '0') {
        amount = value;
      } else {
        amount += value;
      }
    });
  }

  void onClearPressed() {
    setState(() {
      amount = '0';
    });
  }

  void onBackspacePressed() {
    setState(() {
      if (amount.isNotEmpty) {
        amount = amount.substring(0, amount.length - 1);
        if (amount.isEmpty) {
          amount = '0';
        }
      }
    });
  }

  // Check if entered amount matches total
  bool isAmountMatching() {
    try {
      final enteredAmount = int.parse(amount.replaceAll('.', ''));
      return enteredAmount >= totalAmount;
    } catch (e) {
      return false;
    }
  }

  void navigateToSuccess() async {
    // Menyusun transaksi baru berdasarkan produk yang dipilih
    final transaksiBaru = TransaksiModel(
      id: 0, // Temporary ID, harus diganti dengan ID yang dibuat oleh API jika ada
      idPengguna: widget.userId,
      metodePembayaran: widget.paymentMethod,
      jenisTransaksi: isCredit ? "kredit" : "pembayaran",
      details: widget.selectedProduk.map((produkItem) {
        final produk = produkItem['produk'] as ProdukModel;
        final quantity = produkItem['jumlah'] as int;

        // Menyusun format 'details' yang sesuai dengan model
        return {
          'id_produk': produk.id, // ID produk
          'nama_produk': produk.namaProduk, // Nama produk
          'harga_satuan': produk.hargaJual.toString(), // Harga produk
          'kuantitas': quantity, // Jumlah produk
          'subtotal':
              (produk.hargaJual * quantity).toString(), // Subtotal per produk
        };
      }).toList(),
    );

    // Kirim transaksi ke server
    final transaksiApi = TransaksiApi();
    bool success = await transaksiApi.tambahTransaksi(transaksiBaru);

    if (success) {
      final totalKembalian =
          (int.parse(amount.replaceAll('.', '')) - totalAmount).toDouble();

      // Navigasi ke halaman sukses
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckoutTransaksiBerhasil(
            userId: widget.userId,
            totalKembalian: totalKembalian,
            idTransaksi: transaksiBaru
                .id, // Placeholder, ganti dengan ID aktual dari backend
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menambahkan transaksi')),
      );
    }
  }

  Widget buildKeyButton(String label, {VoidCallback? onPressed}) {
    return Expanded(
      child: TextButton(
        onPressed: onPressed ?? () => onNumberPressed(label),
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          padding: EdgeInsets.zero,
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 40,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool showConfirmButton = isAmountMatching();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  Spacer(),
                  Center(
                    child: Text(
                      'Transaksi',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),

              const SizedBox(height: 20),

              // Total Amount
              Center(
                child: Text(
                  'Total Harga: ${formatCurrency(totalAmount)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 8),
              Text(
                'Rp ${amount == '0' ? '0' : amount.replaceAllMapped(
                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                    (Match m) => '${m[1]}.',
                  )}',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 10),

              // Credit Checkbox
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F1FF),
                  borderRadius: BorderRadius.circular(0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Row(
                  children: [
                    Checkbox(
                      value: isCredit,
                      onChanged: (bool? value) {
                        setState(() {
                          isCredit = value ?? false;
                        });
                      },
                    ),
                    Text("Kredit"),
                  ],
                ),
              ),

              // Keypad
              Expanded(
                child: Column(
                  children: [
                    // Row 1: 7 8 9 C
                    Expanded(
                      child: Row(
                        children: [
                          buildKeyButton('7'),
                          buildKeyButton('8'),
                          buildKeyButton('9'),
                          buildKeyButton('C', onPressed: onClearPressed),
                        ],
                      ),
                    ),
                    // Row 2: 4 5 6 ⌫
                    Expanded(
                      child: Row(
                        children: [
                          buildKeyButton('4'),
                          buildKeyButton('5'),
                          buildKeyButton('6'),
                          buildKeyButton('⌫', onPressed: onBackspacePressed),
                        ],
                      ),
                    ),
                    // Row 3: 1 2 3 ✓
                    Expanded(
                      child: Row(
                        children: [
                          buildKeyButton('1'),
                          buildKeyButton('2'),
                          buildKeyButton('3'),
                          if (showConfirmButton)
                            Expanded(
                              child: TextButton(
                                onPressed: navigateToSuccess,
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  padding: EdgeInsets.zero,
                                ),
                                child: Image.asset(
                                  'assets/icons/Check.png',
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                            )
                          else
                            const Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
                    // Row 4: 0 000 .
                    Expanded(
                      child: Row(
                        children: [
                          buildKeyButton('0'),
                          buildKeyButton('000'),
                          buildKeyButton('.'),
                          const Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
