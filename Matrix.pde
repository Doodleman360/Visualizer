class Matrix extends Frame {
  ArrayList<float[]> matrix = new ArrayList<float[]>();
  double size = in.bufferSize();
  float space = 25.0f;
  int a = 1;


  Matrix() {
    background(0);
  }

  void frame() {
    background(0);
    colorMode(RGB);
    float[] arr = new float[(int)size/a];
    for (int i = 0; i < size/a - 1; i++) {
      arr[i] = in.mix.get(i*a);
    }
    matrix.add(arr);
    if (matrix.size() > height/space) matrix.remove(0);
    strokeWeight(10);
    for (int row = 0; row < matrix.size(); row++)
      for (double x = 0; x < matrix.get(row).length; x++) {
        float val = matrix.get(row)[(int)x];
        //if (val > 0) {
          stroke(0.0, 255.0, 0.0, Math.abs(val)*255);
        /*} else { 
          stroke(255.0, 0.0, 0.0, -val*255);
        }*/
        point((float)(a*x/size * width), height - (space * row));
      }
    //println(matrix.size());
  }
}