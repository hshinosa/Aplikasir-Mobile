class KreditModel {
  final int id;
  final int idPelanggan;
  final double totalKredit;
  final DateTime mulaiKredit;
  final DateTime jatuhTempo;
  final String lunas;
  final DateTime createdAt;
  final DateTime updatedAt;

  KreditModel({
    required this.id,
    required this.idPelanggan,
    required this.totalKredit,
    required this.mulaiKredit,
    required this.jatuhTempo,
    required this.lunas,
    required this.createdAt,
    required this.updatedAt,
  });

  factory KreditModel.fromJson(Map<String, dynamic> json) {
    return KreditModel(
      id: json['id'],
      idPelanggan: json['id_pelanggan'],
      totalKredit: double.parse(json['total_kredit']),
      mulaiKredit: DateTime.parse(json['mulai_kredit']),
      jatuhTempo: DateTime.parse(json['jatuh_tempo']),
      lunas: json['lunas'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_pelanggan': idPelanggan,
      'total_kredit': totalKredit.toString(),
      'mulai_kredit': mulaiKredit.toIso8601String(),
      'jatuh_tempo': jatuhTempo.toIso8601String(),
      'lunas': lunas,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
