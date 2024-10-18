import 'package:flutter/material.dart';

class Menulaporan extends StatefulWidget {
  const Menulaporan({super.key});

  @override
  State<Menulaporan> createState() => _MenulaporanState();
}

class _MenulaporanState extends State<Menulaporan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 22,
          ),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: Text(
          'Laporan Transaksi',
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20), 
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Image.asset(
                      'assets/icons/iconmenulaporan.jpg',
                      width: 50,
                      height: 50,
                  ),
                  title: Text('Laporan Transaksi Hari Ini'),
                  onTap: () {
                    // untuk nanti muah
                  },
                ),
                Divider(color: Colors.grey.shade300),
                ListTile(
                  leading: Image.asset(
                      'assets/icons/iconmenulaporan.jpg',
                      width: 50,
                      height: 50,
                  ),
                  title: Text('Laporan Transaksi Bulan Ini'),
                  onTap: () {
                    // untuk nanti muah
                  },
                ),
                Divider(color: Colors.grey.shade300),
                ListTile(
                  leading: Image.asset(
                      'assets/icons/iconmenulaporan.jpg',
                      width: 50,
                      height: 50,
                  ),
                  title: Text('Laporan Transaksi Tahun Ini'),
                  onTap: () {
                    // untuk nanti muah
                  },
                ),
                Divider(color: Colors.grey.shade300),
                ListTile(
                  leading: Image.asset(
                      'assets/icons/iconmenulaporan.jpg',
                      width: 50,
                      height: 50,
                  ),
                  title: Text('Semua Laporan Transaksi'),
                  onTap: () {
                    // untuk nanti muah
                  },
                ),
                Divider(color: Colors.grey.shade300),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
