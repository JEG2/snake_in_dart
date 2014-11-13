part of snake;

class Game {
  CanvasElement            _canvas;
  int                      width;
  int                      height;
  CanvasRenderingContext2D _context;

  List<Element> _loading = new List<Element>();

  Screen screen;

  Game(String canvasSelector) {
    _canvas  = querySelector(canvasSelector);
    width    = _canvas.width;
    height   = _canvas.height;
    _context = _canvas.getContext("2d");

    screen = new Level(this);
  }

  void center() {
    var marginToCenter      = ((window.innerHeight - height) / 2).toInt();
    _canvas.style.marginTop = "${marginToCenter}px";
  }

  void loadAsset(Element element) {
    _loading.add(element);
  }

  Future finishLoadingAssets() {
    return Future.wait(_loading.map((element) => element.onLoad.first));
  }

  void tick([int delta = 0]) {
    screen.render(_context, delta);

    window.animationFrame.then(tick);
  }
}
