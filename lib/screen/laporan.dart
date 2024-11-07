import 'package:aplikasir/screen/laporan_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aplikasir/screen/menulaporan.dart'; // Import menulaporan.dart where MenuLaporan is defined

class Laporan extends StatelessWidget {
  const Laporan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Laporan",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // Centers the title in the AppBar
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: Image.asset(
                "assets/icons/graph.png",
                width: 50,
                height: 50,
              ),
              title: Text(
                "Laporan Transaksi",
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
              ),
              onTap: () {
                // Navigate to MenuLaporan screen on tap
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportPage()),
                );
              },
            ),
            _customDivider(context), // Custom divider for 80% width and color opacity
            ListTile(
              leading: Image.asset(
                "assets/icons/graph_all.png",
                width: 50,
                height: 50,
              ),
              title: Text(
                "Semua Laporan Transaksi",
                style: GoogleFonts.poppins(fontSize: 16),
              ),
              onTap: () {
                // Navigate to MenuLaporan screen on tap
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Menulaporan()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Custom divider with 80% width, centered, and color with 50% opacity
  Widget _customDivider(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8, // 80% width of the screen
          height: 1, // Height of the divider (thin)
          color: Color(0xFFC6C8CB).withOpacity(0.5), // Custom color C6C8CB with 50% opacity
        ),
      ),
    );
  }
}
