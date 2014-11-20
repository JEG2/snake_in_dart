part of snake;

class Menu extends Screen {
  static const Map<int, int> keys = const {69: 2, 72: 4};

  static final ImageElement _background =
    new ImageElement(src: "images/menu.png");

  Menu(_game) : super(_game) {
    _game.loadAsset(_background);
    _processInput();
  }

  void render(CanvasRenderingContext2D context, num frameDelta) {
    context.drawImageScaled(_background, 0, 0, _game.width, _game.height);
    super.render(context, frameDelta);
  }

  void _processInput() {
    window.onKeyDown.listen( (event) {
      var difficulty = keys[event.keyCode];
      if (difficulty != null) {
        _game.screen = new Level(_game, difficulty);
      }
    } );
  }
}
