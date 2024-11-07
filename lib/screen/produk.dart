import 'package:aplikasir/screen/tambahproduk.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Import the intl package

class Produk extends StatelessWidget {
  Produk({super.key});

  final List<Product> products = [
    Product(
        name: 'Garam 250g',
        modalPrice: 5000,
        sellPrice: 7000,
        stock: 20,
        imagePath: 'assets/items/garam.png'),
    Product(
        name: 'Gula 1kg',
        modalPrice: 9000,
        sellPrice: 14000,
        stock: 20,
        imagePath: 'assets/items/gula.png'),
    Product(
        name: 'Sendal Jepit',
        modalPrice: 7000,
        sellPrice: 10000,
        stock: 0,
        imagePath: 'assets/items/sendal.png'),
    Product(
        name: 'Garam 250g',
        modalPrice: 5000,
        sellPrice: 7000,
        stock: 20,
        imagePath: 'assets/items/garam.png'),
    Product(
        name: 'Gula 1kg',
        modalPrice: 9000,
        sellPrice: 14000,
        stock: 20,
        imagePath: 'assets/items/gula.png'),
    Product(
        name: 'Sendal Jepit',
        modalPrice: 7000,
        sellPrice: 10000,
        stock: 0,
        imagePath: 'assets/items/sendal.png'),
  ];

  // Define a NumberFormat for Indonesian Rupiah currency format
  final NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(245, 245, 245, 1),
        title: Center(
          child: Text(
            "Produk",
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 22),
          ),
        ),
        centerTitle: true,
        elevation: 0, // Menghilangkan bayangan
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Search Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width *
                            0.76, // 76% of screen width
                        height: 45,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(221, 231, 248, 1),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.search,
                                color: Color.fromRGBO(198, 200, 203, 1),
                                size: 24,
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Cari nama atau kode produk",
                                style: TextStyle(
                                  color: Color.fromRGBO(198, 200, 203, 1),
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width *
                              0.055, // 5.5% of screen width
                          child: Icon(
                            Icons.list,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      height:
                          10), // Spacing between search bar and product list
                  // ListView for displaying products
                  Expanded(
                    child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];

                        return Card(
                          color: Colors.white, // White background for the card
                          margin: EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                // Display product image from assets
                                Image.asset(
                                  product
                                      .imagePath, // Load image from product's imagePath
                                  width: 50,
                                  height: 50,// Set image width
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Stock Barang ${product.stock}",
                                        style: GoogleFonts.poppins(
                                            color: Color(0xFF4B71B2),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: 5),
                                    ],
                                  ),
                                ),
                                // Display prices and action buttons
                                Column(
                                  children: [
                                    Text(
                                      'Harga Modal',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Color.fromRGBO(38, 38, 38, 0.3)),
                                    ),
                                    Text(
                                      currencyFormat.format(product.modalPrice),
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ), // Format modal price
                                    Text(
                                      'Harga Jual',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Color.fromRGBO(38, 38, 38, 0.3)),
                                    ),
                                    Text(
                                        currencyFormat
                                            .format(product.sellPrice),
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        )), // Format sell price
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: Image.asset(
                                          'assets/icons/delete.png',
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Image.asset(
                                          'assets/icons/edit.png',
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: const Alignment(0.9, 0.9), // Bottom right corner
              child: GestureDetector(
                onTap: () {
                  _navigateToTambahProduk(context);
                },
                child: Image.asset(
                  'assets/icons/plus.jpg',
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _navigateToTambahProduk(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const TambahProduk(),
    ),
  );
}


class Product {
  final String name;
  final int modalPrice;
  final int sellPrice;
  final int stock;
  final String imagePath; // Add imagePath field

  Product({
    required this.name,
    required this.modalPrice,
    required this.sellPrice,
    required this.stock,
    required this.imagePath, // Add imagePath in constructor
  });
}
