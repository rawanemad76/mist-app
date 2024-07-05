
class RoadStates{}
class RoadInitialState extends RoadStates{}
class RoadLoadedState extends RoadStates{}
class RoadFailureState extends RoadStates{
  final String errorMessage;

  RoadFailureState({required this.errorMessage});
}