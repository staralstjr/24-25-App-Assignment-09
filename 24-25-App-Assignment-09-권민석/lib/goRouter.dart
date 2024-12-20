import 'package:go_router/go_router.dart';
import 'package:nine_session/BoardDetails.dart';
import 'package:nine_session/CreateBoard.dart';
import 'package:nine_session/EditBoard.dart';
import 'login.dart';
import 'signUp.dart';
import 'home.dart'; // 홈 화면 추가

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SignUpPage(),
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
      path: '/home', // 홈 경로 추가
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/CreateBoard',
      builder: (context, state) => CreateBoard(),
    ),
    GoRoute(
      path: '/BoardDetails',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return BoardDetails(
          board: extra['board'],
          onDelete: extra['onDelete'],
          onEdit: extra['onEdit'],
        );
      },
    ),
    GoRoute(
      path: '/EditBoard',
      builder: (context, state) {
        final board = state.extra as Map<String, String>;
        return EditBoard(board: board);
      },
    ),
  ],
);
