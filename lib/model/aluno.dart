class Aluno {
  int id;
  String nome;
  String email;
  String telefone;
  String instituicao;
  String pathImg;

  Aluno();

  Aluno.fromMap(Map map) {
    id = map["c_id"];
    nome = map["c_nome"];
    email = map["c_email"];
    telefone = map["c_telefone"];
    instituicao = map["c_instituicao"];
    pathImg = map["c_path_img"];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "c_nome": nome,
      "c_email": email,
      "c_telefone": telefone,
      "c_instituicao": instituicao,
      "c_path_img": pathImg
    };
    if (id != null) {
      map["c_id"] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Aluno{ id: $id, "
        "nome: $nome, "
        "email: $email, "
        "telefone: $telefone, "
        "instituicao: $instituicao, "
        "pathImg: $pathImg"
        "]";
  }
}
