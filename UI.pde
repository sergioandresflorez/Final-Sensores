/*  UI-related functions */

void mousePressed()
{
  //keyboard button -- toggle virtual keyboard
  if (mouseY <= 50 && mouseX > 0 && mouseX < width/3)
    KetaiKeyboard.toggle(this);
  else if (mouseY <= 50 && mouseX > width/3 && mouseX < 2*(width/3)) //config button
  {
    isConfiguring=true;
  } else if (mouseY <= 50 && mouseX >  2*(width/3) && mouseX < width) // draw button
  {
    if (isConfiguring)
    {
      //if we're entering draw mode then clear canvas
      background(78, 93, 75);
      isConfiguring=false;
    }
  }
}

void mouseDragged()
{
  if (isConfiguring)
    return;

  //send data to everyone
  //  we could send to a specific device through
  //   the writeToDevice(String _devName, byte[] data)
  //  method

  textSize(24);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);

  //Apagar
  if (mousePressed && mouseX < (width/2)+75 && mouseX > ((width/2)-75)&& mouseY < (height/2)+75 && mouseY > ((height/2)-75)) {
    stroke(20);
    strokeWeight(4);
    fill(111, 235, 129);
    rect(width/2, height/2, 150, 150);
    vel_A = 0;
    dir_A = 0; 
    vel_B = 0;
    dir_B = 0;
    fill(100);
    text("Apagar", width/2, height/2);
  }  
  //Adelante
  if (mousePressed && mouseX < (width/2)+75 && mouseX > ((width/2)-75)&& mouseY < (height/4)+75 && mouseY > ((height/4)-75)) {
    stroke(20);
    strokeWeight(4);
    fill(111, 235, 129);
    rect(width/2, height/4, 150, 150);
    vel_A = 255;
    dir_A = 1; 
    vel_B = 255;
    dir_B = 1;
    fill(100);
    text("Adelante", width/2, height/4);
  }  
  //Atrás
  if (mousePressed && mouseX < (width/2)+75 && mouseX > ((width/2)-75)&& mouseY < ((height/4)*3)+75 && mouseY > ((height/4)*3)-75) {
    stroke(20);
    strokeWeight(4);
    fill(111, 235, 129);
    rect(width/2, (height/4)*3, 150, 150);
    vel_A = 255;
    dir_A = 0; 
    vel_B = 255;
    dir_B = 0;
    fill(100);
    text("Atrás", width/2, (height/4)*3);
  }
  //Izquierda
  if (mousePressed && mouseX < (width/4)+75 && mouseX > (width/4)-75&& mouseY < (height/3)+75 && mouseY > (height/3)-75) {
    stroke(20);
    strokeWeight(4);
    fill(111, 235, 129);
    rect(width/4, height/4, 150, 150);
    vel_A = 255;
    dir_A = 0; 
    vel_B = 0;
    dir_B = 0;
    fill(100);
    text("Izquierda", width/4, height/4);
  }
  //Derecha
  if (mousePressed && mouseX < ((width/4)*3)+75 && mouseX > ((width/4)*3)-75&& mouseY < (height/3)+75 && mouseY > (height/3)-75) {
    stroke(20);
    strokeWeight(4);
    fill(111, 235, 129);
    rect((width/4)*3, height/4, 150, 150);
    vel_A = 0;
    dir_A = 0; 
    vel_B = 255;
    dir_B = 0;
    fill(100);
    text("Derecha", (width/4)*3, height/4);
  }
  //Izquierda giro
  if (mousePressed && mouseX < (width/4)+75 && mouseX > (width/4)-75&& mouseY < ((height/4)*3)+75 && mouseY > ((height/4)*3)-75) {
    stroke(20);
    strokeWeight(4);
    fill(111, 235, 129);
    rect(width/4, (height/4)*3, 150, 150);
    vel_A = 255;
    dir_A = 1; 
    vel_B = 255;
    dir_B = 0;
    fill(100);
    text("Giro I", width/4, (height/4)*3);
  }
  //Derecha giro
  if (mousePressed && mouseX < ((width/4)*3)+75 && mouseX > ((width/4)*3)-75&& mouseY < ((height/4)*3)+75 && mouseY > ((height/4)*3)-75) {
    stroke(20);
    strokeWeight(4);
    fill(111, 235, 129);
    rect((width/4)*3, (height/4)*3, 150, 150);
    vel_A = 255;
    dir_A = 0; 
    vel_B = 255;
    dir_B = 1;
  }

  String data = "*"+String.valueOf(int(vel_A))+","+String.valueOf(int(dir_A))+","+String.valueOf(int(vel_B))+","+String.valueOf(int(dir_B))+"&";

  bt.broadcast(data.getBytes());
}

public void keyPressed() {
  if (key =='c')
  {
    //If we have not discovered any devices, try prior paired devices
    if (bt.getDiscoveredDeviceNames().size() > 0)
      klist = new KetaiList(this, bt.getDiscoveredDeviceNames());
    else if (bt.getPairedDeviceNames().size() > 0)
      klist = new KetaiList(this, bt.getPairedDeviceNames());
  } else if (key == 'd')
  {
    bt.discoverDevices();
  } else if (key == 'x')
    bt.stop();
  else if (key == 'b')
  {
    bt.makeDiscoverable();
  } else if (key == 's')
  {
    bt.start();
  }
}


void drawUI()
{
  //Draw top shelf UI buttons

  pushStyle();
  fill(0);
  stroke(255);
  rect(0, 0, width/3, 50);

  if (isConfiguring)
  {
    noStroke();
    fill(78, 93, 75);
  } else
    fill(0);

  rect(width/3, 0, width/3, 50);

  if (!isConfiguring)
  {  
    noStroke();
    fill(78, 93, 75);
  } else
  {
    fill(0);
    stroke(255);
  }
  rect((width/3)*2, 0, width/3, 50);

  fill(255);
  text("Keyboard", 5, 30); 
  text("Bluetooth", width/3+5, 30); 
  text("Interact", width/3*2+5, 30); 


  popStyle();
}

void onKetaiListSelection(KetaiList klist)
{
  String selection = klist.getSelection();
  bt.connectToDeviceByName(selection);

  //dispose of list for now
  klist = null;
}