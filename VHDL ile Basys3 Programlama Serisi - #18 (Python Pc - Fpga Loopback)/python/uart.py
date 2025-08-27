import serial
import time

serial_port = "COM6"
baud_rate = 115200

try:
    ser = serial.Serial(serial_port, baud_rate, timeout=1)
    print(f"Baglanti kuruldu: {serial_port} @ {baud_rate} baud")
except serial.SerialException as e:
    print(f"HATA: {e}")
    exit()
    
data_out = "B"

print(f"Gonderiliyor: {data_out}")
ser.write(data_out.encode())

time.sleep(0.1)

if ser.in_waiting > 0:
    data_in = ser.read(ser.in_waiting).decode()
    print(f"Gelen veri: {data_in}")
else:
    print("Cevap alinamadi.")
    
ser.close()