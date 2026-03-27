@JS('YaGames')
library yandex_games;

import 'package:js/js.dart';

@JS()
external Future<void> init();

@JS('getPlayer')
external Future<Player> getPlayer();

@JS()
class Player {
  external String get id;
  external String get name;
}

@JS('getLeaderboards')
external Future<Leaderboards> getLeaderboards();

@JS()
@anonymous
class LeaderboardEntry {
  external factory LeaderboardEntry({int score});
  external int get score;
}

@JS()
class Leaderboards {
  external Future<LeaderboardEntry> getPlayerEntry(String leaderboardName);
  external Future<LeaderboardEntry> set(String leaderboardName, int score);
}

@JS('showFullScreenAd')
external Future<void> showFullScreenAd();
