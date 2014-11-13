part of snake;

abstract class Screen {
  Game _game;

  Screen(this._game);

  void render(CanvasRenderingContext2D context, num frameDelta);
}