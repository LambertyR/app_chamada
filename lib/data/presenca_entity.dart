import 'package:chamada_univel/data/aluno_disciplina_entity.dart';

class PresencaEntity {
  late int? presencaID;
  AlunoDisciplinaEntity? aluno_disciplina;
  DateTime? data;

  PresencaEntity({
    this.aluno_disciplina,
    this.data,
  });
}
