// pelunasan_kredit.dart
import 'package:aplikasir/screen/kredit_berhasil.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PelunasanKredit extends StatefulWidget {
  const PelunasanKredit({Key? key}) : super(key: key);

  @override
  _PelunasanKreditState createState() => _PelunasanKreditState();
}

class _PelunasanKreditState extends State<PelunasanKredit> {
  final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
  bool bayarLunas = false;
  String selectedPaymentMethod = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        title: Text(
          'Kredit',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nama Pelanggan',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF8392AA),
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Andi',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Sisa Pembayaran',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF8392AA),
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              formatter.format(5000),
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Center(
                      child: Text(
                        formatter.format(0),
                        style: GoogleFonts.poppins(
                          color: Colors.grey[400],
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: Colors.grey[300],
                      ),
                      child: CheckboxListTile(
                        title: Text(
                          'Bayar Lunas',
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                        value: bayarLunas,
                        onChanged: (val) {
                          setState(() {
                            bayarLunas = val ?? false;
                          });
                        },
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Metode Pembayaran',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF8392AA),
                        fontSize: 12,
                      ),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: Colors.grey[300],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                              title: Text(
                                'Cash',
                                style: GoogleFonts.poppins(fontSize: 14),
                              ),
                              value: 'Cash',
                              groupValue: selectedPaymentMethod,
                              onChanged: (val) {
                                setState(() {
                                  selectedPaymentMethod = val.toString();
                                });
                              },
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              title: Text(
                                'QRIS',
                                style: GoogleFonts.poppins(fontSize: 14),
                              ),
                              value: 'QRIS',
                              groupValue: selectedPaymentMethod,
                              onChanged: (val) {
                                setState(() {
                                  selectedPaymentMethod = val.toString();
                                });
                              },
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CheckoutKreditBerhasil()),
                  );
                },
                child: Text(
                  'Konfirmasi',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
