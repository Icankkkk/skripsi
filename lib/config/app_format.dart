import 'package:intl/intl.dart';

class AppFormat {
  /* 
      Metode infoNumber(double number): 
      - Metode ini mengambil sebuah angka number sebagai argumen dan mengembalikan string yang merupakan representasi ringkas dari angka tersebut.
      - Metode ini menggunakan kelas NumberFormat dari pustaka intl untuk memformat angka dengan format yang lebih mudah dibaca.
      - Contohnya, jika kita memanggil AppFormat.infoNumber(1000), maka metode ini akan mengembalikan string "1K".
  */
  static String infoNumber(double number) {
    return NumberFormat.compact().format(number);
  }

  /* 
     Metode fullDateTime(String date): 
      - Metode ini mengambil sebuah string date yang mewakili tanggal dan waktu dalam format yang dapat dipahami oleh DateTime.parse().
      - Metode ini menggunakan kelas DateFormat dari pustaka intl untuk memformat tanggal dan waktu ke dalam format yang diinginkan, yaitu "EEE, d MM yy | HH:mm" (misalnya, "Mon, 1 12 23 | 13:45").
      - Metode ini mengembalikan string yang merupakan representasi tanggal dan waktu yang diformat.
  */
  static String fullDateTime(String date) {
    return DateFormat('EEE, d MM yy | HH:mm').format(DateTime.parse(date));
  }

  /* 
     Metode publish(String date): 
      - Metode ini mengambil sebuah string date yang mewakili tanggal dan waktu dalam format yang dapat dipahami oleh DateTime.parse().
      - Metode ini menggunakan kelas DateTime untuk membandingkan tanggal dan waktu yang diberikan dengan tanggal dan waktu saat ini (DateTime.now()).
      - Metode ini membandingkan tanggal dan waktu yang diberikan dengan tanggal kemarin (DateTime.now().subtract(const Duration(days: 1))) untuk menentukan apakah tanggal dan waktu tersebut lebih tua dari kemarin.
      - Jika tanggal dan waktu yang diberikan lebih tua dari kemarin, maka metode fullDateTime(date) akan dipanggil untuk memformat tanggal dan waktu tersebut.
      - Jika tanggal dan waktu yang diberikan lebih baru dari kemarin, maka metode ini akan menghitung selisih waktu antara tanggal dan waktu yang diberikan dengan tanggal dan waktu saat ini dalam jam, menit, atau detik.
      - Metode ini mengembalikan string yang menggambarkan selisih waktu dalam format "x hour" (misalnya, "2 hour"), "x minute" (misalnya, "30 minute"), atau "x second" (misalnya, "10 second").
  */
  static String publish(String date) {
    DateTime dateTime = DateTime.parse(date);
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(const Duration(days: 1));

    if (dateTime.isBefore(yesterday)) {
      return fullDateTime(date);
    } else {
      int hour = now.difference(dateTime).inHours;
      if (hour >= 1) {
        return '$hour hour';
      } else {
        int minute = now.difference(dateTime).inMinutes;
        if (minute >= 1) {
          return '$minute minute';
        } else {
          int second = now.difference(dateTime).inSeconds;
          second = second < 0 ? 1 : second;
          return '$second second';
        }
      }
    }
  }
}
