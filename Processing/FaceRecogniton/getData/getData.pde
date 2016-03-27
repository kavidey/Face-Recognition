import gab.opencv.*;
import processing.video.*;
import java.awt.*;

PrintWriter output;
Capture video;
OpenCV opencv;
float rex;
float rey;
float rew;
float reh;
float lex;
float ley;
float lew;
float leh;
float x;
float y;
float w;
float h;
String data;

void setup() {
  size(640, 480);
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);

  video.start();
  output = createWriter("data.txt"); 
}

void draw() {
  scale(2);
  opencv.loadImage(video);

  image(video, 0, 0 );

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  Rectangle[] faces = opencv.detect();
  println(faces.length);

  for (int i = 0; i < faces.length; i++) {
    x=faces[i].x;
    y=faces[i].y;
    w=faces[i].width;
    h=faces[i].height;
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
  stroke(0, 0, 255);
  opencv.loadCascade(OpenCV.CASCADE_EYE);
  Rectangle[] eyes = opencv.detect();
  for (int i = 0; i < eyes.length; i++) {
    if(eyes.length == 2){
      println(eyes[1].x+","+eyes[0].x);
      if(eyes[0].x>eyes[1].x){
        lex=eyes[0].x;
        ley=eyes[0].y;
        lew=eyes[0].width;
        leh=eyes[0].height;
        rex=eyes[1].x;
        rey=eyes[1].y;
        rew=eyes[1].width;
        reh=eyes[1].height;
      }
      else{
        rex=eyes[0].x;
        rey=eyes[0].y;
        rew=eyes[0].width;
        reh=eyes[0].height;
        lex=eyes[1].x;
        ley=eyes[1].y;
        lew=eyes[1].width;
        leh=eyes[1].height;
      }   
        rect(eyes[1].x, eyes[1].y, eyes[1].width, eyes[1].height);
        rect(eyes[0].x, eyes[0].y, eyes[0].width, eyes[0].height);
    }
      else{
        rect(eyes[i].x, eyes[i].y, eyes[i].width, eyes[i].height);
      }
    }
  
  if((faces.length == 1) && (eyes.length == 2)){
    data = (w/((rew+lew)/2))+","+(h/((reh+leh)/2))+","+(abs((lex+lew)-lex)/leh)+","+(abs((rex+rew)-rex)/reh)+","+((lew*leh)+(rew*reh)/w*h)+","+(abs(rex-(lex+lew))/w*h);
    output.println(data);
  }
}

void captureEvent(Capture c) {
  c.read();
}

void keyPressed() {
  output.flush(); 
  output.close(); 
  exit(); 
}