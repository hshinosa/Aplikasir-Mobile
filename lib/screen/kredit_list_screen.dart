// kredit_list_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'daftar_kredit.dart';
import 'package:aplikasir/screen/homepage.dart';

class KreditListScreen extends StatefulWidget {
  @override
  _KreditListScreenState createState() => _KreditListScreenState();
}

class _KreditListScreenState extends State<KreditListScreen> {
  bool isBelumLunas = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Arahkan pengguna ke HomePage
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        title: Text(
          'Kredit',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 48, 
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Nama',
                        prefixIcon: Icon(Icons.search, size: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFEAF1FB), 
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 48, 
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color:  const Color(0xFFEAF1FB), 
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_today, size: 20),
                        SizedBox(width: 4),
                        Text(
                          'Jatuh Tempo',
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color:  const Color(0xFFEAF1FB),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Jumlah Kredit',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Total Kredit',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rp 5.000',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        '1',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    title: Text(
                      'Belum Lunas',
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    value: isBelumLunas,
                    onChanged: (bool? value) {
                      setState(() {
                        isBelumLunas = true;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: CheckboxListTile(
                    title: Text(
                      'Sudah Lunas',
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    value: !isBelumLunas,
                    onChanged: (bool? value) {
                      setState(() {
                        isBelumLunas = false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor:  const Color(0xFFEAF1FB),
                    child: Icon(Icons.person, color: Colors.blue),
                  ),
                  title: Text('Andi', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                  subtitle: Text('+628957244844', style: GoogleFonts.poppins(fontSize: 12)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Rp 5.000', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                  onTap: () {
                    // Navigasi ke DaftarKredit
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DaftarKredit()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
