class RiwayatPenggunaModel {
  final int id;
  final int idPengguna;
  final String kategori;
  final String deskripsi;
  final DateTime createdAt;

  RiwayatPenggunaModel({
    required this.id,
    required this.idPengguna,
    required this.kategori,
    required this.deskripsi,
    required this.createdAt,
  });

  // Mengonversi data dari JSON ke model
  factory RiwayatPenggunaModel.fromJson(Map<String, dynamic> json) {
    return RiwayatPenggunaModel(
      id: json['id'],
      idPengguna: json['id_pengguna'],
      kategori: json['kategori'],
      deskripsi: json['deskripsi'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // Mengonversi model ke format JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_pengguna': idPengguna,
      'kategori': kategori,
      'deskripsi': deskripsi,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
