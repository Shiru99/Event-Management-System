import 'package:postgres/postgres.dart';

class PostgresKonnection {

  String userName, hostURL, databaseName, password;
  int port;
  PostgreSQLConnection konnection;

  setKonnection(String hostURL, int port, String databaseName,
      String userName, String password) async {
    this.userName = userName;
    this.hostURL = hostURL;
    this.port = port;
    this.databaseName = databaseName;
    this.password = password;

    this.konnection = PostgreSQLConnection(
      this.hostURL,
      this.port,
      this.databaseName,
      username: this.userName,
      password: this.password,
      useSSL: true,
    );

    try {
      await konnection.open();
      print('Connected to Postgres database...');
      
    } catch (e) {
      print(e.toString());
      
    }
    
    
  }

  PostgreSQLConnection getKonnection() {
    return this.konnection;
  }

  closeKonnection() async {
    try {
      await konnection.close();
      print('Disconnected to Postgres database...');
    } catch (e) {
      print(e.toString());
    }
  }
}

// final conn = PostgreSQLConnection(
//   'localhost',
//   5435,
//   'dart_test',
//   username: 'postgres',
//   password: 'password',
// );
// await conn.open();

// psql -U oofplrsgbytwdc -h ec2-34-232-24-202.compute-1.amazonaws.com -p 5432 -d djb7v0o318g55;

// password : b72bf90efb5e5f52b3c22146e1180e36d03a87f7ef5f76f8025733511e663583
