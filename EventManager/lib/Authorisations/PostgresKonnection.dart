import 'package:postgres/postgres.dart';

class PostgresKonnection {

  String userName, hostURL, databaseName, password;
  int port;
  PostgreSQLConnection konnection;

  //   int port = 5432;
  // String databaseName = "dduqb27ithoti5";
  // String userName = "fvlgwozxresisn";
  // String hostURL = "ec2-52-50-171-4.eu-west-1.compute.amazonaws.com";
  // String password =
  //     "8443d65087d36e370bc002f7396ccbd8d373a5b7b01bf694d288e6568325c3b0";

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

  Future<PostgreSQLConnection> getKonnection() async {
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


// psql -U fvlgwozxresisn -h ec2-52-50-171-4.eu-west-1.compute.amazonaws.com -p 5432 -d dduqb27ithoti5;

// password : 8443d65087d36e370bc002f7396ccbd8d373a5b7b01bf694d288e6568325c3b0
