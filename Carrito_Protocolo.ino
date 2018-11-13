#define SERIALPORT Serial1
uint8_t vel_A = 5;
uint8_t vel_B = 6;
uint8_t dir_A = 4;
uint8_t dir_B = 7;
uint8_t v_vel_A;
uint8_t v_vel_B;
uint8_t v_dir_A;
uint8_t v_dir_B;
uint8_t trama[13];
uint8_t dataIndex = 0;


void setup() {

  pinMode(dir_A, OUTPUT);
  pinMode(vel_A, OUTPUT);
  pinMode(vel_B, OUTPUT);
  pinMode(dir_B, OUTPUT);
  SERIALPORT.begin(9600);
}

void loop() {
  uint8_t data;
  char *pdata;

  if (SERIALPORT.available() > 0) {
    data = SERIALPORT.read();

    if (data == '\n') {
      trama[dataIndex] = 0;
      dataIndex = 0;

      pdata = strchr(trama, '*');
      v_vel_A = atoi(pdata + 1);
      SERIALPORT.print("Velocidad A: ");
      SERIALPORT.println(v_vel_A);

      pdata = strchr(pdata + 1, ',');
      v_dir_A = atoi(pdata + 1);
      SERIALPORT.print("Dirección A: ");
      SERIALPORT.println(v_dir_A);

      pdata = strchr(pdata + 1, ',');
      v_vel_B = atoi(pdata + 1);
      SERIALPORT.print("Velocidad B: ");
      SERIALPORT.println(v_vel_B);

      pdata = strchr(pdata + 1, ',');
      v_dir_B = atoi(pdata + 1);
      SERIALPORT.print("Dirección B: ");
      SERIALPORT.println(v_dir_B);

      analogWrite(vel_A, v_vel_A);
      analogWrite(vel_B, v_vel_B);
      digitalWrite(dir_A, v_dir_A);
      digitalWrite(dir_B, v_dir_B);
    }
    else {
      trama[dataIndex] = data;
      dataIndex++;
    }
  }
}
