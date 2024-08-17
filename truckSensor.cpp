#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include <NewPing.h>
#include <SoftwareSerial.h>
#include <TinyGPS++.h>
#include <SPI.h>
#include <LoRa.h>

#define ONE_WIRE_BUS 4  // GPIO 4 (D2) pour DS18B20
#define FLOW_SENSOR_PIN 14 // GPIO 14 (D5) pour le capteur de débit
#define TRIG_PIN 12 // GPIO 12 (D6) pour HC-SR04
#define ECHO_PIN 13 // GPIO 13 (D7) pour HC-SR04
#define RX_PIN 5 // GPIO 5 (D1) pour GPS
#define TX_PIN 0 // GPIO 0 (D3) pour GPS
#define MAX_DISTANCE 200 // Distance maximale pour le capteur ultrasonique

const char* ssid = "****";
const char* password = "****";
const char* serverUrl = "http://SERVER_IP:3001/updateSensorData";
const char* truckPlate = "TRUCK_1234";

OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature sensors(&oneWire);
NewPing sonar(TRIG_PIN, ECHO_PIN, MAX_DISTANCE);
SoftwareSerial ss(RX_PIN, TX_PIN);
TinyGPSPlus gps;

volatile uint16_t flowPulseCount = 0;
volatile uint16_t totalFlowPulses = 0;
float flowRate = 0.0;
float totalFlowLiters = 0.0;

void IRAM_ATTR flowPulseCounter() {
  flowPulseCount++;
  totalFlowPulses++;
}

void setup() {
  // Initialisation des communications série et des capteurs
  Serial.begin(115200);
  sensors.begin();
  ss.begin(9600);

  // Configuration des broches et interruptions
  pinMode(FLOW_SENSOR_PIN, INPUT);
  attachInterrupt(digitalPinToInterrupt(FLOW_SENSOR_PIN), flowPulseCounter, RISING);

  // Connexion au réseau WiFi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi...");
  }
  Serial.println("Connected to WiFi");

  // Initialisation de LoRa
  SPI.begin(SCK, MISO, MOSI, SS);
  LoRa.setPins(SS, RST, DIO0);
  if (!LoRa.begin(915E6)) {
    Serial.println("Starting LoRa failed!");
    while (1);
  }
  Serial.println("LoRa Initializing OK!");
}

void loop() {
  
  if (WiFi.status() == WL_CONNECTED) {

    sensors.requestTemperatures();
    float temperatureC = sensors.getTempCByIndex(0);

    // Lecture du capteur de débit
    noInterrupts();
    uint16_t pulseCount = flowPulseCount;
    flowPulseCount = 0;
    interrupts();
    
    flowRate = pulseCount / 7.5;

    // Gestion du total de débit en litres
    if (pulseCount > 10) { 
      totalFlowLiters += (pulseCount / 7.5); // conversion en litres
    } else if (totalFlowLiters > 0) {
      // Envoyer le total de débit en litres au serveur
      sendFlowRateData(totalFlowLiters);
      totalFlowLiters = 0.0; // Réinitialiser le total de débit après envoi
    }

    // Lecture du capteur ultrasonique
    unsigned int distance = sonar.ping_cm();
    if (distance == 0) {
      distance = MAX_DISTANCE;
    }

    // Lecture des données GPS
    while (ss.available() > 0) {
      gps.encode(ss.read());
    }

    // Envoyer les données au serveur via HTTP
    sendDataHTTP(temperatureC, flowRate, distance);

    // Envoyer les données via LoRa
    sendDataLoRa(temperatureC, flowRate, distance);
  }
  delay(10000); 
}

void sendDataHTTP(float temperature, float flowRate, unsigned int distance) {
  HTTPClient http;
  http.begin(serverUrl);
  http.addHeader("Content-Type", "application/json");

  String postData = "{\"truckPlate\":\"" + String(truckPlate) + "\",";
  postData += "\"temperature1\":" + String(temperature) + ",";
  postData += "\"flowRate1\":" + String(flowRate) + ",";
  postData += "\"distance\":" + String(distance) + "}";

  int httpResponseCode = http.POST(postData);
  if (httpResponseCode > 0) {
    String response = http.getString();
    Serial.println(httpResponseCode);
    Serial.println(response);
  } else {
    Serial.print("Error on sending POST: ");
    Serial.println(httpResponseCode);
  }

  http.end();
}

void sendDataLoRa(float temperature, float flowRate, unsigned int distance) {
  String loraMessage = String(truckPlate) + ",";
  loraMessage += String(temperature) + ",";
  loraMessage += String(flowRate) + ",";
  loraMessage += String(distance);

  LoRa.beginPacket();
  LoRa.print(loraMessage);
  LoRa.endPacket();

  Serial.println("LoRa message sent: " + loraMessage);
}

void sendFlowRateData(float totalLiters) {
  HTTPClient http;
  http.begin(serverUrl);
  http.addHeader("Content-Type", "application/json");

  String postData = "{\"truckPlate\":\"" + String(truckPlate) + "\",";
  postData += "\"flowTotalLiters\":" + String(totalLiters) + "}";

  int httpResponseCode = http.POST(postData);
  if (httpResponseCode > 0) {
    String response = http.getString();
    Serial.println(httpResponseCode);
    Serial.println(response);
  } else {
    Serial.print("Error on sending flow rate data POST: ");
    Serial.println(httpResponseCode);
  }

  http.end();
}
