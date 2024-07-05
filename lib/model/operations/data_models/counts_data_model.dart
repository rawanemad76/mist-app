class CountsDataModel {
  int all;
  int solvedCount;
  int notSolvedCount;

  CountsDataModel({
    int? solved,
    int? notSolved,
  })  : solvedCount = solved ?? 0,
        notSolvedCount = notSolved ?? 0,
        all = (solved ?? 0) + (notSolved ?? 0);
}
