/*
Author: Peter Barrett
*/

#include <RFduinoBLE.h>

int led = 4; //blue
int led2 = 3; //green
int led3 = 2; //red

void setup() {
  // led turned on/off from the iPhone app
  pinMode(led, OUTPUT);
  pinMode(led2, OUTPUT);
  pinMode(led3, OUTPUT);
  
  RFduinoBLE.advertisementData = "light";
  RFduinoBLE.deviceName = "Notify";
  // start the BLE stack
  RFduinoBLE.begin();
}

void loop() {
  RFduino_ULPDelay(INFINITE);
}

void RFduinoBLE_onDisconnect()
{
  // don't leave the led on if they disconnect
  digitalWrite(led, LOW);
}
void RFduinoBLE_onConnect(){
  //flash sequence
  digitalWrite(led3, HIGH);
  delay(500);  
  digitalWrite(led3, LOW);
  digitalWrite(led2, HIGH);
  delay(50);
  digitalWrite(led2, LOW);
  delay(50);
  digitalWrite(led3, HIGH);
  delay(50);  
  digitalWrite(led3, LOW);
  digitalWrite(led2, HIGH);
  delay(50);
  digitalWrite(led2, LOW);
}  
  
void RFduinoBLE_onReceive(char *data, int len)
{
  digitalWrite(led, LOW);
  digitalWrite(led, HIGH);   
  delay(1000);              
  digitalWrite(led, LOW);    
  delay(1000); 
}
