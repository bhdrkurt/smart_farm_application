#include <AFMotor.h>
#include <Servo.h>
#define light_FR  14    //LED Front Right   pin A0 for Arduino Uno
#define light_FL  15    //LED Front Left    pin A1 for Arduino Uno
#define light_BR  16    //LED Back Right    pin A2 for Arduino Uno
#define light_BL  17    //LED Back Left     pin A3 for Arduino Uno
#define horn_Buzz 18    //Horn Buzzer       pin A4 for Arduino Uno

AF_DCMotor motor1(1);
AF_DCMotor motor2(2);
AF_DCMotor motor3(3);
AF_DCMotor motor4(4);

int command; //Int to store app command state.
int speedCar = 255; // Initial car speed set 0 to 255.
boolean lightFront = false;
boolean lightBack = false;
boolean horn = false;

Servo servo1;
int aci;

void setup()
{
  pinMode(light_FR, OUTPUT);
  pinMode(light_FL, OUTPUT);
  pinMode(light_BR, OUTPUT);
  pinMode(light_BL, OUTPUT);
  pinMode(horn_Buzz, OUTPUT);
  servo1.attach(10);
  servo1.write(90);
  delay(1000);

  Serial.begin(9600);

  Stop();
}
void forward()
{
  motor1.run(FORWARD);
  motor2.run(FORWARD);
  motor3.run(FORWARD);
  motor4.run(FORWARD);
  motor1.setSpeed(speedCar);
  motor2.setSpeed(speedCar);
  motor3.setSpeed(speedCar);
  motor4.setSpeed(speedCar);
}
void backward()
{
  motor1.run(BACKWARD);
  motor2.run(BACKWARD);
  motor3.run(BACKWARD);
  motor4.run(BACKWARD);
  motor1.setSpeed(speedCar);
  motor2.setSpeed(speedCar);
  motor3.setSpeed(speedCar);
  motor4.setSpeed(speedCar);
}
void left()
{
  motor1.run(FORWARD);
  motor2.run(RELEASE);
  motor3.run(RELEASE);
  motor4.run(FORWARD);
  motor1.setSpeed(speedCar);
  motor4.setSpeed(speedCar);
}
void right()
{
  motor1.run(RELEASE);
  motor2.run(FORWARD);
  motor3.run(FORWARD);
  motor4.run(RELEASE);
  motor2.setSpeed(speedCar);
  motor3.setSpeed(speedCar);
}
void Stop()
{
  motor1.run(RELEASE);
  motor2.run(RELEASE);
  motor3.run(RELEASE);
  motor4.run(RELEASE);
}

void servoAc() {
  for (aci = 0; aci <= 45; aci += 15) {
    servo1.write(aci);
    delay(100);
  }
  for (aci = 45; aci >= 0; aci -= 15) {
    servo1.write(aci);
    delay(100);
  }
}
void servoKapat() {
  servo1.write(0);
  delay(100);
}

void loop() {
  if (Serial.available() > 0) {
    command = Serial.read();
    Stop();       //Initialize with motors stopped.

    if (lightFront) {
      digitalWrite(light_FR, HIGH);
      digitalWrite(light_FL, HIGH);
    }
    if (!lightFront) {
      digitalWrite(light_FR, LOW);
      digitalWrite(light_FL, LOW);
    }
    if (lightBack) {
      digitalWrite(light_BR, HIGH);
      digitalWrite(light_BL, HIGH);
    }
    if (!lightBack) {
      digitalWrite(light_BR, LOW); digitalWrite(light_BL, LOW);
    }
    if (horn) {
      digitalWrite(horn_Buzz, HIGH);
    }
    if (!horn) {
      digitalWrite(horn_Buzz, LOW);
    }

    switch (command) {
      case 'w': forward(); break;
      case 's': backward(); break;
      case 'a': left(); break;
      case 'd': right(); break;
      case 'p': Stop(); break;

      case '1': speedCar = 50; break;
      case '2': speedCar = 75; break;
      case '3': speedCar = 100; break;

      case 't': servoAc(); break;
      case 'u': servoKapat(); break;
    }
  }
}
