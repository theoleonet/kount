import 'package:appwrite/appwrite.dart';
import 'package:flutter/widgets.dart';
import 'package:kount/screens/auth/register.dart';

class AuthState {
  Client client = Client();
  late Account account;
  late Storage storage;
  late Avatars avatars;
  late Databases databases;

  AuthState() {
    _init();
  }

  _init() {
    client = Client()
        .setEndpoint(
          'http://192.168.1.59:90/v1',
        )
        .setProject(
          '63ac90ca35e31ed84b02',
        )
        .setSelfSigned(
          status: true,
        ); // For self signed certificates, only use for development

    account = Account(client);
    storage = Storage(client);
    avatars = Avatars(client);
    databases = Databases(client);
  }
}
