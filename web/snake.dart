import "dart:html";

void main() {
  var canvas  = querySelector("#game");
  var width   = canvas.width;
  var height  = canvas.height;
  var context = canvas.getContext("2d");

  var marginToCenter     = ((window.innerHeight - height) / 2).toInt();
  canvas.style.marginTop = "${marginToCenter}px";

  var background = new ImageElement(src: "images/sand.jpg");
  background.onLoad.listen( (e) {
    context.drawImageScaled(background, 0, 0, width, height);
  } );
}