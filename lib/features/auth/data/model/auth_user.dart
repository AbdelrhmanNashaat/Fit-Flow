class AuthUser {
  const AuthUser({
    required this.id,
    required this.name,
    required this.email,
  });

  factory AuthUser.empty() {
    return const AuthUser(id: '', name: '', email: '');
  }

  final String id;
  final String name;
  final String email;

  AuthUser copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return AuthUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
