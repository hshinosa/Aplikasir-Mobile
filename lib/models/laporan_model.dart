class LaporanModel {
  final int id;
  final int idPengguna;
  final double totalPenjualan;
  final int totalTransaksi;

  LaporanModel({
    required this.id,
    required this.idPengguna,
    required this.totalPenjualan,
    required this.totalTransaksi,
  });

  // Convert JSON to Laporanmodel object
  factory LaporanModel.fromJson(Map<String, dynamic> json) {
    print('Parsing JSON: $json');
    return LaporanModel(
      id: json['id'] ?? 0,
      idPengguna: json['id_pengguna'] ?? 0,
      totalPenjualan: double.tryParse(json['total_penjualan'] ?? '0') ?? 0.0,
      totalTransaksi: json['total_transaksi'] ?? 0,
    );
  }

  // Convert Laporanmodel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_pengguna': idPengguna,
      'total_penjualan': totalPenjualan.toStringAsFixed(2),
      'total_transaksi': totalTransaksi,
    };
  }
}
