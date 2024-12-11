import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LaporanHarian(),
    );
  }
}

class LaporanHarian extends StatefulWidget {
  const LaporanHarian({Key? key}) : super(key: key);

  @override
  State<LaporanHarian> createState() => _LaporanHarianState();
}

class _LaporanHarianState extends State<LaporanHarian> {
  int _selectedIndex = 0;
  final List<String> _tabTitles = ["Transaksi", "Laba Rugi", "Pendapatan"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Handle back button press
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
          SingleChildScrollView(
            child: Column(
              children: [
                _buildTransactionTile("12:48:12", "06 Jun 2024", 10000, 10000),
                const Divider(color: Colors.grey),
                _buildTransactionTile("12:24:12", "06 Jun 2024", 10000, 10000),
                const Divider(color: Colors.grey),
                _buildTransactionTile("12:12:12", "06 Jun 2024", 10000, 10000),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionTile(
      String time, String date, int revenue, int profit) {
    final currencyFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(time,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(date, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Pendapatan',
                          style: TextStyle(color: Colors.grey)),
                      Text(currencyFormat.format(revenue),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      const Text('Laba Rugi',
                          style: TextStyle(color: Colors.grey)),
                      Text(currencyFormat.format(profit),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.delete, color: Colors.red),
              SizedBox(height: 16),
              Icon(Icons.arrow_forward, size: 16),
            ],
          ),
        ],
      ),
    );
  }
}
