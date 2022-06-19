#include <ESP8266WiFi.h>
#include <DHT.h>
#include "FirebaseESP8266.h"

//1. Firebase veritabanı adresini, Token bilgisini ve ağ adresi bilgilerinizi giriniz.

#define WIFI_SSID "bhdrkurt"
#define WIFI_PASSWORD "35973597"
#define FIREBASE_HOST "bitirme-project-cced3-default-rtdb.firebaseio.com"
#define FIREBASE_AUTH "f0piNl1QF7DmTH81qXIhMIHTrMtqvPqAVw5yFrOs"
FirebaseData veritabanim;


//DHT11'in bağlı olduğu pin
int DHTPin = 2; //D4
#define DHTTYPE DHT11

//DHT sensorünüü tanı
DHT dht(DHTPin, DHTTYPE);
float sicaklik = 0.0;
float nem = 0.0;

//sulama sistemi
int surucumotor = 15; //D8
int topraknemsensor = A0;

int ENA = 13;
int ENB = 12;
int IN1 = 16;
int IN2 = 5;
int IN3 = 4;
int IN4 = 0;
int hiz = 105;
int stophiz = 0;
int flag = 0;

void setup() {
  dht.begin();
  Serial.begin(115200);

  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Ağ Bağlantısı Oluşturuluyor");
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("IP adresine bağlanıldı: ");
  Serial.println(WiFi.localIP());
  Serial.println();

  //3. Firebase bağlantısı başlatılıyor
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  //4. Ağ bağlantısı kesilirse tekrar bağlanmasına izin veriyoruz
  Firebase.reconnectWiFi(true);

  //sulama sistemi tanımlamalar
  pinMode(surucumotor, OUTPUT);
  digitalWrite(surucumotor, LOW);

  pinMode(ENA, OUTPUT);
  pinMode(ENB, OUTPUT);
  pinMode(IN1, OUTPUT);
  pinMode(IN2, OUTPUT);
  pinMode(IN3, OUTPUT);
  pinMode(IN4, OUTPUT);
  digitalWrite(IN1, HIGH);
  digitalWrite(IN2, HIGH);
  digitalWrite(IN3, HIGH);
  digitalWrite(IN4, HIGH);
  analogWrite(ENA, stophiz);
  analogWrite(ENB, stophiz);

}
unsigned long eskiZaman = 0;
unsigned long yeniZaman;

void loop() {
  int topraknem = analogRead(topraknemsensor);
  Serial.print("Toprak Nem :");
  Serial.println(topraknem);


  sicaklik = dht.readTemperature();
  nem = dht.readHumidity();
  Serial.print("Sıcaklık :");
  Serial.println(sicaklik);
  Serial.print("Nem :");
  Serial.println(nem);

  if (Firebase.setFloat(veritabanim, "/nem", nem)) {
    Serial.println("Float tipinde veri gönderimi başarılı");
  }
  else {
    Serial.print("Float tipindeki veri gönderilemedi, ");
    Serial.println(veritabanim.errorReason());
  }

  if (Firebase.setInt(veritabanim, "/topraknem", topraknem)) {
    Serial.println("Float tipinde veri gönderimi başarılı");
  }
  else {
    Serial.print("Float tipindeki veri gönderilemedi, ");
    Serial.println(veritabanim.errorReason());
  }
  if (Firebase.setFloat(veritabanim, "/sicaklik", sicaklik)) {
    Serial.println("Double tipinde veri gönderimi başarılı");
  }
  else {
    Serial.print("Float tipindeki veri gönderilemedi, ");
    Serial.println(veritabanim.errorReason());
  }

  if (Firebase.getBool(veritabanim, "SulamaSistemi/Durumu")) {
    if (veritabanim.boolData() == true)
    {
      yeniZaman = millis();
      if (yeniZaman - eskiZaman > 119 0) {
        if (flag == 1) {
          analogWrite(ENA, hiz);
          analogWrite(ENB, hiz);
          digitalWrite(IN1, LOW);
          digitalWrite(IN2, HIGH);
          digitalWrite(IN3, LOW);
          digitalWrite(IN4, HIGH);
          digitalWrite(surucumotor, LOW);
          flag=0;
        }
        else {
          analogWrite(ENA, hiz);
          analogWrite(ENB, hiz);
          digitalWrite(IN1, HIGH);
          digitalWrite(IN2, LOW);
          digitalWrite(IN3, HIGH);
          digitalWrite(IN4, LOW);
          digitalWrite(surucumotor, LOW);
          flag=1;
        }
        eskiZaman=yeniZaman;
      }
    }
    else {
      analogWrite(ENA, stophiz);
      analogWrite(ENB, stophiz);

      digitalWrite(IN1, LOW);
      digitalWrite(IN2, LOW);
      digitalWrite(IN3, LOW);
      digitalWrite(IN4, LOW);
      digitalWrite(surucumotor, HIGH);
    }
  }
}
