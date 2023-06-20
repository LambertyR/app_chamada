import 'package:chamada_univel/data/aluno_entity.dart';
import 'package:chamada_univel/data/disciplina_entity.dart';

class AlunoDisciplinaEntity {
  late int? aluno_disciplinaID;
  AlunoEntity? aluno;
  DisciplinaEntity? disciplina;

  AlunoDisciplinaEntity({
    this.aluno,
    this.disciplina,
  });
}
