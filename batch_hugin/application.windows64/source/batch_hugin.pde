/**
 * batch hugin. 
 *
 * 
 */

import controlP5.*;
import java.util.*;

ControlP5 cp5;
Textarea myTextarea;
Println console;
int startIndex= 0;
int endIndex = 0;
int nbrcam =0;
String path = null;
String[] lines;


void setup() {
  size(400, 400);
  cp5 = new ControlP5(this);
  cp5.enableShortcuts();
  myTextarea = cp5.addTextarea("txt")
                  .setPosition(30, 100)
                  .setSize(320, 280)
                  .setFont(createFont("", 10))
                  .setLineHeight(14)
                  .setColor(color(200))
                  .setColorBackground(color(50, 55, 100))
                  .setColorForeground(color(255));
  ;

  console = cp5.addConsole(myTextarea);//
  
  // create a new button
 cp5.addButton("Folder")
     .setPosition(30,30)
     .setSize(100,19)
     .setCaptionLabel("Select pto pattern");
     ;  
  cp5.addButton("Start")
     .setPosition(30,60)
     .setSize(100,19)
     .setCaptionLabel("Start create pto");
     ;  
  cp5.addTextfield("start_index")
     .setPosition(150,30)
     .setSize(50,20)
     .setFocus(true)
     .setInputFilter(ControlP5.INTEGER)
     .setColorCaptionLabel(255)
     .setLabel("start")
     .setFont(createFont("arial",12))
     ;
                 
  cp5.addTextfield("end_index")
     .setPosition(230,30)
     .setSize(50,20)
     .setInputFilter(ControlP5.INTEGER)
     .setColorCaptionLabel(255)
     .setLabel("End")
     .setFont(createFont("arial",12))
     ;
     
  cp5.addTextfield("nbr_camera")
     .setPosition(300,30)
     .setSize(50,20)
     .setInputFilter(ControlP5.INTEGER)
     .setColorCaptionLabel(255)
     .setLabel("Img per set")
     .setFont(createFont("arial",12))
     ;
     
  println("1. Select the path of your pto pattern (you have replace the name of each picture by 0001, 0002, 0003, ...)");
  println("2. Enter the number of the first and the last index of image set you want to process");
  println("3. Select the number of picture you have in one set(nbr of camera)");
  println("4. Hit Start");
}

void draw() {
  background(240);
  ellipse(370 ,350,15,15);
}

public void controlEvent(ControlEvent theEvent) {
  //println(theEvent.getController().getName());
}

// function 
public void Folder(){
  selectInput("Select the pto pattern:", "fileSelected");
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel. Please reload the pto.");
  } else {
    path = selection.getAbsolutePath();
    println("User selected " + path);
    lines = loadStrings(path);
    println("there are " + lines.length + " lines");
    //println(lines);
  }
}


// function 
public void Start(){
  String number ;
  String newPath ;
  String[] tempLines = {};
  
  if (path == null){
    println("Failed to load the pto...");
  }
  else{
    tempLines = loadStrings(path);
    startIndex = int(cp5.get(Textfield.class,"start_index").getText());
    endIndex = int(cp5.get(Textfield.class,"end_index").getText());
    nbrcam = int(cp5.get(Textfield.class,"nbr_camera").getText());
    if(startIndex>=endIndex && nbrcam==0){
      println("You haven't enter the index or they are in the wrong order");
    }
    else{
      println("Start");
      for(int i = startIndex; i < endIndex+1; i++) {
        arrayCopy(lines,tempLines);
        number = String.format("%04d", i);
        println(number);
        for(int j = 0; j < (nbrcam*2); j+=2){
          tempLines[j+7] = tempLines[j+7].replaceAll("abcd", number);  //1abcde
        }
        newPath = path.replaceAll("xxxx", number);
        saveStrings(newPath, tempLines);
        println(newPath);
      }
      println("done");
      fill(#00FF00);
    }
  }
}