import 'package:flutter/material.dart';
import 'package:aplikasir/api/laporan_api.dart';
import 'package:aplikasir/models/laporan_model.dart';

class ReportPage extends StatefulWidget {
  final int userId; // Tambahkan userId untuk filter data

  const ReportPage({super.key, required this.userId});

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final List<String> items = ['Hari ini', 'Kemarin', 'Minggu lalu'];
  String? selectedItem;
  List<bool> isSelected = [true, false, false];

  Future<Map<String, dynamic>> fetchSummaryData(int userId) async {
    try {
      final laporan = await LaporanApi.getLaporan();
      // Filter data berdasarkan userId
      final userLaporan = laporan
          .where((item) => item.idPengguna.toString() == userId)
          .toList();

      // Hitung jumlah transaksi dan pendapatan
      int totalTransaksi =
          userLaporan.fold(0, (sum, item) => sum + item.totalTransaksi);
      double totalPendapatan =
          userLaporan.fold(0.0, (sum, item) => sum + item.totalPenjualan);

      return {
        'totalTransaksi': totalTransaksi,
        'totalPendapatan': totalPendapatan,
      };
    } catch (e) {
      print('Error fetching summary data: $e');
      return {
        'totalTransaksi': 0,
        'totalPendapatan': 0.0,
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Laporan',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  _buildDropdownAndDownload(),
                  SizedBox(height: 35),
                  FutureBuilder<Map<String, dynamic>>(
                    future: fetchSummaryData(widget.userId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return _buildSummaryRow('Jumlah Transaksi',
                            'Loading...', Icons.trending_up);
                      } else if (snapshot.hasError) {
                        return _buildSummaryRow(
                            'Jumlah Transaksi', 'Error', Icons.error);
                      } else if (snapshot.hasData) {
                        final data = snapshot.data!;
                        return Column(
                          children: [
                            _buildSummaryRow(
                              'Jumlah Transaksi',
                              data['totalTransaksi'].toString(),
                              Icons.trending_up,
                            ),
                            SizedBox(height: 18),
                            _buildSummaryRow(
                              'Pendapatan',
                              'Rp ${data['totalPendapatan'].toStringAsFixed(2)}',
                              Icons.trending_up,
                            ),
                          ],
                        );
                      } else {
                        return _buildSummaryRow(
                            'Jumlah Transaksi', 'No data', Icons.info);
                      }
                    },
                  ),
                  SizedBox(height: 30),
                  Text('Laporan Transaksi',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 10),
                  _buildToggleButtons(),
                  SizedBox(height: 30),
                  _buildDivider(),
                  SizedBox(height: 20),
                  Text('Penjualan Teratas',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 20),
                  _buildTopSalesList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownAndDownload() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDropdown(),
        SizedBox(width: 16),
        _buildButton('Unduh Laporan'),
      ],
    );
  }

  Widget _buildDropdown() {
    return Container(
      height: 33,
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 9.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_month),
          SizedBox(width: 8),
          DropdownButton<String>(
            hint: Text('Hari Ini'),
            value: selectedItem,
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (value) {
              setState(() => selectedItem = value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    return Container(
      height: 33,
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: TextStyle(fontSize: 16)),
    );
  }

  Widget _buildSummaryRow(String title, String value, IconData icon) {
    return Container(
      width: 329,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFDADADA), width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF286DE1), width: 2),
              borderRadius: BorderRadius.circular(8),
              color: Color(0xFF286DE1),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              Text(title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildToggleButtons() {
    return ToggleButtons(
      borderRadius: BorderRadius.circular(20),
      borderColor: Colors.grey,
      selectedBorderColor: Colors.grey,
      fillColor: Color(0xFF286DE1),
      selectedColor: Colors.white,
      color: Colors.black,
      isSelected: isSelected,
      onPressed: (index) {
        setState(() {
          for (int i = 0; i < isSelected.length; i++) {
            isSelected[i] = i == index;
          }
        });
      },
      children: const [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text('Transaksi')),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text('Laba Rugi')),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text('Pendapatan')),
      ],
    );
  }

  Widget _buildDivider() {
    return Column(
      children: [
        Container(
          width: 320,
          height: 2,
          color: Colors.black,
        ),
        SizedBox(height: 2),
        Container(
          width: 2,
          height: 200,
          color: Colors.black,
        ),
      ],
    );
  }

  Widget _buildTopSalesList() {
    final products = [
      {
        'name': 'Sendal',
        'price': 'Rp.12.000',
        'sales': '10',
        'percentage': '0,2%'
      },
      {
        'name': 'Garam 1kg',
        'price': 'Rp.5.000',
        'sales': '10',
        'percentage': '0,2%'
      },
    ];

    return Container(
      width: 330,
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffDADADA)),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        children: [
          _buildTopSalesHeader(),
          ...products.map((product) => _buildTopSalesItem(product)).toList(),
        ],
      ),
    );
  }

  Widget _buildTopSalesHeader() {
    return Container(
      width: 330,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffDADADA), width: 1),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text('Produk', style: TextStyle(fontSize: 14)),
          Text('Penjualan', style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildTopSalesItem(Map<String, String> product) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset('assets/items/sendal.png', width: 50),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product['name']!, style: TextStyle(fontSize: 14)),
                  Text(product['price']!,
                      style: TextStyle(fontSize: 14, color: Color(0xff286DE1))),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Text(product['sales']!, style: TextStyle(fontSize: 14)),
              Text(product['percentage']!,
                  style: TextStyle(fontSize: 14, color: Color(0xff219469))),
            ],
          ),
        ],
      ),
    );
  }
}
