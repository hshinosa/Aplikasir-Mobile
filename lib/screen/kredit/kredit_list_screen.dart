import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'daftar_kredit.dart';
import 'package:aplikasir/screen/home/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KreditListScreen extends StatefulWidget {
  final String userId;

  const KreditListScreen({Key? key, required this.userId}) : super(key: key);

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
              MaterialPageRoute(builder: (context) => HomePage(userId: widget.userId,)),
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
              child: FutureBuilder(
                future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.userId)
                  .collection('kredits')
                  .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData){
                    return Center(child: CircularProgressIndicator());
                  }

                  final kreditDocs = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: kreditDocs.length,
                    itemBuilder: (context, index) {
                      final kredit = kreditDocs[index].data() as Map<String, dynamic>;
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: const Color(0xFFEAF1FB),
                          child: Icon(Icons.person, color: Colors.blue),
                        ),
                        title: Text(
                          kredit['nama'] ?? 'Tidak Diketahui',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          kredit['nomor'] ?? 'Tidak Ada Nomor',
                          style: GoogleFonts.poppins(fontSize: 12),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Rp ${kredit['jumlah'] ?? 0}',
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                            ),
                            Icon(Icons.chevron_right),
                          ],
                        ),
                      );
                    },
                  );
                }
              )
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
                      MaterialPageRoute(builder: (context) => DaftarKredit(userId: widget.userId,)),
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
