import 'package:aplikasir/screen/kredit/kredit_list_screen.dart';
import 'package:aplikasir/screen/checkout/transaksi_pilih.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import '../produk/produk.dart';
import '../profile/akun.dart';
import '../laporan/laporan.dart';
import 'package:aplikasir/screen/kredit/daftar_kredit.dart';

class HomePage extends StatefulWidget {
  final String userId; // Pastikan userId dideklarasikan dan diterima
  final int initialPageIndex; // Halaman awal

  const HomePage({Key? key, required this.userId, this.initialPageIndex = 0})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _selectedIndex;
  late int _selectedTab;
  late List<Widget> _children;

  @override
  void initState() {
    super.initState();

    _children = [
      HomeContent(
        userId: widget.userId,
        selectedTab: 0,
        onTabChange: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
      ),
      Produk(userId: widget.userId), // Kirim userId ke Produk
      Laporan(userId: widget.userId), // Kirim userId ke Laporan
      Akun(userId: widget.userId), // Kirim userId ke Akun
    ];

    _selectedIndex = widget.initialPageIndex;
    _selectedTab = 0;

    // Atur gaya status bar
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _children,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 80,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: [
              _buildBottomNavigationBarItem(
                  'assets/icons/home_nav_icon.png', 'Beranda', 0),
              _buildBottomNavigationBarItem(
                  'assets/icons/stock_nav_icon.png', 'Produk', 1),
              _buildBottomNavigationBarItem(
                  'assets/icons/report_nav_icon.png', 'Laporan', 2),
              _buildBottomNavigationBarItem(
                  'assets/icons/user_nav_icon.png', 'Akun', 3),
            ],
            selectedLabelStyle: GoogleFonts.poppins(
              fontSize: 12,
              height: 2.3,
            ),
            unselectedLabelStyle: GoogleFonts.poppins(
              fontSize: 12,
              height: 2,
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      String assetPath, String label, int index) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        assetPath,
        width: 24,
        height: 24,
        color: _selectedIndex == index ? Colors.blue : Colors.grey,
      ),
      label: label,
    );
  }
}


class HomeContent extends StatefulWidget {
  final int selectedTab;
  final Function(int) onTabChange;
  final String userId;

  HomeContent({Key? key, required this.userId, required this.selectedTab, required this.onTabChange})
      : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();

  static const Color kIconContainerBackgroundColor =
      Color.fromRGBO(245, 245, 245, 1);
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CustomShape(
                color: Color.fromARGB(255, 40, 109, 225),
                height: 250,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  decoration: BoxDecoration(
                    color: HomeContent.kIconContainerBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildIconButton(
                        'assets/icons/qr_icon.png',
                        'QR',
                        () {
                          // Navigate to QR screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DaftarKredit(userId: widget.userId), // Replace with your QR screen class
                            ),
                          );
                        },
                        widget.userId
                      ),
                      _buildIconButton(
                        'assets/icons/credit_icon.png',
                        'Kredit',
                        () {
                          // Navigate to DaftarKredit screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  KreditListScreen(userId: widget.userId), // Replace with your DaftarKredit screen class
                            ),
                          );
                        },
                        widget.userId
                      ),
                      _buildIconButton(
                        'assets/icons/customer_icon.png',
                        'Pelanggan',
                        () {
                          // Navigate to Pelanggan screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DaftarKredit(userId: widget.userId), // Replace with your Pelanggan screen class
                            ),
                          );
                        },
                        widget.userId
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Riwayat',
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTabButton('Semua', index: 0),
                  _buildTabButton('Transaksi', index: 1),
                  _buildTabButton('Barang', index: 2),
                  _buildTabButton('Kredit', index: 3),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                    height: 5), // Menambahkan jarak antara tab dan ListView
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(16),
                    children: _getFilteredTransactions().map((transaction) {
                      return _buildTransactionTile(
                        imagePath: transaction['imagePath']!,
                        title: transaction['title']!,
                        subtitle: transaction['subtitle']!,
                        amount: transaction['amount']!,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TransaksiScreen(userId: widget.userId,)),
            );
          },
          child: Image.asset(
            'assets/icons/shoppingcart_icon.png',
            width: 24,
            height: 24,
          ),
          backgroundColor: Color.fromRGBO(40, 109, 225, 1),
          shape: CircleBorder(),
        ),
      ),
    );
  }

  String formatRupiah(String amount) {
    final number = double.tryParse(amount
            .replaceAll('Rp', '')
            .replaceAll(',', '')
            .replaceAll('.', '')) ??
        0;
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatter.format(number);
  }

  Widget _buildIconButton(String iconPath, String label, VoidCallback onTap, String userId) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Image.asset(iconPath, width: 60, height: 60),
            const SizedBox(height: 5),
            Text(
              label,
              style: GoogleFonts.poppins(
                color: const Color.fromARGB(255, 13, 44, 70),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
  


  Widget _buildTabButton(String label, {required int index}) {
    bool isActive = widget.selectedTab == index;

    return GestureDetector(
      onTap: () {
        widget.onTabChange(index);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          vertical: isActive ? 8 : 6,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? Color.fromARGB(255, 40, 109, 225)
              : Color.fromARGB(64, 185, 211, 253),
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.only(right: 14),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            color: isActive ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionTile({
    required String imagePath,
    required String title,
    required String subtitle,
    required String amount,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(38, 185, 211, 253),
            offset: Offset(0, 2),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ListTile(
        leading: Image.asset(
          imagePath,
          width: 50,
          height: 50,
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.poppins(
            fontSize: 12,
          ),
        ),
        trailing: Text(formatRupiah(amount),
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),
    );
  }

  List<Map<String, String>> transactions = [
    {
      'category': 'Transaksi',
      'imagePath': 'assets/icons/income_icon.png',
      'title': 'Transaksi',
      'subtitle': 'Pembayaran dari QRIS',
      'amount': 'Rp 5.000',
    },
    {
      'category': 'Kredit',
      'imagePath': 'assets/icons/creditur_icon.png',
      'title': 'Kredit',
      'subtitle': 'Kredit Pelanggan',
      'amount': 'Rp 2.000',
    },
    {
      'category': 'Barang',
      'imagePath': 'assets/icons/stock_icon.png',
      'title': 'Pembelian Barang',
      'subtitle': 'Pembelian Barang Toko',
      'amount': 'Rp 50.000',
    },
    {
      'category': 'Transaksi',
      'imagePath': 'assets/icons/income_icon.png',
      'title': 'Transaksi Baru',
      'subtitle': 'Pembayaran dari Transfer',
      'amount': 'Rp 100.000',
    },
    {
      'category': 'Transaksi',
      'imagePath': 'assets/icons/income_icon.png',
      'title': 'Transaksi Baru',
      'subtitle': 'Pembayaran dari Transfer',
      'amount': 'Rp 100.000',
    },
  ];

  List<Map<String, String>> _getFilteredTransactions() {
    if (widget.selectedTab == 0) {
      return transactions;
    } else if (widget.selectedTab == 1) {
      return transactions
          .where((transaction) => transaction['category'] == 'Transaksi')
          .toList();
    } else if (widget.selectedTab == 2) {
      return transactions
          .where((transaction) => transaction['category'] == 'Barang')
          .toList();
    } else if (widget.selectedTab == 3) {
      return transactions
          .where((transaction) => transaction['category'] == 'Kredit')
          .toList();
    }
    return transactions;
  }
}

class CustomShape extends StatelessWidget {
  final Color color;
  final double height;

  CustomShape({required this.color, required this.height});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: height,
            color: color,
          ),
        ),
        // Logo positioning
        Positioned(
          left: 20, // Jarak dari kiri
          top: height / 2 -
              110, // Tengah vertikal (dikurangi setengah tinggi logo)
          child: Image.asset(
            'assets/icons/logoaplikasir.png', // Ganti dengan path logo Anda
            width: 120, // Sesuaikan dengan ukuran yang diinginkan
            height: 120,
          ),
        ),
      ],
    );
  }
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 60,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
