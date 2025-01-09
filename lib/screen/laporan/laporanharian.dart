import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:aplikasir/api/laporan_api.dart';
import 'package:aplikasir/models/laporan_model.dart';

class LaporanHarian extends StatefulWidget {
  final int userId;
  const LaporanHarian({super.key, required this.userId});

  @override
  State<LaporanHarian> createState() => _LaporanHarianState();
}

class _LaporanHarianState extends State<LaporanHarian> {
  int _selectedIndex = 0;
  final List<String> _tabTitles = ["Transaksi", "Laba Rugi", "Pendapatan"];
  late Future<List<LaporanModel>> laporans;

  @override
  void initState() {
    super.initState();
    laporans = fetchUserLaporan(
        widget.userId); // Panggil fungsi fetch data berdasarkan userId
  }

  Future<List<LaporanModel>> fetchUserLaporan(int userId) async {
    final allLaporan = await LaporanApi.getLaporan();
    return allLaporan
        .where((item) => item.idPengguna.toString() == userId)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Transaksi Tiap Jam',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: List.generate(
                  _tabTitles.length,
                  (index) => Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 3),
                        decoration: BoxDecoration(
                          color: _selectedIndex == index
                              ? Colors.blue
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Text(
                          _tabTitles[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _selectedIndex == index
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Transform.translate(
                offset: Offset(0, -10),
                child: Image.asset(
                  'assets/images/grafiklaporanharian.jpg',
                  height: 190,
                  width: 300,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 134,
                  height: 29,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle download report
                    },
                    child: Text(
                      "Unduh Laporan",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Colors.black, width: 1.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Color.fromARGB(255, 212, 209, 209),
            thickness: 20,
          ),
          Expanded(
            child: FutureBuilder<List<LaporanModel>>(
              future: laporans,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Gagal memuat data: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Data tidak tersedia'));
                } else {
                  final List<LaporanModel> laporan = snapshot.data!;

                  return ListView.separated(
                    itemCount: laporan.length,
                    separatorBuilder: (_, __) => Divider(color: Colors.grey),
                    itemBuilder: (context, index) {
                      final item = laporan[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ID: ${item.id}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Total Penjualan',
                                      style: TextStyle(color: Colors.grey)),
                                  Text(
                                    NumberFormat.currency(
                                      locale: 'id_ID',
                                      symbol: 'Rp ',
                                      decimalDigits: 2,
                                    ).format(item.totalPenjualan),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text('Total Transaksi',
                                      style: TextStyle(color: Colors.grey)),
                                  Text(
                                    '${item.totalTransaksi} transaksi',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
