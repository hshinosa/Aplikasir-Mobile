class RiwayatAdminModel {
  final int id;
  final int idAdmin;
  final int? idTarget;
  final String tipeAksi;
  final String deskripsiAksi;
  final DateTime createdAt;

  RiwayatAdminModel({
    required this.id,
    required this.idAdmin,
    this.idTarget,
    required this.tipeAksi,
    required this.deskripsiAksi,
    required this.createdAt,
  });

  // Mengonversi data dari JSON ke model
  factory RiwayatAdminModel.fromJson(Map<String, dynamic> json) {
    return RiwayatAdminModel(
      id: json['id'],
      idAdmin: json['id_admin'],
      idTarget: json['id_target'],
      tipeAksi: json['tipe_aksi'],
      deskripsiAksi: json['deksripsi_aksi'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // Mengonversi model ke format JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_admin': idAdmin,
      'id_target': idTarget,
      'tipe_aksi': tipeAksi,
      'deksripsi_aksi': deskripsiAksi,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
