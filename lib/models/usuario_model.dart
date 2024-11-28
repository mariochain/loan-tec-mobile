class Usuario {
  final String name;
  final String email;
  final int semester;
  final String degreeProgramName;
  final String pictureProfile;
  final String controlNumber;
  final String role;

  Usuario({
    required this.name,
    required this.email,
    required this.semester,
    required this.degreeProgramName,
    required this.pictureProfile,
    required this.controlNumber,
    required this.role,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      name: json['name'],
      email: json['email'],
      semester: json['semester'],
      degreeProgramName: json['degreeProgramName'],
      pictureProfile: json['pictureProfile'],
      controlNumber: json['controlNumber'],
      role: json['role'],
    );
  }
}
