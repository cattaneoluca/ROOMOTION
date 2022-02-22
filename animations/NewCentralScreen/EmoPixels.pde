class EmoPixels{
  
  
  PImage art;
  boolean emoReceived = false;
  
  int counter;
  
  // emotions probabilities
  float p1, p2, p3, p4;
  float probs[] = {p1, p2, p3, p4};
  
  color c1, c2, c3, c4;
  color [] c = {c1, c2, c3, c4};
  
  // color associated to the predominant emotion
  color emo;
  
  EmoPixels(){
    //red for angry
    this.c1 = color(180, 30, 0);
    //yellow for happy
    this.c2 = color(255, 204, 0);
    //cyan for neutral
    this.c3 = color(0,200,200);
    //blue for sad
    this.c4 = color(0, 75, 150);
    this.c[0] = c1;
    this.c[1] = c2;
    this.c[2] = c3;
    this.c[3] = c4;
    
    // Probabilities associated to the emotions
      // angry
    this.p1=0;
      // happy
    this.p2=0;
      // neutral
    this.p3=0;
      // sad
    this.p4=0;
  }
  
  void currentArt(PImage art){
    PImage myart = art.get();
    image(myart, width/2, height/2);
    imageMode(CENTER);
  }
  
  // retreives the predominant emotion
  void retreivedEmo(){
    float d = max(probs);
    
    for (int i=0; i<4; i++){
      if (probs[i]==d){
        this.emo = c[i];
    }
  }
    
  }
  
  // checks whether emotions are received
  boolean receivedEmo(){
    float threshold = 0.5;
    
    if (this.p1+this.p2+this.p3+this.p4 > threshold){
      emoReceived = true;
    }
    return emoReceived;
  }
  
  // creates the shinning effect on the art work
  PImage emotiveArt(PImage art){
    this.art = art.get();
    
    PImage newArt = this.art;
    
    emoReceived = receivedEmo();
    
    if (emoReceived==true){
      newArt = transformed(this.art);
      newArt.loadPixels();
      this.counter = int(random(1, 2000));
      for (int x = 0; x < this.counter; x++){
          
          int i = int(random(1, newArt.width-1));
          int j = int(random(1, newArt.height-1));
          color pix = newArt.pixels[index(newArt, i, j)];
          //random shade of gray
          
          float newArtR = red(pix);
          float newArtG = green(pix);
          float newArtB = blue(pix);
          float avg = (newArtR + newArtG + newArtB)/3;
          
          //newArt.pixels[index(newArt, x, y)] = color(avg, avg, avg);
          
          pix = color(avg, avg, avg);
          
          retreivedEmo();
          color from = this.emo;
          color to = color(255, 255, 255);
          
          float percent = pix/to;
          
          //fill(lerpColor(from, to, percent));
          //ellipse(i, j, 5, 5);
          
         newArt.pixels[index(newArt, i, j)] = lerpColor(from, to, percent);
          
         
      }
      newArt.updatePixels();
    }
    
    
    return newArt;
  }
  
  // finds index of a pixel inside the image
  int index (PImage img, int x, int y){
  return x + y * img.width;
  }
  
  
  // Floyd - Steinberg dithering algorithm 
  PImage transformed (PImage switched) {
    PImage art = switched.get();
  
    art.loadPixels();
  
    for (int x = 1; x < art.width - 1; x++){
      for (int y = 0; y < art.height - 1; y++){
        
        color pix = art.pixels[index(art, x, y)];
      
        float oldR = red(pix);
        float oldG = green(pix);
        float oldB = blue(pix);
      
        int factor = 1;
        int newR = round(factor * oldR / 255) * (255/factor);
        int newG = round(factor * oldG / 255) * (255/factor);
        int newB = round(factor * oldB / 255) * (255/factor);
      
        art.pixels[index(art, x, y)] = color(newR, newG, newB);
      
        float errR = oldR - newR;
        float errG = oldG - newG;
        float errB = oldB - newB;
      
      
        int index = index(art, x+1, y  );
        color c = art.pixels[index];
        float r = red(c);
        float g = green(c);
        float b = blue(c);
        r = r + errR * 7/16.0;
        g = g + errG * 7/16.0;
        b = b + errB * 7/16.0;
        art.pixels[index] = color(r, g, b);
      
      
      index = index(art, x-1, y+1);
      c = art.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + errR * 3/16.0;
      g = g + errG * 3/16.0;
      b = b + errB * 3/16.0;
      art.pixels[index] = color(r, g, b);
      
      

      index = index(art, x  , y+1);
      c = art.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + errR * 5/16.0;
      g = g + errG * 5/16.0;
      b = b + errB * 5/16.0;
      art.pixels[index] = color(r, g, b);
      
      
      
      index = index(art, x+1, y+1);
      c = art.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + errR * 1/16.0;
      g = g + errG * 1/16.0;
      b = b + errB * 1/16.0;
      art.pixels[index] = color(r, g, b);
      
    }
  }
  art.updatePixels();
  
  return art;
  }

}
