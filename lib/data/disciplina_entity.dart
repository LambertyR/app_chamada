import 'package:chamada_univel/data/perfil_entity.dart';

class DisciplinaEntity {
  late int? disciplinaID;
  String? nome;
  PerfilEntity? perfil;

  DisciplinaEntity({
    this.nome,
    this.perfil,
  });
}
