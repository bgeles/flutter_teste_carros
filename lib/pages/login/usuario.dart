class Usuario {
  String login;
  String nome;
  String email;
  String token;

  List<String> roles;

  Usuario.fromJson(Map<String, dynamic> map)
      : this.nome = map["nome"],
        this.login = map["login"],
        this.email = map["email"],
        this.token = map["token"],
        this.roles = map["roles"] != null
            ? map["roles"].map<String>((role) => role.toString()).toList()
            : null;

  @override
  String toString() {
    return 'Usuário{login: $login, nome: $nome, email: $email, token: $token, roles: $roles';
  }

  static getRoles(Map<String, dynamic> map) {
    List list = map["roles"];
    List<String> roles = list.map<String>((role) => role.toString()).toList();

    return roles;
  }
}
