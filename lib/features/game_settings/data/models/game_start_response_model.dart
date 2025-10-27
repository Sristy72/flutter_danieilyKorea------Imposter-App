class GameResponse {
  final String gameCode;
  final List<Player> players;
  final String phase;
  final String id;
  final String createdAt;

  GameResponse({
    required this.gameCode,
    required this.players,
    required this.phase,
    required this.id,
    required this.createdAt,
  });

  factory GameResponse.fromJson(Map<String, dynamic> json) {
    return GameResponse(
      gameCode: json['gameCode'],
      players: (json['players'] as List<dynamic>)
          .map((player) => Player.fromJson(player))
          .toList(),
      phase: json['phase'],
      id: json['_id'],
      createdAt: json['createdAt'],
    );
  }
}

class Player {
  final String name;
  final bool isImposter;
  final String wordAssigned;
  final String wordCategory;
  final String questions;
  String answer;
  final String id;

  Player({
    required this.name,
    required this.isImposter,
    required this.wordAssigned,
    required this.wordCategory,
    required this.questions,
    required this.answer,
    required this.id,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      name: json['name'],
      isImposter: json['isImposter'],
      wordAssigned: json['wordAssigned'],
      wordCategory: json['WordCategory'],
      questions: json['questions'],
      answer: json['answer'],
      id: json['_id'],
    );
  }
}
