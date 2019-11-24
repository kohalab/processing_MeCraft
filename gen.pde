int get_map(int i,int f,int z){
  int t = 0;
  if (noise(i/8.0, f/8.0, z/8.0) < (f/32.0)-0.04) {
    t = 1;
  }
  return t;
}
