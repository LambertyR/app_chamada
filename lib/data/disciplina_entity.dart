import 'package:chamada_univel/data/perfil_Entity.dart';

class DisciplinaEntity {
  late int? disciplinaID;
  String? nome;
  PerfilEntity? perfil_id;

  DisciplinaEntity({
    this.nome,
    this.perfil_id,
  });
}
