import 'dart:convert';

import 'package:discuss_app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  // Metode getUser() didefinisikan sebagai fungsi async yang mengembalikan Future<User?>. Artinya, ini melakukan operasi asinkron dan mungkin memerlukan waktu untuk menyelesaikan. Metode ini akan mengembalikan pengguna yang sedang login saat ini sebagai objek User, atau null jika tidak ada pengguna yang sedang login.
  // Di dalam metode getUser():
  // - Variabel currentUser diinisialisasi sebagai null. Variabel ini akan menyimpan pengguna yang sedang login.
  // - Metode SharedPreferences.getInstance() dipanggil untuk mendapatkan sebuah instance dari shared preferences.
  // - Metode getString('user') dipanggil pada instance shared preferences untuk mendapatkan nilai yang terkait dengan kunci 'user'. Nilai ini mewakili pengguna yang sedang login dalam bentuk sebuah string JSON.
  // - Jika stringUser yang diambil tidak null, itu berarti ada pengguna yang sedang login disimpan di shared preferences. Pada kasus ini, fungsi jsonDecode() dipanggil untuk mengonversi string JSON menjadi Map<String, dynamic>.
  // - Kemudian, metode User.fromJson() dipanggil dengan argumen mapUser untuk membuat objek User dari data JSON yang telah didekode.
  // - Akhirnya, currentUser dikembalikan, yang akan berisi pengguna yang sedang login atau null jika tidak ada pengguna yang ditemukan di shared preferences.
  static Future<User?> getUser() async {
    User? currentUser;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? stringUser = pref.getString('user');

    if (stringUser != null) {
      Map<String, dynamic> mapUser = jsonDecode(stringUser);
      currentUser = User.fromJson(mapUser);
    }
    return currentUser;
  }

  // Kode ini mendefinisikan metode statis setUser(User user) yang digunakan untuk menyimpan informasi pengguna ke dalam penyimpanan shared preferences pada perangkat.
  // Metode ini mengembalikan Future<bool>, yang menunjukkan apakah penyimpanan data pengguna berhasil atau tidak.
  // Di dalam metode setUser(User user):
  // - Pertama, kita mendapatkan instance shared preferences menggunakan SharedPreferences.getInstance().
  // - Kemudian, objek pengguna user dikonversi menjadi Map dengan menggunakan metode toJson() yang ada pada objek User. Ini akan menghasilkan mapUser yang berisi data pengguna dalam bentuk Map<String, dynamic>.
  // - Selanjutnya, mapUser diubah menjadi string JSON menggunakan jsonEncode().
  // - Akhirnya, kita menggunakan pref.setString('user', stringUser) untuk menyimpan string JSON pengguna ke dalam shared preferences dengan menggunakan kunci 'user'.
  // Dengan demikian, metode setUser(User user) ini memungkinkan kita untuk menyimpan informasi pengguna ke dalam penyimpanan shared preferences dengan menggunakan objek User.
  static Future<bool> setUser(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> mapUser = user.toJson();
    String stringUser = jsonEncode(mapUser);
    return await pref.setString('user', stringUser);
  }

  // Kode ini mendefinisikan metode statis clearUser() yang digunakan untuk menghapus informasi pengguna dari penyimpanan shared preferences pada perangkat.
  // Metode ini mengembalikan Future<bool>, yang menunjukkan apakah penghapusan data pengguna berhasil atau tidak.
  // Di dalam metode clearUser():
  // - Pertama, kita mendapatkan instance shared preferences menggunakan SharedPreferences.getInstance().
  // - Selanjutnya, kita menggunakan pref.remove('user') untuk menghapus data pengguna dari shared preferences dengan menggunakan kunci 'user'.
  // Dengan demikian, metode clearUser() ini memungkinkan kita untuk menghapus informasi pengguna dari penyimpanan shared preferences.
  static Future<bool> clearUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.remove('user');
  }
}
