import "package:snake/snake.dart";

void main() {
  var game = new Game("#game");
  game
    ..center()
    ..finishLoadingAssets().then((_) { game.tick(); });
}
