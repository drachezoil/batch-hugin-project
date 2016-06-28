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
String path;
String[] lines;


void setup() {
  size(400, 400);
  cp5 = new ControlP5(this);
  cp5.enableShortcuts();
  myTextarea = cp5.addTextarea("txt")
                  .setPosition(50, 100)
                  .setSize(300, 200)
                  .setFont(createFont("", 10))
                  .setLineHeight(14)
                  .setColor(color(200))
                  .setColorBackground(color(50, 55, 100))
                  .setColorForeground(color(255));
  ;

  console = cp5.addConsole(myTextarea);//
  
  // create a new button
 cp5.addButton("Folder")
     .setPosition(50,30)
     .setSize(100,19)
     .setCaptionLabel("Select pto pattern");
     ;  
  cp5.addButton("Start")
     .setPosition(50,60)
     .setSize(100,19)
     .setCaptionLabel("Start create pto");
     ;  
  cp5.addTextfield("start_index")
     .setPosition(200,40)
     .setSize(70,30)
     .setFocus(true)
     .setInputFilter(ControlP5.INTEGER)
     .setColorCaptionLabel(255)
     .setLabel("start")
     .setFont(createFont("arial",16))
     ;
                 
  cp5.addTextfield("end_index")
     .setPosition(280,40)
     .setSize(70,30)
     .setInputFilter(ControlP5.INTEGER)
     .setColorCaptionLabel(255)
     .setLabel("End")
     .setFont(createFont("arial",16))
     ;
}

void draw() {
  background(240);
}

public void controlEvent(ControlEvent theEvent) {
  println(theEvent.getController().getName());
}

// function 
public void Folder(){
  selectInput("Select a file to process:", "fileSelected");
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
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
  startIndex = int(cp5.get(Textfield.class,"start_index").getText());
  endIndex = int(cp5.get(Textfield.class,"end_index").getText());
  String number ;
  String newPath ;
  String[] tempLines = loadStrings(path);;
  
  for(int i = startIndex; i < endIndex+1; i++) {
    arrayCopy(lines,tempLines);
    number = String.format("%03d", i);
    println(number);
    tempLines[7] = lines[7].replaceAll("xxx", number);
    tempLines[9] = lines[9].replaceAll("xxx", number);
    tempLines[11] = lines[11].replaceAll("xxx", number);
    tempLines[13] = lines[13].replaceAll("xxx", number);
    newPath = path.replaceAll("xxx", number);
    saveStrings(newPath, tempLines);
    println(newPath);
  }
  println("done");
}