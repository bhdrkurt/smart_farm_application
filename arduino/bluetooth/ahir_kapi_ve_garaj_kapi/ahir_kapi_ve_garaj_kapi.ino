#include <SoftwareSerial.h>

#define rxPin 2
#define txPin 3
SoftwareSerial BTSerial(rxPin, txPin);
int hiz =  180;
int durmahiz = 0;

/* motor sürücüsüne bağlanacak INPUT ve ENABLE pinleri belirleniyor */
const int sagileri = 9;
const int saggeri = 8;
const int solileri = 12;
const int solgeri = 13;
const int solenable = 6;
const int sagenable = 10;

bool flag = false;
bool flag1 = false;

bool flag2 = false;
bool flag3 = false;

char tus;

void setup() {
  /* Bluetooth için port açılıyor */
  pinMode(9, OUTPUT);
  pinMode(sagileri, OUTPUT);
  pinMode(saggeri, OUTPUT);
  pinMode(solileri, OUTPUT);
  pinMode(solgeri, OUTPUT);
  pinMode(sagenable, OUTPUT);
  pinMode(solenable, OUTPUT);
  pinMode(rxPin, INPUT);
  pinMode(txPin, OUTPUT);
  BTSerial.begin(38400);

}

void ahirAc() {
  analogWrite(solenable, hiz);
  digitalWrite(solileri, HIGH);
  digitalWrite(solgeri, LOW);
}
void ahirKapat() {
  analogWrite(solenable, hiz);
  digitalWrite(solileri, LOW);
  digitalWrite(solgeri, HIGH);
}
void ahirDur() {
  digitalWrite(solileri, LOW);
  digitalWrite(solgeri, LOW);
}

void garajAc() {
  analogWrite(sagenable, hiz);
  digitalWrite(sagileri, HIGH);
  digitalWrite(saggeri, LOW);
}
void garajKapat() {
  analogWrite(sagenable, hiz);
  digitalWrite(sagileri, LOW);
  digitalWrite(saggeri, HIGH);
}

unsigned long eskiZaman = 0;
unsigned long yeniZaman;
void loop() {
  if (BTSerial.available() > 0) {   /*Bluetooth’tan veri bekliyoruz */
    tus = (char)BTSerial.read();
  }
  if (tus == 'o') {
    if (flag2 == false) {
      ahirAc();
      flag2 = true;
      yeniZaman = millis();
    }
    if (flag2 == true && millis() - yeniZaman >= 1000) {
      digitalWrite(solileri, HIGH);
      digitalWrite(solgeri, HIGH);
      flag3 = false;
    }
  }

  else if (tus == 'c') {
    if (flag3 == false) {
      ahirKapat();
      flag3 = true;
      yeniZaman = millis();
    }
    if (flag3 == true && millis() - yeniZaman >= 1000) {

      digitalWrite(solileri, HIGH);
      digitalWrite(solgeri, HIGH);
      flag2 = false;
    }
  }
  else if (tus == 'A') {
    if (flag == false) {
      garajAc();
      flag = true;
      yeniZaman = millis();
    }
    if (flag == true && millis() - yeniZaman >= 1000) {
      digitalWrite(sagileri, HIGH);
      digitalWrite(saggeri, HIGH);
      flag1 = false;
    }
  }
  else if (tus == 'K') {
    if (flag1 == false) {
      garajKapat();
      flag1 = true;
      yeniZaman = millis();
    }
    if (flag1 == true && millis() - yeniZaman >= 1000) {
      digitalWrite(sagileri, HIGH);
      digitalWrite(saggeri, HIGH);
      flag = false;
    }
  }
  else if (flag1 == true || flag == true) {
    digitalWrite(sagileri, HIGH);
    digitalWrite(saggeri, HIGH);
  }

  else if (flag2 == true || flag3 == true) {
    digitalWrite(solileri, HIGH);
    digitalWrite(solgeri, HIGH);
  }
}
