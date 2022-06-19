#include <ESP8266WiFi.h>
#include <DHT.h>
#include "FirebaseESP8266.h"
#include "MQ135.h"


//1. Firebase veritabanı adresini, Token bilgisini ve ağ adresi bilgilerinizi giriniz.

#define WIFI_SSID "bhdrkurt"
#define WIFI_PASSWORD "35973597"
#define FIREBASE_HOST "bitirme-project-cced3-default-rtdb.firebaseio.com"
#define FIREBASE_AUTH "f0piNl1QF7DmTH81qXIhMIHTrMtqvPqAVw5yFrOs"
FirebaseData veritabanim;


//DHT11'in bağlı olduğu pin
int DHTPin = 5; //D1
#define DHTTYPE DHT11

//DHT sensorünüü tanı
DHT dht(DHTPin, DHTTYPE);
float sicaklik = 0.0;
float nem = 0.0;

int yansensorpin = 0; //D3
int havasensor, co2lvl, gas;
int hareketsensor = D7;
int sariled = 14; //D5
int sogutmamotor = 16; //D0
int buzzer = 4; //D2
int kirmiziled = 12; //D6
int sokaklambalari =15;//D8


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
  pinMode(havasensor, INPUT);
  pinMode(LED_BUILTIN, OUTPUT);
  pinMode(yansensorpin, INPUT);
  pinMode(hareketsensor, INPUT);
  digitalWrite(hareketsensor, LOW);
  pinMode(sariled, OUTPUT);
  pinMode(kirmiziled, OUTPUT);
  pinMode(sogutmamotor, OUTPUT);
  pinMode(buzzer, OUTPUT);
  pinMode(sokaklambalari, OUTPUT);

  digitalWrite(sogutmamotor, LOW);
  digitalWrite(sokaklambalari, LOW);
  digitalWrite(buzzer, LOW);
  digitalWrite(kirmiziled, LOW);
  digitalWrite(sariled, LOW);
}

void loop() {
  bool yanginsensordeger = digitalRead(yansensorpin);

  if (yanginsensordeger == 0)
  {
    digitalWrite(LED_BUILTIN, HIGH);
    digitalWrite(buzzer, HIGH);
    digitalWrite(kirmiziled, HIGH);
  }
  else
  {
    digitalWrite(LED_BUILTIN, LOW);
    digitalWrite(buzzer, LOW);
    digitalWrite(kirmiziled, LOW);
  }
  gas = analogRead(havasensor);
  co2lvl = gas - 30;
  co2lvl = map(co2lvl, 0, 1024, 400, 5000);
  Serial.print("Karbondioksit= ");
  Serial.println(co2lvl);

  sicaklik = dht.readTemperature();
  nem = dht.readHumidity();
  Serial.print("Sıcaklık :");
  Serial.println(sicaklik);
  Serial.print("Nem :");
  Serial.println(nem);



  bool hareket = digitalRead(hareketsensor);
  if (hareket == 0) { //Hareketlilik var ise içerideki komutlar uygulanır.
    Serial.println("Hareket Algılandı");
    digitalWrite(buzzer, HIGH);
    digitalWrite(kirmiziled, HIGH);
  } else { //Hareketlilik yok ise içerideki komutlar uygulanır.
    Serial.println("Hareket Yok");
    digitalWrite(buzzer, LOW);
    digitalWrite(kirmiziled, LOW);
  }
  delay(100);
  if (Firebase.setFloat(veritabanim, "/hareketsensorpin", hareket)) {
    Serial.println("hareket verisi gönderimi başarılı");
  }
  else {
    Serial.print("hareket verisi gönderilemedi, ");
    Serial.println(veritabanim.errorReason());
  }
  if (Firebase.setFloat(veritabanim, "/yansensorpinev", yanginsensordeger)) {
    Serial.println("yangın sensor veri gönderimi başarılı");
  }
  else {
    Serial.print("yangın sensor veri gönderilemedi, ");
    Serial.println(veritabanim.errorReason());
  }

  if (Firebase.setFloat(veritabanim, "/evnem", nem)) {
    Serial.println("ev nem veri gönderimi başarılı");
  }
  else {
    Serial.print("ev nem veri gönderilemedi, ");
    Serial.println(veritabanim.errorReason());
  }

  if (Firebase.setInt(veritabanim, "/havakalite", co2lvl)) {
    Serial.println("hava kalite gönderimi başarılı");
  } 
  else {
    Serial.print("hava kalite veri gönderilemedi, ");
    Serial.println(veritabanim.errorReason());
  }
  if (Firebase.setFloat(veritabanim, "/evsicaklik", sicaklik)) {
    Serial.println("ev sıcaklık veri gönderimi başarılı");
  }
  else {
    Serial.print("ev sıcaklık veri gönderilemedi, ");
    Serial.println(veritabanim.errorReason());
  }
  if (Firebase.getBool(veritabanim, "Aydinlatma/Durumu")) {
    if (veritabanim.boolData() == true)
    {
      digitalWrite(sariled, HIGH);
    }
    else {
      digitalWrite(sariled, LOW);
    }
  }
  if (Firebase.getBool(veritabanim, "SokakLamba/Durumu")) {
    if (veritabanim.boolData() == true)
    {
      digitalWrite(sokaklambalari, HIGH);
    }
    else {
      digitalWrite(sokaklambalari, LOW);
    }
  }
  if (Firebase.getBool(veritabanim, "Havalandirma/Durumu")) {
    if (veritabanim.boolData() == true)
    {
      digitalWrite(sogutmamotor, LOW);
    }
    else {
      digitalWrite(sogutmamotor, HIGH);
    }
  }
  if (Firebase.getBool(veritabanim, "isitma/Durumu")) {
    if (veritabanim.boolData() == true)
    {
      digitalWrite(kirmiziled, HIGH);
    }
    else {
      digitalWrite(kirmiziled, LOW);
    }
  }
}
