# include <DHT.h> // inclue a biblioteca
# include <DHT_U.h> // inclue a biblioteca
# include <Adafruit_Sensor.h> // inclue a biblioteca
int dht_pin = A1; // define a porta A2 saida de dados do sensor dht
int ldr_pin = A0; // define a porta A4 saida de dados do sensor ldr
int ldr_read = 0; // define a leitura do ldr como 0 inicial
int chavpin = 7; // define a porta 7 como a entrada de dados do sensor de proximidade
const int LM35 
= A0; // define a porta A0 como a saida do sensor de proximidade
float temperaturaC = 0; // Variável que armazenará a temperatura em celsius medida
float temperaturaF = 0; // Variável que armazenará a temperatura medida farenhaits
float vin = 5.00; // define vin que é usado em res_ldr como 5.00
float valor_ADC = 0.00488758, r_ohms = 10000; // valores para conversão do ldr em leitura que usaremos
DHT dht_1 = DHT (dht_pin, DHT11); // define DHT_1 para poder inicia-lo.




//Função que será executada uma vez quando ligar ou resetar o Arduino
void setup() {
pinMode(dht_pin, INPUT); // define dht_pin como entrada
pinMode(chavpin, INPUT); // define chav como entrada
Serial.begin(9600); // inicializa a comunicação serial (monitor serial)
dht_1.begin(); // inicia o dht
}


//Função que será executada continuamente
void loop() {
temperaturaC = (float(analogRead(LM35))*5/(1023))/0.01; // codigo de conversão de Volts para Celsius
temperaturaF = ((float(analogRead(LM35))*5/(1023))/0.01)* 9/5+32; // codigo de conversão de Volts para F°

float umidade = dht_1.readHumidity(); // defini umidade como a leitura de umidade do dht11
float temperatura = dht_1.readTemperature(); // defini temperatura como a leitura de temperatura do dht11

// condicionais se e se não
if(isnan(ldr_read)) {
  Serial.println("Erro ao ler o sensor"); // Fala que deu erro se deu erro
}
else {
  ldr_read = analogRead(ldr_pin); // obtem os dados do sensor

Serial.print(ldr_read); // imprime a leitura do ldr (sensor de luz) no monitor serial

}
if (isnan(temperatura) or isnan(umidade)){
  Serial.println("Erro ao ler o DHI ");// fala se deu erro se a leitura do dht falhar
}
else{

  // Serial.print("Umidade: "); //imprime no leitor serial essas informações
  Serial.print(";"); // espaçamento para banco de dados
  Serial.print(umidade); // imprime umidade lida pelo Dht11 no monitor serial
  Serial.print(";"); // espaçamento para banco de dados
  Serial.print(temperatura); // imprime temperatura lida pelo Dht11 no monitor serial
  Serial.print(";"); // espaçamento para banco de dados

  }

  Serial.print(temperaturaC); // imprime temperatura já convertida em C° lida pelo lm35
  Serial.print(";"); // espaçamento para banco de dados
  Serial.print(temperaturaF); // imprime temperatura já convertida em F° lida pelo lm35
  Serial.print(";"); // espaçamento para banco de dados


  int chave = digitalRead(7); // define chave como a leitura dos dados que estão na porta 7 do arduino
if (chave == 0)
{
Serial.print("1"); // imprime no monitor serial que sim, possui leitura
}
else
{
Serial.print("0"); // imprime no monitor serial que não, não possui leitura
}
Serial.println();
delay(2000); // define o intervalo de que ele repetira o loop (ele ficara esse tempo nesa linha antes de voltar ao começo)
}