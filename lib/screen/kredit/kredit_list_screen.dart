import 'package:aplikasir/api/kredit_api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'daftar_kredit.dart';
import 'package:aplikasir/screen/home/homepage.dart';

class KreditListScreen extends StatefulWidget {
  final int userId;

  const KreditListScreen({super.key, required this.userId});

  @override
  _KreditListScreenState createState() => _KreditListScreenState();
}

class _KreditListScreenState extends State<KreditListScreen> {
  bool isBelumLunas = true;
  late Future<List<dynamic>> kreditListFuture;

  @override
  void initState() {
    super.initState();
    kreditListFuture = KreditApi.fetchKreditListPengguna(widget.userId);
  }

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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage(userId: widget.userId)),
            );
          },
        ),
        title: Text(
          'Kredit',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Nama',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      filled: true,
                      fillColor: const Color(0xFFEAF1FB),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF1FB),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_today),
                        SizedBox(width: 4),
                        Text('Jatuh Tempo', style: GoogleFonts.poppins(fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    title: Text('Belum Lunas', style: GoogleFonts.poppins(fontSize: 14)),
                    value: isBelumLunas,
                    onChanged: (value) => setState(() => isBelumLunas = true),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    title: Text('Sudah Lunas', style: GoogleFonts.poppins(fontSize: 14)),
                    value: !isBelumLunas,
                    onChanged: (value) => setState(() => isBelumLunas = false),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: kreditListFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Tidak ada data kredit'));
                }

                final kredits = snapshot.data!;
                return ListView.builder(
                  itemCount: kredits.length,
                  itemBuilder: (context, index) {
                    final kredit = kredits[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFFEAF1FB),
                        child: Icon(Icons.person, color: Colors.blue),
                      ),
                      title: Text(kredit['nama'] ?? 'Tidak Diketahui', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                      subtitle: Text(kredit['nomor'] ?? 'Tidak Ada Nomor', style: GoogleFonts.poppins(fontSize: 12)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Rp ${kredit['jumlah']}', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                          Icon(Icons.chevron_right),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DaftarKredit(userId: widget.userId)),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
