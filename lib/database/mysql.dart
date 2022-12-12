import 'package:mysql1/mysql1.dart';

class MySqlDB {
  static String host = 'localhost',
      user = 'root',
      password = '',
      db = 'toko_penjualan';

  static int port = 3306;

  Future<MySqlConnection> getConnection() async {
    var settings = new ConnectionSettings(
        host: host, user: user, password: password, port: port, db: db);
    return await MySqlConnection.connect(settings);
  }
}
