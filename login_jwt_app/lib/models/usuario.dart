class Usuario {
  final String email;
  final String password;

  Usuario({required this.email, required this.password});

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };
}
