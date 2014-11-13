part of snake;

class Game {
  static const MS_PER_UPDATE = 16;

  CanvasElement            _canvas;
  int                      width;
  int                      height;
  CanvasRenderingContext2D _context;

  final Set<Element> _loading = new Set<Element>();

  Screen screen;

  num lastTimestamp;

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

  void tick([int timestamp]) {
    var elapsed   = lastTimestamp != null ? timestamp - lastTimestamp
                                          : MS_PER_UPDATE;
    lastTimestamp = timestamp;

    while (elapsed >= MS_PER_UPDATE) {
      screen.update();
      elapsed -= MS_PER_UPDATE;
    }

    screen.render(_context, elapsed / MS_PER_UPDATE);

    window.animationFrame.then(tick);
  }
}
