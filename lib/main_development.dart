import 'package:expense_tracker/app/app.dart';
import 'package:expense_tracker/bootstrap.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options-dev.dart' as dev;

void main() {
  bootstrap(() async {
    await Firebase.initializeApp(
      options: dev.DefaultFirebaseOptions.currentPlatform,
    );
    return const App();
  });
}
