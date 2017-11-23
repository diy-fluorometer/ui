import processing.serial.*;
import java.util.regex.*;

int[] numbers = new int[800];
Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port

void setup(){
  size(800,800);
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n'); 
}

void draw(){
  background(255);
  stroke(0);
  beginShape();
  for(int i = 0; i<numbers.length;i++){
    vertex(i,350-numbers[i]);
  }
  endShape();
}

void serialEvent( Serial myPort) {
  //put the incoming data into a String - 
  //the '\n' is our end delimiter indicating the end of a complete packet
  val = myPort.readStringUntil('\n');
  //val.trim();
  Pattern p = Pattern.compile("[^0-9]",
            Pattern.DOTALL | Pattern.CASE_INSENSITIVE);
  val = p.matcher(val).replaceAll("");
  int luxVal = 0;
    try {
      luxVal = Integer.valueOf(val);
    } catch (NumberFormatException e) {
      println("exception thrown" + e.getMessage());
      luxVal = 0;
    }
  println(luxVal);
  for(int i = 1; i<numbers.length;i++){
    numbers[i-1] = numbers[i];
  }
  numbers[numbers.length-1] = luxVal * 2;
}