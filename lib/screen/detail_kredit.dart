import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DetailKredit extends StatelessWidget {
  final Map<String, dynamic> transaksi;

  const DetailKredit({super.key, required this.transaksi});

  String formatRupiah(int amount) {
    final NumberFormat currencyFormat = NumberFormat.simpleCurrency(locale: 'id_ID', name: 'Rp ', decimalDigits: 0);
    return currencyFormat.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const BackButton(),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Kredit',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 48),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Pelanggan',
              style: GoogleFonts.poppins(
                color: const Color(0xFF8392AA),
                fontSize: 15,
              ),
            ),
            Text(
              'Andi',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Divider(
              height: 30,
              thickness: 1,
              color: Color(0x99C6C8CB),
            ),
            Text(
              transaksi["status"],
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tanggal Kredit',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF8392AA),
                          ),
                        ),
                        Text(
                          transaksi["tanggal"],
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Jatuh Tempo',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF8392AA),
                          ),
                        ),
                        Text(
                          transaksi["jatuhTempo"],
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Kredit',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF8392AA),
                          ),
                        ),
                        Text(
                          formatRupiah(transaksi["totalKredit"]), // Konversi ke String
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.red
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Belum Dibayar',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF8392AA),
                          ),
                        ),
                        Text(
                          transaksi["status"] == "Lunas"
                              ? '' // Kosongkan jika status lunas
                              : formatRupiah(transaksi["belumDibayar"]), // Konversi ke String
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50), // Full width button
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            backgroundColor: transaksi["status"] == "Lunas" ? Colors.grey : Colors.blue, // Mengubah warna tombol
          ),
          onPressed: () {
            if (transaksi["status"] == "Lunas") {
              // Tampilkan snackbar jika kredit sudah lunas
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Kredit sudah lunas'),
                  duration: const Duration(seconds: 2),
                ),
              );
            } else {
              // Lakukan pembayaran kredit
              // Logika pembayaran di sini
            }
          },
          child: Text(
            'Pembayaran Kredit',
            style: GoogleFonts.poppins(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
