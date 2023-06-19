class PresencaEntity {
  late int? presencaID;
  int? aluno_disciplinaID;
  DateTime? data;

  PresencaEntity({
    this.aluno_disciplinaID,
    this.data,
  });
}
