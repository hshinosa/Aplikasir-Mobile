class TransaksiModel {
  final int id; // ID Transaksi
  final int idPengguna; // ID Pengguna
  final String metodePembayaran; // Metode Pembayaran
  final String jenisTransaksi; // Jenis Transaksi
  final List<Map<String, dynamic>> details; // List produk dalam transaksi

  TransaksiModel({
    required this.id,
    required this.idPengguna,
    required this.metodePembayaran,
    required this.jenisTransaksi,
    required this.details,
  });

  // Fungsi untuk konversi ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_pengguna': idPengguna,
      'metode_pembayaran': metodePembayaran,
      'jenis_transaksi': jenisTransaksi,
      'details': details,
    };
  }

  // Fungsi untuk membuat model dari JSON
  factory TransaksiModel.fromJson(Map<String, dynamic> json) {
    return TransaksiModel(
      id: json['id'] ?? 0,
      idPengguna: json['id_pengguna'] ?? 0,
      metodePembayaran: json['metode_pembayaran'] ?? 'Tidak diketahui',
      jenisTransaksi: json['jenis_transaksi'] ?? 'Tidak diketahui',
      details: List<Map<String, dynamic>>.from(json['details'] ?? []),
    );
  }
}
