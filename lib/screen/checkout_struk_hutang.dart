import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CheckoutStrukHutang extends StatelessWidget {
  CheckoutStrukHutang({super.key});

  final List<Product> productList = [
    Product(
      name: "Garam 250g",
      modalPrice: 5000,
      sellPrice: 7000,
      stock: 100,
      imagePath: "assets/items/garam.png",
    ),
    Product(
      name: "Gula 1kg",
      modalPrice: 12000,
      sellPrice: 15000,
      stock: 50,
      imagePath: "assets/items/gula.png",
    ),
    // Add more products here if needed
  ];

  // Format currency using the intl package
  String formatCurrency(int amount) {
    final format =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return format.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Struk",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 8.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Text(
                        "ANUGRAH JAYA",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Jalan pasar baru raya timur",
                        style: GoogleFonts.poppins(
                            fontSize: 14, color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 16),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "2024-06-09\n12:10:12\nNo 2",
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                        Text(
                          "Andi",
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Divider(),
                    // Use ListView.builder for product list
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        final product = productList[index];
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: GoogleFonts.poppins(fontSize: 14),
                                    ),
                                    Text(
                                      "1 × ${formatCurrency(product.sellPrice)}",
                                      style: GoogleFonts.poppins(fontSize: 14),
                                    ),
                                  ],
                                ),
                                Text(
                                  formatCurrency(product.sellPrice),
                                  style: GoogleFonts.poppins(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 8),
                    Divider(),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          formatCurrency(productList.fold(
                              0, (sum, item) => sum + item.sellPrice)),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pembayaran : Kredit",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Color.fromRGBO(38, 38, 38, 0.6),
                              ),
                            ),
                            Text(
                              "Status : Lunas",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Color.fromRGBO(38, 38, 38, 0.6),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Tempo 15/06/24",
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    // Replace the Aplikasir logo with an image
                    Center(
                      child: Image.asset(
                        'assets/images/logo_utama.png',
                        height: 50, // Adjust size as needed
                        width: 150,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Product {
  final String name;
  final int modalPrice;
  final int sellPrice;
  final int stock;
  final String imagePath;

  Product({
    required this.name,
    required this.modalPrice,
    required this.sellPrice,
    required this.stock,
    required this.imagePath,
  });
}
