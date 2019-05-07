final int numberOfParticle = 500;
final float ceiling = 200;

final float maxSpeed = 1;
final float minSpeed = 1;

final float maxAngle = 60;

final color particleColor = color(255);
final int particleSize = 10;
Particle[] particle = new Particle[numberOfParticle];

final float snowPeriodTime = 20000;
void RainInit(){
  for(int i = 0; i < numberOfParticle; i++){
    particle[i] = new Particle(false);
  }
}
void Rain() {
  for(int i = 0; i < numberOfParticle; i++){
    particle[i].update();
    particle[i].draw();
  }
}

class Particle {
  private float posX = 0;
  private float posY = 0;
  private float speed = 0;
  private float angle = 0;
  private float snowAngle = 0;
  private boolean snow = false;
  private int createdTime = 0;
  
  Particle(boolean s) {
    this.snow = s;
    this.init();
    logd("==============================");
    logd("posX: "+this.posX);
    logd("posY: "+this.posY);
    logd("speed: "+this.speed);
    logd("angle: "+this.angle);
    logd("snowAngle: "+this.snowAngle);
    logd("snow: "+this.snow);
    logd("createdTime: "+this.createdTime);
  }
  
  private void init() {
    this.posX = random(displayWidth);
    this.posY = random(ceiling) * -1;
    this.speed = random(maxSpeed) + minSpeed;
    this.angle = random(maxAngle) - (maxAngle/2);
    if(this.snow == true) snowAngle = this.angle;
    this.createdTime = millis();
  }
  
  public void draw() {
    if(snow == true) {
      noStroke();
      ellipseMode(CENTER);
      fill(particleColor);
      ellipse(this.posX, this.posY, particleSize, particleSize);
    } else {
      strokeWeight(particleSize/5);
      noFill();
      stroke(particleColor);
      line(this.posX, this.posY, this.posX+(sin(this.angle)*this.speed), this.posY+(cos(this.angle)*this.speed));
    }
  }
  public void update() {
    logd("AA");
    if(snow == true) {
      float snowAngleConstant = ((millis() - this.createdTime)%snowPeriodTime)/snowPeriodTime;
      float tempAngle = abs(this.angle);
      float rotationAngle = (tempAngle*4)*snowAngleConstant;
      float negatifOrNot = this.angle > 0 ? 1 : -1;
      logd("snowAngleConstant: "+snowAngleConstant);
      logd("rotationAngle: "+rotationAngle);
      if(rotationAngle < tempAngle) this.snowAngle = negatifOrNot*(tempAngle - rotationAngle);
      else if(rotationAngle >= tempAngle && rotationAngle < tempAngle*2) this.snowAngle = negatifOrNot*(-1 * (rotationAngle - tempAngle));
      else if(rotationAngle >= tempAngle*2 && rotationAngle < tempAngle*3) this.snowAngle = negatifOrNot*(-1*((tempAngle*3) - rotationAngle));
      else if(rotationAngle >= tempAngle*3 && rotationAngle < tempAngle*4) this.snowAngle = negatifOrNot*(rotationAngle - (tempAngle*3));
      this.posX += sin(this.snowAngle)*this.speed;
      this.posY += abs(cos(this.snowAngle))*this.speed;
    } else {
      this.posX += sin(this.angle/2)*this.speed;
      this.posY += abs(cos(this.angle/2))*this.speed;
    }
    if(this.posX > width+100 || 
       this.posX < -100 ||
       this.posY > height+100) {
       this.init();
     }
    
    logd("==============================");
    logd("posX: "+this.posX);
    logd("posY: "+this.posY);
    logd("speed: "+this.speed);
    logd("angle: "+this.angle);
    logd("snowAngle: "+this.snowAngle);
    logd("snow: "+this.snow);
    logd("createdTime: "+this.createdTime);
  }
}

void logd(String str) {
  boolean debug = false;
  
  if(debug == true) println(str);
}
