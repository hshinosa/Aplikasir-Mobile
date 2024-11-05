import 'package:aplikasir/screen/checkout_struk_transaksi.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CheckoutBerhasil extends StatelessWidget {
  const CheckoutBerhasil({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 66),
          child: Column(
            children: [
              Image.asset(
                "assets/icons/success_icon.png",
                width: 100,
                height: 100,
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                "Transaksi Berhasil",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 8),
                    child: Text(
                      "Kembali",
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      color: Color.fromRGBO(
                          198, 200, 203, 1), // Set the color of the line
                      thickness: 1, // Set the thickness of the line
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 20),
                    child: Text(
                      formatCurrency(
                        6000,
                      ),
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 31,
              ),
              TextButton(
                onPressed: () {
                  // Ke Mulai Transaksi
                },
                style: TextButton.styleFrom(
                  fixedSize: const Size(340, 60),
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  alignment: Alignment.centerLeft,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: Text(
                  "Transaksi Baru",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 23),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckoutStrukTransaksi(),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  fixedSize: const Size(340, 60),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  side: const BorderSide(color: Colors.blue, width: 1.5),
                ),
                child: Text(
                  "Lihat Struk Transaksi",
                  style: GoogleFonts.poppins(
                    color: Colors.blue,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String formatCurrency(int amount) {
  final format =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
  return format.format(amount);
}
