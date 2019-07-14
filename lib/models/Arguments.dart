import 'package:firebase_auth/firebase_auth.dart';
import 'Asset.dart';

class Arguments {
  final FirebaseUser user;
  final Asset asset;
  Arguments(this.user, this.asset);
}