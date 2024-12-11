import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Import paket intl
import 'package:aplikasir/screen/kredit/detail_kredit.dart'; // Impor screen DetailKredit

class DaftarKredit extends StatelessWidget {
  final String userId; // Tambahkan userId sebagai parameter

  // Tambahkan konstruktor untuk menerima userId
  const DaftarKredit({super.key, required this.userId});

  final List<Map<String, dynamic>> transaksi = const [
    {
      "tanggal": "08/06/2024",
      "jatuhTempo": "15/06/2024",
      "status": "Belum Lunas",
      "belumDibayar": 5000,
      "totalKredit": 7000,
    },
    {
      "tanggal": "10/06/2024",
      "jatuhTempo": "17/06/2024",
      "status": "Lunas",
      "belumDibayar": 0,
      "totalKredit": 10000,
    },
    {
      "tanggal": "12/06/2024",
      "jatuhTempo": "19/06/2024",
      "status": "Belum Lunas",
      "belumDibayar": 3000,
      "totalKredit": 5000,
    },
    {
      "tanggal": "14/06/2024",
      "jatuhTempo": "21/06/2024",
      "status": "Belum Lunas",
      "belumDibayar": 15000,
      "totalKredit": 20000,
    },
    {
      "tanggal": "16/06/2024",
      "jatuhTempo": "23/06/2024",
      "status": "Lunas",
      "belumDibayar": 0,
      "totalKredit": 12000,
    },
    {
      "tanggal": "18/06/2024",
      "jatuhTempo": "25/06/2024",
      "status": "Belum Lunas",
      "belumDibayar": 5000,
      "totalKredit": 7000,
    },
    {
      "tanggal": "20/06/2024",
      "jatuhTempo": "27/06/2024",
      "status": "Belum Lunas",
      "belumDibayar": 6000,
      "totalKredit": 9000,
    },
    {
      "tanggal": "22/06/2024",
      "jatuhTempo": "29/06/2024",
      "status": "Lunas",
      "belumDibayar": 0,
      "totalKredit": 8000,
    },
    {
      "tanggal": "24/06/2024",
      "jatuhTempo": "01/07/2024",
      "status": "Belum Lunas",
      "belumDibayar": 4000,
      "totalKredit": 6000,
    },
    {
      "tanggal": "26/06/2024",
      "jatuhTempo": "03/07/2024",
      "status": "Lunas",
      "belumDibayar": 0,
      "totalKredit": 11000,
    }
  ];

  int hitungTotalKredit() {
    int totalKredit = 0;
    for (var item in transaksi) {
      if (item["status"] == "Belum Lunas") {
        totalKredit += (item["belumDibayar"] as int);
      }
    }
    return totalKredit;
  }

  int hitungTotalTransaksi() {
    return transaksi.length;
  }

  // Fungsi untuk memformat angka menjadi format Rupiah
  String formatRupiah(int amount) {
    final NumberFormat currencyFormat = NumberFormat.simpleCurrency(locale: 'id_ID', name: 'Rp ', decimalDigits: 0);
    return currencyFormat.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    int totalKredit = hitungTotalKredit();
    int totalTransaksi = hitungTotalTransaksi();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Kredit',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(width: 48),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0, // Menghilangkan bayangan
        scrolledUnderElevation: 0, // Menghilangkan efek elevasi saat di-scroll
      ),
      body: SafeArea( // Menambahkan SafeArea di sini
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nama Pelanggan',
                        style: GoogleFonts.poppins(
                            color: const Color(0xFF8392AA), fontSize: 15),
                      ),
                      Text(
                        'Andi',
                        style: GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.w500),
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
                                color: const Color(0xFF8392AA), fontSize: 15),
                          ),
                          Text(
                            formatRupiah(totalKredit),
                            style: GoogleFonts.poppins(
                                color: totalKredit > 0
                                    ? const Color(0xFFFF4242)
                                    : Colors.green,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Total Transaksi',
                            style: GoogleFonts.poppins(
                                color: const Color(0xFF8392AA), fontSize: 15),
                          ),
                          Text(
                            totalTransaksi.toString(),
                            style: GoogleFonts.poppins(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 29,
              color: const Color(0xFFEAF1FB),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: ListView.builder(
                  itemCount: transaksi.length,
                  itemBuilder: (context, index) {
                    final data = transaksi[index];
                    return _buildTransactionCard(data, context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> data, BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data["tanggal"],
                      style: GoogleFonts.poppins(
                          color: const Color(0xFF286DE1),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Jatuh Tempo',
                      style: GoogleFonts.poppins(color: const Color(0xFF8392AA)),
                    ),
                    Text(
                      data["jatuhTempo"],
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Status',
                      style: GoogleFonts.poppins(color: const Color(0xFF8392AA)),
                    ),
                    Text(
                      data["status"],
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Belum Dibayar',
                      style: GoogleFonts.poppins(color: const Color(0xFF8392AA)),
                    ),
                    Text(
                      data["status"] == "Lunas"
                          ? '' // Kosongkan teks jika status lunas
                          : formatRupiah(data["belumDibayar"]), // Format nominal
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailKredit(
                        userId: userId,
                        transaksi: data,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const Divider(thickness: 1),
      ],
    );
  }
}
