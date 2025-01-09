class PenggunaModel {
  final int id;
  final String nama;
  final String username;
  final String email;
  final String role;
  final String nomorTelepon;
  final String namaToko;
  final String alamatToko;
  final String gambarQris;
  final String fotoProfil;
  final String statusAkun;

  PenggunaModel({
    required this.id,
    required this.nama,
    required this.username,
    required this.email,
    required this.role,
    required this.nomorTelepon,
    required this.namaToko,
    required this.alamatToko,
    required this.gambarQris,
    required this.fotoProfil,
    required this.statusAkun, String? gambarProfile,
  });

  factory PenggunaModel.fromJson(Map<String, dynamic> json) {
    return PenggunaModel(
      id: json['id'],
      nama: json['nama'],
      username: json['username'],
      email: json['email'],
      role: json['role'],
      nomorTelepon: json['nomor_telepon'] ?? '',
      namaToko: json['nama_toko'] ?? '',
      alamatToko: json['alamat_toko'] ?? '',
      gambarQris: json['gambar_qris'] ?? '',
      fotoProfil: json['foto_profil'] ?? '',
      statusAkun: json['status_akun'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'username': username,
      'email': email,
      'role': role,
      'nomor_telepon': nomorTelepon,
      'nama_toko': namaToko,
      'alamat_toko': alamatToko,
      'gambar_qris': gambarQris,
      'foto_profil': fotoProfil,
      'status_akun': statusAkun,
    };
  }
}
