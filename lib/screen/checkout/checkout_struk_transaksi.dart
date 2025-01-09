import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:aplikasir/models/transaksi_model.dart';
import 'package:aplikasir/api/transaksi_api.dart';

class CheckoutStrukTransaksi extends StatefulWidget {
  final int userId; // Mengambil ID pengguna untuk transaksi terakhir
  const CheckoutStrukTransaksi({required this.userId, Key? key})
      : super(key: key);

  @override
  _CheckoutStrukTransaksiState createState() => _CheckoutStrukTransaksiState();
}

class _CheckoutStrukTransaksiState extends State<CheckoutStrukTransaksi> {
  late Future<List<TransaksiModel>> allTransactions;

  @override
  void initState() {
    super.initState();
    allTransactions = TransaksiApi().fetchTransaksi(); // Fetch all transactions
  }

  // Fungsi untuk format mata uang
  String formatCurrency(int amount) {
    final format =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return format.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Struk",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<TransaksiModel>>(
        future: allTransactions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            final transactions = snapshot.data!;

            // Filter transaksi pengguna dan ambil transaksi terakhir
            final userTransactions = transactions
                .where((transaction) => transaction.idPengguna == widget.userId)
                .toList()
              ..sort((a, b) => b.id.compareTo(a.id));

            if (userTransactions.isEmpty) {
              return const Center(child: Text("Tidak ada transaksi terakhir"));
            }

            final transaction = userTransactions.first; // Transaksi terbaru
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 8.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "ANUGRAH JAYA",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Jalan pasar baru raya timur",
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(),
                        Text(
                          "Metode : ${transaction.metodePembayaran}",
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Jenis Transaksi : ${transaction.jenisTransaksi}",
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        const Divider(),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: transaction.details.length,
                          itemBuilder: (context, index) {
                            final item = transaction.details[index];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['nama_produk'] ?? 'Unknown',
                                      style: GoogleFonts.poppins(fontSize: 14),
                                    ),
                                    Text(
                                      "${item['kuantitas'] ?? 0} × ${formatCurrency(double.tryParse(item['harga_satuan']?.toString() ?? '')?.toInt() ?? 0)}",
                                      style: GoogleFonts.poppins(fontSize: 14),
                                    ),
                                  ],
                                ),
                                Text(
                                  formatCurrency(
                                      (item['subtotal'] as num?)?.toInt() ?? 0),
                                  style: GoogleFonts.poppins(fontSize: 14),
                                ),
                              ],
                            );
                          },
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              formatCurrency(transaction.details
                                  .map((e) => e['subtotal'] as int)
                                  .reduce((a, b) => a + b)),
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Image.asset(
                            'assets/images/logoaplikasir.jpg', // Ganti dengan path logo Anda
                            width: 180,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("Tidak ada transaksi terakhir"));
          }
        },
      ),
    );
  }
}
