import 'package:expense_tracker/app/app.dart';
import 'package:expense_tracker/bootstrap.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart' as prod;

void main() {
  bootstrap(() async {
    await Firebase.initializeApp(
      options: prod.DefaultFirebaseOptions.currentPlatform,
    );
    return const App();
  });
}
