#include <HardwareSerial.h>
#include "BluetoothSerial.h"

#if !defined(CONFIG_BT_ENABLED) || !defined(CONFIG_BLUEDROID_ENABLED)
#error Bluetooth is not enabled! Please run make menuconfig to and enable it
#endif

BluetoothSerial SerialBT;

HardwareSerial MySerial(1);

byte data[4];
byte temp;
uint8_t pos = 0;

void setup() {
  // put your setup code here, to run once:
  MySerial.begin(9600, SERIAL_8N1, 9, 10);
  Serial.begin(115200);
  delay(10);
  SerialBT.begin("Carrito");
  Serial.println("El dispositivo esta activo, ahora puedes concetarte con bluetooth");
}

void loop() {
  // put your main code here, to run repeatedly:
  if (SerialBT.available() > 0) {
    temp = SerialBT.read();
    if (temp != '&') {
      data[pos] = temp;
      pos++;
    } else {
      MySerial.write(data, pos);
      MySerial.write('\n');
      pos = 0;
    }
  }
}
