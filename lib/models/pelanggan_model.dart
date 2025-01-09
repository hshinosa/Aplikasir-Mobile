class PelangganModel {
  final int id;
  final int idPengguna;
  final String nama;
  final String? nomorTelepon;
  final String? email;
  final DateTime createdAt;
  final DateTime updatedAt;

  PelangganModel({
    required this.id,
    required this.idPengguna,
    required this.nama,
    this.nomorTelepon,
    this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  // Mengonversi data dari JSON ke model
  factory PelangganModel.fromJson(Map<String, dynamic> json) {
    return PelangganModel(
      id: json['id'],
      idPengguna: json['id_pengguna'],
      nama: json['nama'],
      nomorTelepon: json['nomor_telepon'],
      email: json['email'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Mengonversi model ke format JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_pengguna': idPengguna,
      'nama': nama,
      'nomor_telepon': nomorTelepon,
      'email': email,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
