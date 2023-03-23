//incorperating mouse driven camera
import peasy.*;
PeasyCam camera;
import controlP5.*;
ControlP5 cp5;

//establishing time, switch variable, and algorithm variables
float time = 0;
int Attractors = 0;


//intializing Leaf Arraylist
ArrayList<Leaf> babyLeaves = new ArrayList<Leaf>();

//setting background color and program screen size
void setup()
{
size(1920,1080,P3D);
  camera = new PeasyCam(this, 0, 0, 0, 50);
  
  //Setting up Sliders
  cp5 = new ControlP5(this);
  cp5.setAutoDraw(false);
  
  cp5.addSlider("Attractors")
   .setPosition(0,0)
   .setSize(400,50)
   .setValue(0)
   .setRange(0,5)
   .setColorBackground(color(0,0,255))
   .setColorForeground(color(255,0,0))
   .setColorValue(color(255,255,255))
   .setColorActive(color(0,255,0))
   ;
   
  //using for loop to initialize Leaf objects
  for(int i = 0; i < 20000; i++)
  {
    //creating random coordinate values to flow into the algorithm
    PVector randomPVector = new PVector(random(-50,50),random(-50,50),random(-50,50));
    //adding to the array list 
   babyLeaves.add(new Leaf(randomPVector));
  }
  
}
//runs everyframe
void draw()
{
background(0);
time += 0.1;
mousePressed();
  //displays array everyframe
  for(int i = 0; i < babyLeaves.size(); i++)
  {
   babyLeaves.get(i).display();
  }
    //runs objects through algorithm every frame
    for(int i = 0; i < babyLeaves.size(); i++)
  {
   babyLeaves.get(i).update();
  }
   camera.beginHUD();
   cp5.draw();
   camera.endHUD();
}
class Leaf
{
  //defines position
  PVector position = new PVector(0,0,0);
  PVector buffer = position;
  PVector velocity = new PVector(0,0,0);
  float scale = 1;
  //random coords passed into position given to each object through constructor
  Leaf(PVector positionIn)
  {  
    position = positionIn;
  }
  //passes coords through algoritm
  void update()
  {
     switch(Attractors)
     {
    case 1:
  position = Lorenz(position);
  scale = 1;
  break;
      case 2:
  position = Rossler(position);
  scale = 1;
  break;   
      case 3:
  position = Henon(position);
  scale = 20;
  break;
      case 4:
  position = JohnBrown(position);
  scale = 10;
  break;
      case 5:
  position = LuChen(position);
  scale = 1;
  break;
  //    case 6:
  //position = ModdifiedLuChen(position);
  //scale = 1;
  //break;
  //    case 7:
  //position = ModdifiedChua(position);
  //scale = 1;
  //break;
  //    case 8:
  //position = Duffing(position);
  //scale = 1;
  //break;
  //case 9:
  //position = ModdifiedLorenz(position);
  //scale = 10;
  //break;
        default:
  position = Chen(position);
 scale = 1;
  break;
     }
    
    //Defines velocity so colors change depening on it
  velocity = PVector.sub(position, buffer);
  buffer.set(position.x, position.y, position.z); 
  velocity.normalize(); 
  velocity.mult(128);
  velocity.add(new PVector(128,128,128));
  }
  //display data function and colors
   void display()
  {
    
    stroke(velocity.x, velocity.y, velocity.z);
    point(position.x*scale,position.y*scale, position.z*scale);
    
    strokeWeight(1);
  }
}


//defines all the Attractors
PVector Lorenz(PVector position)
{
    float A = 10; 
    float B = 8.0/3.0;
    float C = 28;

    float deltaX = A*(position.y - position.x);
    float deltaY = position.x*(C - position.z)- position.y;
    float deltaZ = position.x*position.y - B*position.z;
    
    PVector deltaVector = new PVector(deltaX, deltaY, deltaZ);

    //manages speed and scope of objects
    //deltaVector.normalize();
    deltaVector.mult(.01);
    //shifts coords by output of algorithm
    position.add(deltaVector);
    return position;
}
PVector Rossler(PVector position)
{
    float A = 0.2;
    float B = 0.2;
    float C = 5.7;
    
    float deltaX = (-position.y - position.z);
    float deltaY = position.x + (A*position.y);
    float deltaZ = B+position.z*(position.x - C);
    
    PVector deltaVector = new PVector(deltaX, deltaY, deltaZ);
 
    //manages speed and scope of objects
    //deltaVector.normalize();
    deltaVector.mult(.01);
    //shifts coords by output of algorithm
    position.add(deltaVector);
    return position;
}
PVector Henon(PVector position)
{    
    float A = 1.4;
    float B = 0.3;
    float deltaX = 1-A*position.x*position.x + position.y;
    float deltaY = B*position.x;
    
    PVector deltaVector = new PVector(deltaX, deltaY, 0);
 
    //manages speed and scope of objects
    //deltaVector.normalize();
    //deltaVector.mult(.01);
    //shifts coords by output of algorithm
    //position.add(deltaVector);
    return deltaVector;
}
PVector JohnBrown(PVector position)
{
    float A = 1;
    float B = 1;
    float C = 1;
    float deltaX = A*(position.y - position.x);
    float deltaY = (C-A)*position.x - position.x*position.z + C*position.y;
    float deltaZ =position.x*(position.y - B*position.z);  
  
    PVector deltaVector = new PVector(deltaX, deltaY, deltaZ);
 
    //manages speed and scope of objects
    //deltaVector.normalize();
    deltaVector.mult(.01);
    //shifts coords by output of algorithm
    position.add(deltaVector);
    return position;
}
PVector LuChen(PVector position)
{ 
    float A = 36.0;
    float B = 3.0;
    float C = 20.0;
    float D = -15.15;
    float deltaX = A*(position.y - position.x);
    float deltaY = position.x - position.x*position.z + C*position.y + D;
    float deltaZ = position.x*position.y - B*position.z;
    
    PVector deltaVector = new PVector(deltaX, deltaY, deltaZ);
 
    //manages speed and scope of objects
    //deltaVector.normalize();
    deltaVector.mult(.01);
    //shifts coords by output of algorithm
    position.add(deltaVector);
    return position;
}
PVector Chen(PVector position)
{
    float A = 40.0;
    float B = 3.0;
    float C = 28.0;
    float deltaX = A*(position.y - position.x);
    float deltaY = (C-A)*position.x - position.x*position.z + C*position.y;
    float deltaZ =position.x*position.y - B*position.z;  
  
    PVector deltaVector = new PVector(deltaX, deltaY, deltaZ);
 
    //manages speed and scope of objects
    //deltaVector.normalize();
    deltaVector.mult(.001);
    //shifts coords by output of algorithm
    position.add(deltaVector);
    return position;
}
//PVector ModdifiedLuChen(PVector position)
//{    
//    float A = 0.2;
//    float B = 0.2;
//    float C = 5.7;
//    float deltaX = A*(position.y - position.x);
//    float deltaY = position.x  (A*position.y);
//    float deltaZ = B+position.z*(position.x - C);
    
//    PVector deltaVector = new PVector(deltaX, deltaY, deltaZ);
 
//    //manages speed and scope of objects
//    //deltaVector.normalize();
//    deltaVector.mult(.01);
//    //shifts coords by output of algorithm
//    position.add(deltaVector);
//    return position;
//}
//PVector ModdifiedChua(PVector position)
//{
//    float A = 0.2;
//    float B = 0.2;
//    float C = 5.7;
//    float deltaX = (-position.y - position.z);
//    float deltaY = position.x + (A*position.y);
//    float deltaZ = B+position.z*(position.x - C);
    
//    PVector deltaVector = new PVector(deltaX, deltaY, deltaZ);
 
//    //manages speed and scope of objects
//    //deltaVector.normalize();
//    deltaVector.mult(.01);
//    //shifts coords by output of algorithm
//    position.add(deltaVector);
//    return position;
//}
//PVector Duffing(PVector position)
//{
//    float A = 0.2;
//    float B = 0.2;
//    float C = 5.7;
//    float deltaX = (-position.y - position.z);
//    float deltaY = position.x + (A*position.y);
//    float deltaZ = B+position.z*(position.x - C);
    
//    PVector deltaVector = new PVector(deltaX, deltaY, deltaZ);
 
//    //manages speed and scope of objects
//    //deltaVector.normalize();
//    deltaVector.mult(.01);
//    //shifts coords by output of algorithm
//    position.add(deltaVector);
//    return position;
//}
//PVector ModdifiedLorenz(PVector position)
//{
//    float A = 0.2;
//    float B = 0.2;
//    float C = 5.7;
//    float deltaX = (-position.y - position.z);
//    float deltaY = position.x + (A*position.y);
//    float deltaZ = B+position.z*(position.x - C);
    
//    PVector deltaVector = new PVector(deltaX, deltaY, deltaZ);
 
//    //manages speed and scope of objects
//    //deltaVector.normalize();
//    deltaVector.mult(.01);
//    //shifts coords by output of algorithm
//    position.add(deltaVector);
//    return position;
//}

//Stops rotation while using slider
void mousePressed(){
 if(mouseButton == LEFT)
 {
  if (mouseX < 400 &&  mouseY < 50)
 {
    camera.setActive(false);
  } else {
    camera.setActive(true);
  }
 }
 //lets RightMouse Re-instantiate
 else if(mouseButton == RIGHT)
 {
 for(int i = 0; i < 20000; i++)
  {
    //creating random coordinate values to flow into the algorithm
    PVector randomPVector = new PVector(random(-50,50),random(-50,50),random(-50,50));
    //adding to the array list 
   babyLeaves.get(i).position = randomPVector;
  }
 }
}
