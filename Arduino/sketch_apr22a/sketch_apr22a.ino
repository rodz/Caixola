/*
   23/05/2018
   Bruno Felipe Corte
   Exemplo IBM Watson IoT Platform + Planta IoT
   Hardware: new NodeMCU LoLin V3 + Sensor umidade solo


   Logica:
   1. efetua conexao com a rede WiFi
   2. obtem a grandeza de umidade do solo
   3. conecta no servidor MQTT IBM Watson IoT Platform
   4. publica a JSON string para o topico 
   
   referencias Bluemix e IoTF:
   Autor: FilipeFlop
   https://www.filipeflop.com/blog/planta-iot-com-esp8266-nodemcu/
   
*/


#include <ESP8266WiFi.h>
#include <PubSubClient.h>


//atualize SSID e senha WiFi
const char* ssid = "IBMHackatruckIoT";
const char* password = "IOT2017IBM";


//D4 only for Lolin board
#define LED_BUILTIN D4
#define S0 D0
#define S1 D1
#define S2 D2
#define S3 D3
#define sensorOut D8



//Atualize os valores de Org, device type, device id e token
#define ORG "qc8dss"
#define DEVICE_TYPE "nodemcu"
#define DEVICE_ID "nodemcu14"
#define TOKEN "12345678"


//broker messagesight server
char server[] = ORG ".messaging.internetofthings.ibmcloud.com";
char topic[] = "iot-2/evt/status/fmt/json";
char authMethod[] = "use-token-auth";
char token[] = TOKEN;
char clientId[] = "d:" ORG ":" DEVICE_TYPE ":" DEVICE_ID;


float umidade = 0.0;
char umidadestr[6];


WiFiClient wifiClient;
PubSubClient client(server, 1883, NULL, wifiClient);


void setup() {
  Serial.begin(115200);
  
  pinMode(S0, OUTPUT);
  pinMode(S1, OUTPUT);
  pinMode(S2, OUTPUT);
  pinMode(S3, OUTPUT);
  
  pinMode(sensorOut, INPUT);

  //Definindo a escala de frenquencia para 20%
  digitalWrite(S0,HIGH);
  digitalWrite(S1,LOW);
  
  Serial.println();
  Serial.println("Iniciando...");


  Serial.print("Conectando na rede WiFi "); Serial.print(ssid);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.print("[INFO] Conectado WiFi IP: ");
  Serial.println(WiFi.localIP());


  pinMode(LED_BUILTIN, OUTPUT);
}


//Função: faz a leitura do nível de umidade
//Parâmetros: nenhum
//Retorno: umidade percentual (0-100)
//Observação: o ADC do NodeMCU permite até, no máximo, 3.3V. Dessa forma,
//            para 3.3V, obtem-se (empiricamente) 978 como leitura de ADC

int getColor(int rgb){
  int freq = 0;
  if(rgb==0){
    digitalWrite(S2,LOW);
    digitalWrite(S3,LOW);
  }else if(rgb==1){
    digitalWrite(S2,HIGH);
    digitalWrite(S3,HIGH);
  }else{
    digitalWrite(S2,LOW);
    digitalWrite(S3,HIGH);
  }

  freq = pulseIn(sensorOut,LOW);
  return freq;
}
//Setando os parâmetros e limites de cada letra (RGB)
int a[] = {32,44,205,230,300,320};
int b[] = {32,44,205,230,300,320};
int e[] = {32,44,205,230,300,320};
int i[] = {32,44,205,230,300,320};
int n[] = {32,44,205,230,300,320};
int l[] = {32,44,205,230,300,320};


String getCharacter(void){
  int redFrequency = getColor(0);
  int greenFrequency = getColor(1);
  int blueFrequency = getColor(2);
  if(redFrequency>=a[0] && redFrequency<=a[1] && greenFrequency>=a[2] && greenFrequency<=a[3] && blueFrequency>=a[4] && blueFrequency<=a[5]){
    return "a";
  }else if(redFrequency>=b[0] && redFrequency<=b[1] && greenFrequency>=b[2] && greenFrequency<=b[3] && blueFrequency>=b[4] && blueFrequency<=b[5]){
    return "b";
  }else if(redFrequency>=e[0] && redFrequency<=e[1] && greenFrequency>=e[2] && greenFrequency<=e[3] && blueFrequency>=e[4] && blueFrequency<=e[5]){
    return "e";
  }else if(redFrequency>=i[0] && redFrequency<=i[1] && greenFrequency>=i[2] && greenFrequency<=i[3] && blueFrequency>=i[4] && blueFrequency<=i[5]){
    return "i";
  }else if(redFrequency>=n[0] && redFrequency<=n[1] && greenFrequency>=n[2] && greenFrequency<=n[3] && blueFrequency>=n[4] && blueFrequency<=n[5]){
    return "n";
  }else if(redFrequency>=l[0] && redFrequency<=l[1] && greenFrequency>=l[2] && greenFrequency<=l[3] && blueFrequency>=l[4] && blueFrequency<=l[5]){
    return "l";
  }
  return "";
  
}

void loop() {


  if (!!!client.connected()) {
    Serial.print("Reconnecting client to ");
    Serial.println(server);
    while (!!!client.connect(clientId, authMethod, token)) {
      Serial.print(".");
      delay(500);
    }
    Serial.println();
  }

  String letter = getCharacter();


/*
  float umidade = FazLeituraUmidade();
  
  // Conversao Floats para Strings
  char TempString[32];  //  array de character temporario


  // dtostrf( [Float variable] , [Minimum SizeBeforePoint] , [sizeAfterPoint] , [WhereToStoreIt] )
  dtostrf(umidade, 2, 1, TempString);
  String umidadestr =  String(TempString);

*/
  // Prepara JSON para IOT Platform
  int length = 0;


  String payload = "{\"d\":{\"letra\":\" Luana chatona \"}}";


  length = payload.length();
  Serial.print(F("\nData length"));
  Serial.println(length);


  Serial.print("Sending payload: ");
  Serial.println(payload);


  if (client.publish(topic, (char*) payload.c_str())) {
    Serial.println("Publish ok");
    digitalWrite(LED_BUILTIN, LOW);
    delay(500);
    digitalWrite(LED_BUILTIN, HIGH);
    delay(500);
  } else {
    Serial.println("Publish failed");
    Serial.println(client.state());
  }
}

