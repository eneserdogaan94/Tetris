int kareBuyukluk = 22;
int yatayKareNo, dikeyKareNo;
int yatayGenislikY, dikeyGenislikY;

int[][] dolu;
String msg = "";
int syc;
int sycMax = 16;

Parca mParca;

boolean son = false;

void setup() {
  size(1600,900);
  textSize(18);
  yatayKareNo = 12;
  dikeyKareNo = 28;
  
  yatayGenislikY = (1600 / 2) 
    - ((yatayKareNo * kareBuyukluk) / 2);
  
  dikeyGenislikY = (900 / 2)
    - ((dikeyKareNo * kareBuyukluk) / 2);
    
  dolu = new int[yatayKareNo][dikeyKareNo];
  
  for(int i = 0; i < yatayKareNo; i++) {
    for(int j = 0; j < dikeyKareNo; j++) {
      dolu[i][j] = -1;
    }
    
  }
   
}

void satirsil(int y) {
  boolean silcenMi = true;
 
  for(int i = 0; i < yatayKareNo; i++) {
    if(i >= 0 && y >= 0 && i < yatayKareNo && y < dikeyKareNo) {
      if(dolu[i][y] == -1) {
        silcenMi = false;
        return;
      }
    }
  }
  
  if(silcenMi) {
    fill(#90FFA3);
    for(int i = 0; i < yatayKareNo; i++) {
      if(i >= 0 && y >= 0 && i < yatayKareNo && y < dikeyKareNo) {
        dolu[i][y] = -1;
         rect(yatayGenislikY + i * kareBuyukluk,
               dikeyGenislikY + y * kareBuyukluk,
               kareBuyukluk,kareBuyukluk);
      }
    }
    
    for(int i = 0; i < yatayKareNo; i++) {
      for(int j = y; j >= 0; j--) {
        if(dolu[i][j] == 1) {
          dolu[i][j] = -1;
          dolu[i][j+1] = 1;
        }
      }
    }
  }
}

void randParca() {
  if(mParca != null) {
    mParca.doluEkle();
  }
  int r = int(random(0,5));
  mParca = new Parca(yatayKareNo/2,0,r);
}

void keyPressed() {
  if (keyCode == LEFT) {
    if(mParca != null) {
      kayYon = -1;
    }
  } else if (keyCode == RIGHT) {
    if(mParca != null) {
      kayYon = 1;
    }
  } else if (keyCode == UP) {
    if(mParca != null) {
      kayYon = 2;
    }
  }  
}

boolean ilerleAni;
int kayYon = 0;

void draw() {
  
  if(son) {
    background(#985E6D);
    return;
  }
  
  
  syc++;
  
  if(syc > sycMax || (keyPressed && keyCode == DOWN)){
    syc = 0;
    ilerleAni = true;
  } else {
    ilerleAni = false;
  }
  
  background(0);
  
  for(int i = 0; i < yatayKareNo; i++) {
    for(int j = 0; j < dikeyKareNo; j++) {
      if(dolu[i][j] == -1) {
        fill(40);
      } else if(dolu[i][j] == 1) {
        fill(#D88585);
      }
      rect(yatayGenislikY + i * kareBuyukluk,
          dikeyGenislikY + j * kareBuyukluk,
          kareBuyukluk,kareBuyukluk);
    }
  }

  if(mParca != null) {
    if(kayYon != 0) {
      mParca.kay(kayYon);
      kayYon = 0;
    }
  }

  if(ilerleAni) {
    if(mParca != null) {
      
      if(mParca.ilerle()) {

      } else {
        randParca();
        for(int i = 0; i < dikeyKareNo; i++) {
          satirsil(i);
        }
      } 
    } else {
      randParca();
    }
  }

  
  
  if(mParca != null) {
    mParca.ciz();
  }
}

class Parca {
  
  int[] xler;
  int[] yler;
  int kacKare;
  int cev;
  
  public Parca(int basX, int basY, int tur){
    cev = 0;
    
    if(tur == 0) {
      kareParca(basX,basY);
    } else if(tur == 1) {
      lParca(basX,basY);
    } else if(tur == 2) {
      iParca(basX,basY);
    } else if(tur == 3) {
      tParca(basX,basY);
    } else if(tur == 4) {
      zParca(basX,basY);
    } 
  }
  
  void kay( int yon ) {
    if(yon == 0) {
      return;
    } else if(yon == 1) {
      boolean ilerlet = true;
    
      for(int i = 0; i < kacKare; i++){
        int x = xler[i] + 1;
        int y = yler[i];
        
        if(x >= 0 &&  y >= 0 && x < yatayKareNo && y < dikeyKareNo) {
          if(dolu[x][y] != -1) {
            ilerlet = false;
          }
        } else if( x == yatayKareNo) {
          ilerlet = false;
        }
      }
      
      if(ilerlet) {
        for(int i = 0; i < kacKare; i++){
          xler[i] += 1;
        }
      }
      
    } else if(yon == -1) {
      boolean ilerlet = true;
    
      for(int i = 0; i < kacKare; i++){
        int x = xler[i] - 1;
        int y = yler[i];
        
        if(x >= 0 &&  y >= 0 && x < yatayKareNo && y < dikeyKareNo) {
          if(dolu[x][y] != -1) {
            ilerlet = false;
          }
        } else if( x == -1 ) {
          ilerlet = false;
        }
      }
      
      if(ilerlet) {
        for(int i = 0; i < kacKare; i++){
          xler[i] -= 1;
        }
      }
    } else if(yon == 2) {
        cevir();
    }
  }
  
  boolean ilerle() {
    boolean ilerlet = true;
    
    for(int i = 0; i < kacKare; i++){
      int x = xler[i];
      int y = yler[i] + 1;
      
      if(x >= 0 &&  y >= 0 && x < yatayKareNo && y < dikeyKareNo) {
        if(dolu[x][y] != -1) {
          ilerlet = false;
        }
      } else if( y == dikeyKareNo) {
        ilerlet = false;
      }
    }
    
    if(!ilerlet) {
        return false;
    }

    for(int i = 0; i < kacKare; i++){
      yler[i] += 1;
    }
    
    return true;
  }

  void kareParca(int basX, int basY) {
    kacKare = 4;
    
    xler = new int[kacKare];
    yler = new int[kacKare];
    
    xler[0] = basX;
    yler[0] = basY;
    
    xler[1] = basX+1;
    yler[1] = basY;
    
    xler[2] = basX;
    yler[2] = basY+1;
    
    xler[3] = basX+1;
    yler[3] = basY+1;
  }
  
  void zParca(int basX, int basY) {
    kacKare = 4;
    
    xler = new int[kacKare];
    yler = new int[kacKare];
    
    xler[0] = basX;
    yler[0] = basY;
    
    xler[1] = basX+1;
    yler[1] = basY;
    
    xler[2] = basX+1;
    yler[2] = basY+1;
    
    xler[3] = basX+2;
    yler[3] = basY+1;
  }
  
  
  void lParca(int basX, int basY) {
    kacKare = 4;
    
    xler = new int[kacKare];
    yler = new int[kacKare];
    
    xler[0] = basX;
    yler[0] = basY-1;
    
    xler[1] = basX+1;
    yler[1] = basY-1;
    
    xler[2] = basX+1;
    yler[2] = basY;
    
    xler[3] = basX+1;
    yler[3] = basY+1;
  }
  
  void iParca(int basX, int basY) {
    kacKare = 4;
    
    xler = new int[kacKare];
    yler = new int[kacKare];
    
    xler[0] = basX;
    yler[0] = basY;
    
    xler[1] = basX;
    yler[1] = basY-1;
    
    xler[2] = basX;
    yler[2] = basY+2;
    
    xler[3] = basX;
    yler[3] = basY+1;
  }
  
   void tParca(int basX, int basY) {
    kacKare = 4;
    
    xler = new int[kacKare];
    yler = new int[kacKare];
    
    xler[0] = basX;
    yler[0] = basY;
    
    xler[1] = basX;
    yler[1] = basY+1;
    
    xler[2] = basX+1;
    yler[2] = basY+1;
    
    xler[3] = basX-1;
    yler[3] = basY+1;
  }

  void doluEkle() {
    for(int i = 0; i < kacKare; i++){
      if(xler[i] >= 0 && xler[i] < yatayKareNo && yler[i] >= 0 && yler[i] < dikeyKareNo) {
        dolu[xler[i]][yler[i]] = 1;
      } else {
        son = true;
      }
    }
  }
  
  void cevir() {
    int x = xler[0];
    int y = yler[0];
    
    boolean cevirlirMi = true;
    
    for(int i = 0; i < kacKare; i++){
      int xf = xler[i] - x;
      int yf = yler[i] - y;

      if(x + yf < 0 || x + yf >= yatayKareNo || y - xf < 0 || y - xf >= dikeyKareNo) {
        cevirlirMi = false;
      }
    }
    
    if(cevirlirMi) {
      for(int i = 0; i < kacKare; i++){
        int xf = xler[i] - x;
        int yf = yler[i] - y;
        xler[i] = x + yf;
        yler[i] = y - xf;   
      } 
    }
  }
  
  void ciz() {
    fill(#124685);
    
    for(int i = 0; i < kacKare; i++){
      rect(yatayGenislikY + xler[i] * kareBuyukluk,
            dikeyGenislikY + yler[i] * kareBuyukluk,
            kareBuyukluk,kareBuyukluk);
    }
	//eneserdogaan94@gmail.com
	
  }
}
