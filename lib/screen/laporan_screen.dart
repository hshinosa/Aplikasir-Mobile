import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  // List pilihan dropdown
  final List<String> items = ['Hari ini', 'Kemarin', 'Minggu lalu'];
  // Nilai dropdown yang dipilih
  String? selectedItem;

  List<bool> isSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Center(
          // Menggunakan Center untuk memusatkan konten
          child: Padding(
            padding: const EdgeInsets.all(14.0), // Padding untuk seluruh konten
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Memusatkan secara vertikal
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Memusatkan secara horizontal
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pop(
                            context); // Aksi untuk kembali ke halaman sebelumnya
                      },
                    ),
                    SizedBox(
                      width: 98,
                    ),
                    Text(
                      'Laporan',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 20), // Spasi antara elemen
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Pusatkan dropdown dan tombol unduh
                  children: [
                    // Dropdown untuk memilih item
                    Container(
                      height: 33,
                      padding:
                          EdgeInsets.symmetric(vertical: 1, horizontal: 9.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            width: 2), // Warna dan lebar border
                        borderRadius: BorderRadius.circular(8), // Border radius
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_month),
                          SizedBox(
                            width: 8,
                          ),
                          DropdownButton<String>(
                            hint: Text('Hari Ini'),
                            value: selectedItem,
                            items: items.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedItem = newValue;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        width: 16), // Spasi antara dropdown dan tombol unduh
                    // Tombol Unduh Laporan
                    Container(
                      height: 33,
                      padding: EdgeInsets.symmetric(
                          vertical: 2.0,
                          horizontal: 16.0), // Padding untuk teks tombol
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            width: 2), // Warna dan lebar border
                        borderRadius: BorderRadius.circular(8), // Border radius
                      ),
                      child: Text(
                        'Unduh Laporan',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 329,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0xFFDADADA),
                              width: 2), // Warna dan lebar border
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 14.0,
                                  horizontal:
                                      16.0), // Padding untuk teks tombol
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xFF286DE1),
                                      width: 2), // Warna dan lebar border
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xFF286DE1)),
                              child: Icon(
                                Icons.trending_up,
                                color: Colors.white,
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(left: 5)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '1',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                                Text(
                                  'Jumlah Transaksi',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ],
                            )
                          ],
                        ))
                  ],
                ),
                SizedBox(
                  height: 18,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 329,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0xFFDADADA),
                              width: 2), // Warna dan lebar border
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 14.0,
                                  horizontal:
                                      16.0), // Padding untuk teks tombol
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xFF286DE1),
                                      width: 2), // Warna dan lebar border
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xFF286DE1)),
                              child: Icon(
                                Icons.trending_up,
                                color: Colors.white,
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(left: 5)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Rp.30.000',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                                Text(
                                  'Laba Rugi',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ],
                            )
                          ],
                        ))
                  ],
                ),
                SizedBox(
                  height: 18,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 329,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0xFFDADADA),
                              width: 2), // Warna dan lebar border
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 14.0,
                                  horizontal:
                                      16.0), // Padding untuk teks tombol
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xFF286DE1),
                                      width: 2), // Warna dan lebar border
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xFF286DE1)),
                              child: Icon(
                                Icons.trending_up,
                                color: Colors.white,
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(left: 5)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Rp.50.000',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                                Text(
                                  'Pendapatan',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ],
                            )
                          ],
                        ))
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Laporan Transaksi',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ToggleButtons(
                      borderRadius: BorderRadius.circular(20),
                      borderColor: Colors.grey,
                      selectedBorderColor: Colors.grey,
                      fillColor: Color(0xFF286DE1),
                      selectedColor: Colors.white,
                      color: Colors.black,
                      isSelected: isSelected,
                      onPressed: (int index) {
                        setState(() {
                          for (int i = 0; i < isSelected.length; i++) {
                            isSelected[i] = i == index;
                          }
                        });
                      },
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text('Transaksi'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text('Laba Rugi'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text('Pendapatan'),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 199,
                        ),
                        SizedBox(
                          width: 320, // Lebar garis
                          height: 2, // Tinggi garis
                          child: Container(
                            color: const Color.fromARGB(
                                255, 0, 0, 0), // Warna garis
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 2, // Lebar garis
                      height: 200, // Tinggi garis
                      child: Container(
                        color:
                            const Color.fromARGB(255, 0, 0, 0), // Warna garis
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Penjualan Teratas',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 330,
                  padding: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffDADADA)),
                      borderRadius: BorderRadius.circular(7)),
                  child: Column(
                    children: [
                      Container(
                        width: 330,
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xffDADADA), width: 1),
                            borderRadius: BorderRadius.circular(7)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Produk',
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              'Penjualan',
                              style: TextStyle(fontSize: 14),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Padding(padding: EdgeInsets.only(left: 20)),
                          Image(image: AssetImage('assets/images/cake.png')),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kue',
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                'Rp.5000',
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xff286DE1)),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 130,
                          ),
                          Column(
                            children: [
                              Text(
                                '10',
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                '0,2%',
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xff219469)),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Padding(padding: EdgeInsets.only(left: 20)),
                          Image(image: AssetImage('assets/images/cake.png')),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Risol Enak Banget Cok',
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                'Rp.5000',
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xff286DE1)),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 38,
                          ),
                          Column(
                            children: [
                              Text(
                                '10',
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                '0,2%',
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xff219469)),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
