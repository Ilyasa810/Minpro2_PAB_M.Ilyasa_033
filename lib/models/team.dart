class Team {
  final int? id;
  final String name;
  final String stadion;
  final String favoritePlayer;

  Team({
    required this.id,
    required this.name,
    required this.stadion,
    required this.favoritePlayer,
  });

  Team copyWith({
    int? id,
    String? name,
    String? stadion,
    String? favoritePlayer,
  }) {
    return Team(
      id: id ?? this.id,
      name: name ?? this.name,
      stadion: stadion ?? this.stadion,
      favoritePlayer: favoritePlayer ?? this.favoritePlayer,
    );
  }

  factory Team.fromMap(Map<String, dynamic> map) {
    final dynamic rawId = map['id'];
    return Team(
      id: rawId is int ? rawId : int.tryParse(rawId?.toString() ?? ''),
      name: map['namatim']?.toString() ?? map['name']?.toString() ?? '',
      stadion: map['stadion']?.toString() ?? '',
      favoritePlayer:
          map['pemainfavorit']?.toString() ??
          map['favorite_player']?.toString() ??
          map['favoritePlayer']?.toString() ??
          '',
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'namatim': name,
      'stadion': stadion,
      'pemainfavorit': favoritePlayer,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }
}
