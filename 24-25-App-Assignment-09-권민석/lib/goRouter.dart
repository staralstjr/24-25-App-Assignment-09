import 'package:go_router/go_router.dart';
import 'BoardDetails.dart';
import 'CreateBoard.dart';
import 'EditBoard.dart';
import 'login.dart';
import 'signUp.dart';
import 'home.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/signUp',
      builder: (context, state) => SignUpPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/CreateBoard',
      builder: (context, state) => CreateBoard(),
    ),
    GoRoute(
      path: '/BoardDetails',
      builder: (context, state) {
        final board = state.extra as Map<String, String>;
        return BoardDetails(board: board);
      },
    ),
    GoRoute(
      path: '/EditBoard',
      builder: (context, state) {
        final board = state.extra as Map<String, String>;
        return EditBoard(
          board: board,
          onEdit: (updatedBoard) {
            context.pop(updatedBoard);
          },
        );
      },
    )
  ],
);
