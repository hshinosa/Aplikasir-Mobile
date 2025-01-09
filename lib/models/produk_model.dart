class ProdukModel {
  final int id;
  final int idPengguna;
  final String gambarProduk;
  final String namaProduk;
  final String kodeProduk;
  final int jumlahProduk;
  final double hargaModal; // Mengubah tipe menjadi double
  final double hargaJual; // Mengubah tipe menjadi double
  final DateTime createdAt;
  final DateTime updatedAt;

  ProdukModel({
    required this.id,
    required this.idPengguna,
    required this.gambarProduk,
    required this.namaProduk,
    required this.kodeProduk,
    required this.jumlahProduk,
    required this.hargaModal,
    required this.hargaJual,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProdukModel.fromJson(Map<String, dynamic> json) {
    return ProdukModel(
      id: json["id"] as int,
      idPengguna: json["id_pengguna"],
      gambarProduk: json["gambar_produk"],
      namaProduk: json["nama_produk"],
      kodeProduk: json["kode_produk"],
      jumlahProduk: json["jumlah_produk"],
      hargaModal: double.tryParse(json["harga_modal"]) ??
          0.0, // Pastikan di-convert ke double
      hargaJual: double.tryParse(json["harga_jual"]) ??
          0.0, // Pastikan di-convert ke double
      createdAt: DateTime.tryParse(json["created_at"] ?? "") ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? "") ?? DateTime.now(),
    );
  }
}
