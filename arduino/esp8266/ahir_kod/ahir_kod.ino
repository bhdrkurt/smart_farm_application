#include <ESP8266WiFi.h>
#include "MQ135.h"
#include "FirebaseESP8266.h"

int fan = 4;//D2
int yansensorpin = 0; //D3
int havasensor, co2lvl, gas;
int led = 5;//D1
int hareketsensor = D7;



#define WIFI_SSID "bhdrkurt"
#define WIFI_PASSWORD "35973597"
#define FIREBASE_HOST "bitirme-project-cced3-default-rtdb.firebaseio.com"
#define FIREBASE_AUTH "f0piNl1QF7DmTH81qXIhMIHTrMtqvPqAVw5yFrOs"
FirebaseData veritabanim;

void setup() {
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

  pinMode(yansensorpin, INPUT);
  pinMode(fan, OUTPUT);
  pinMode(led, OUTPUT);
  digitalWrite(fan, LOW);
  pinMode(hareketsensor, INPUT);

}

void loop() {
  gas = analogRead(havasensor);
  co2lvl = gas - 55;
  co2lvl = map(co2lvl, 0, 1024, 400, 5000);
  Serial.print("Karbondioksit= ");
  Serial.println(co2lvl);

  if (Firebase.setInt(veritabanim, "/ahirco2", co2lvl)) {
    Serial.println("Int tipinde veri gönderimi başarılı");
  }
  else {
    Serial.print("Int tipindeki veri gönderilemedi, ");
    Serial.println(veritabanim.errorReason());
  }

  bool yanginsensordeger = digitalRead(yansensorpin);
  if (yanginsensordeger == 1)
  {
    digitalWrite(LED_BUILTIN, HIGH);
  }
  else
  {
    digitalWrite(LED_BUILTIN, LOW);
  }
  bool hareket = digitalRead(hareketsensor);
  if (hareket == HIGH) { //Hareketlilik var ise içerideki komutlar uygulanır.
    Serial.println("Hareket Algılandı");
  } else { //Hareketlilik yok ise içerideki komutlar uygulanır.
    Serial.println("Hareket Yok");
  }
  if (Firebase.setFloat(veritabanim, "/ahirhareketsensorpin", hareket)) {
    Serial.println("Float tipinde veri gönderimi başarılı");
  }
  else {
    Serial.print("Float tipindeki veri gönderilemedi, ");
    Serial.println(veritabanim.errorReason());
  }
  if (Firebase.setFloat(veritabanim, "/ahiryansensorpin", yanginsensordeger)) {
    Serial.println("Float tipinde veri gönderimi başarılı");
  }
  else {
    Serial.print("Float tipindeki veri gönderilemedi, ");
    Serial.println(veritabanim.errorReason());
  }
  if (Firebase.getBool(veritabanim, "Led/Durumu")) {
    if (veritabanim.boolData() == true)
    {
      digitalWrite(led, HIGH);
    }
    else
    {
      digitalWrite(led, LOW);
    }

  }
  else {
    Serial.print("Str verisi çekilemedi, ");
    Serial.println(veritabanim.errorReason());
  }
  if (Firebase.getBool(veritabanim, "Fan/Durumu")) {
    if (veritabanim.boolData() == true)
    {
      digitalWrite(fan, LOW);
    }
    else
    {
      digitalWrite(fan, HIGH);
    }
  }
  else {
    Serial.print("Str verisi çekilemedi, ");
    Serial.println(veritabanim.errorReason());
  }
}
