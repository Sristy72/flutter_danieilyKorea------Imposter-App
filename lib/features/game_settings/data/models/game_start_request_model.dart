class GameRequest {
  final List<String> playerNames;
  final String type;

  GameRequest({
    required this.playerNames,
    required this.type,
  });


  Map<String, dynamic> toJson() {
    return {
      'playerNames': playerNames,
      'type': type,
    };
  }
}
