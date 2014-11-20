part of snake;

class Game {
  static const millisecondsPerUpdate = 16;

  CanvasElement            _canvas;
  int                      width;
  int                      height;
  CanvasRenderingContext2D _context;

  final Set<Element> _loading = new Set<Element>();

  Screen screen;

  num lastTimestamp;

  String _status = "Loading";

  Game(String canvasSelector) {
    _canvas  = querySelector(canvasSelector);
    width    = _canvas.width;
    height   = _canvas.height;
    _context = _canvas.getContext("2d");

    screen = new Menu(this);
  }

  bool isLoading() {
    _status == "Loading";
  }

  void center() {
    var marginToCenter      = ((window.innerHeight - height) / 2).toInt();
    _canvas.style.marginTop = "${marginToCenter}px";
  }

  void loadAsset(Element element) {
    _loading.add(element);
  }

  Future finishLoadingAssets() {
    return
      Future
        .wait(_loading.map((element) => element.onLoad.first))
        .then((_) => _status = "Running");
  }

  void tick([int timestamp]) {
    var elapsed   = lastTimestamp != null ? timestamp - lastTimestamp
                                          : millisecondsPerUpdate;
    lastTimestamp = timestamp;

    while (elapsed >= millisecondsPerUpdate) {
      screen.update();
      elapsed -= millisecondsPerUpdate;
    }

    screen.render(_context, elapsed / millisecondsPerUpdate);

    window.animationFrame.then(tick);
  }
}
