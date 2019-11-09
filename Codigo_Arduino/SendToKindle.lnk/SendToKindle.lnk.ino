#include "Motor.h"


#define PIN_E 10
#define PIN_IN1 9
#define PIN_IN2 8
#define HALF_ADC_MEAS 512 


#define GANANCIA 2.5

AF_DCMotor motor(4);  // Another way to define

class motorControl {       
  private:             
    float k_w;  //vel
    float k_angle;  //angulo
    int read_w;
    int read_angle;
    int read_output;        
    //s esta entre -255 y 255
    //el modulo de s es el valor pwm y el signo el sentido de giro
    void setSpeedMotor(int s);
   public:
    motorControl(int pinEnable, int pinIn1, int pinIn2,int read_w,int read_angle,int read_output,float k_w,float k_angle);
    void runMotor();
    
      
};

motorControl * tst;


void setup() {
  Serial.begin(9600);
  tst=new motorControl(PIN_E,PIN_IN1,PIN_IN2,A0,A1,A2, -3.9, 2.18);
}

void loop() {
  tst->runMotor();
  delay(1); // delay at 1 second
}






motorControl::motorControl(int pinEnable, int pinIn1, int pinIn2,int read_w,int read_angle,int read_output,float k_w,float k_angle){
  this->k_w=k_w;
  this->k_angle=k_angle;
  this->read_angle=read_angle;
  this->read_w=read_w;
  this->read_output=read_output;
}

void motorControl::runMotor(){
  
  int meas_w=analogRead(read_w)-HALF_ADC_MEAS;
  int meas_output=analogRead(read_output);
  int meas_angle=analogRead(read_angle);
  int error;
  
  meas_output=GANANCIA*(meas_output-HALF_ADC_MEAS);
  meas_angle=map(meas_angle,490,740,0,1023)-HALF_ADC_MEAS;

  error=meas_output-(meas_angle*k_angle)-(meas_w*k_w);  //mido error
  setSpeedMotor(map(error,-512*1.5,512*1.5,-255,255));  //realimento
  
}

void motorControl::setSpeedMotor(int s){
  if(s>255){
    s=255;
  }else if(s<-255){
    s=-255;
  }
  
  if(s<0){
    motor.setSpeed(-s);
    motor.run(FORWARD);    
  }else if(s<256){
    motor.setSpeed(s);
    motor.run(BACKWARD);    
  }
}
