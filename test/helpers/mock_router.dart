import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mockingjay/mockingjay.dart';

class MockGoRouter extends Mock implements GoRouter {
  MockGoRouter() {}
}

class MockGoRouterProvider extends StatelessWidget {
  const MockGoRouterProvider({
    required this.goRouter,
    required this.child,
    Key? key,
  }) : super(key: key);

  /// The mock navigator used to mock navigation calls.
  final MockGoRouter goRouter;

  /// The child [Widget] to render.
  final Widget child;

  @override
  Widget build(BuildContext context) => InheritedGoRouter(
        goRouter: goRouter,
        child: child,
      );
}
