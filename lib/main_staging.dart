import 'package:expense_tracker/app/app.dart';
import 'package:expense_tracker/bootstrap.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options-stg.dart' as stg;

void main() {
  bootstrap(() async {
    await Firebase.initializeApp(
      options: stg.DefaultFirebaseOptions.currentPlatform,
    );
    return const App();
  });
}
