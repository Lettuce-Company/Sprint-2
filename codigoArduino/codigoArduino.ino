# include <DHT.h> // inclue a biblioteca
# include <DHT_U.h> // inclue a biblioteca
# include <Adafruit_Sensor.h> // inclue a biblioteca
int dht_pin = A1; // define a porta A1 saida de dados do sensor dht
const int LM35 = A0; // define a porta A0 como a saida do sensor de temperatura
float temperaturaC; // Variável que armazenará a temperatura em celsius medida
DHT dht_1 = DHT (dht_pin, DHT11); // define DHT_1 para poder inicia-lo.




//Função que será executada uma vez quando ligar ou resetar o Arduino
void setup() {
pinMode(dht_pin, INPUT); // define dht_pin como entrada
Serial.begin(9600); // inicializa a comunicação serial (monitor serial)
dht_1.begin(); // inicia o dht
}


//Função que será executada continuamente
void loop() {
temperaturaC = (float(analogRead(LM35))*5/(1023))/0.01; // codigo de conversão de Volts para Celsius

float umidade = dht_1.readHumidity(); // defini umidade como a leitura de umidade do dht11
 float temperatura = dht_1.readTemperature(); // defini temperatura como a leitura de temperatura do dht11


if (isnan(temperatura) or isnan(umidade)){
  Serial.println("Erro ao ler o DHI");// fala se deu erro se a leitura do dht falhar
}
else{
  Serial.print(umidade); // imprime umidade lida pelo Dht11 no monitor serial
  Serial.print(";"); // espaçamento para banco de dados
  Serial.print(temperatura); // imprime temperatura lida pelo Dht11 no monitor serial
  Serial.print(";"); // espaçamento para banco de dados
  }

  Serial.print(temperaturaC); // imprime temperatura já convertida em C° lida pelo lm35
  Serial.print(";"); // espaçamento para banco de dados

  Serial.println();
  delay(2000); // define o intervalo de que ele repetira o loop (ele ficara esse tempo nesa linha antes de voltar ao começo)
}