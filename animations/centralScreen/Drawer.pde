class Drawer {

  private color colour;
  ArrayList<ColoredShape> shapesList;
  private int maxLife;

  Drawer() {
    this.shapesList = new ArrayList<ColoredShape>();
    this.colour = color(255, 204, 0);
    this.maxLife = FRAMERATE * 4;   // framerate * lifespan in seconds
  }

  public void setColor(float[] prob) {
    int idxMax = 0;
    for(int i=1; i<prob.length; i++){
      if(prob[i]>prob[idxMax]) idxMax = i;
    }
    this.colour = c[idxMax];
    println(idxMax);
  };

  public void action() {
    if (mousePressed) {
      // consider mouse only if is inside the image
      if (isInside()) {
        int lastIdx = shapesList.size()-1;
        if (shapesList.size() == 0 || dist(mouseX, mouseY, shapesList.get(lastIdx).pos.x, shapesList.get(lastIdx).pos.y) > 6) {
          ColoredShape newShape = new ColoredShape(new PVector(mouseX, mouseY), this.maxLife, this.colour);
          shapesList.add(newShape);
        }
      }
      //println(shapesList.size());
    }
    ArrayList<ColoredShape> removable = new ArrayList<ColoredShape>();
    for (ColoredShape shape : shapesList) {
      shape.drawShape();
      if (shape.isDead()) removable.add(shape);
    }
    for (ColoredShape shape : removable) {
      shapesList.remove(shape);
    }
  }

  private boolean isInside() {
    if (borderSx <= mouseX && mouseX <= borderDx) return true;
    else return false;
  }
}
