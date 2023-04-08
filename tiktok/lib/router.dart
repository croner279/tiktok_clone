import 'package:go_router/go_router.dart';
import 'package:tiktok/features/authentication/email_screen.dart';
import 'package:tiktok/features/authentication/sign_up_screen.dart';
import 'package:tiktok/features/authentication/username_screen.dart';
import 'package:tiktok/features/users/user_profile_screen.dart';

//아래와 같은 nested router을 안했다면...(중첩 경로)

//이렇게 하나하나 부모경로를 지정해가며 노가다 해야 했을 것.
/* "/" => SignUpScreen
"/username" => UsernameScreen
"/username/email" => EmailScreen


// 대신해서, 아래같이 중첩경로 한 것임
"/" 
  "username"
    "emial"
 */

final router = GoRouter(
  routes: [
    GoRoute(
      path: SignUpScreen.routeURL,
      name: SignUpScreen.routeName,
      builder: (context, state) => const SignUpScreen(),
      routes: [
        GoRoute(
            path: UsernameScreen.routeURL,
            name: UsernameScreen.routeName,
            builder: (context, state) => const UsernameScreen(),
            routes: [
              GoRoute(
                name: EmailScreen.routeName,
                path: EmailScreen.routeName,
                builder: (context, state) {
                  final args = state.extra as EmailScreenArgs;
                  return EmailScreen(username: args.username);
                },
              ),
            ]),
      ],
    ),

/*     GoRoute(
      path: LoginScreen.routeName,
      builder: (context, state) => const LoginScreen(),
    ), */

    /*  GoRoute(
      path: UsernameScreen.routeName,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const UsernameScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: animation,
                child: child,
              ),
            );
          },
        );
      },
    ), */

    GoRoute(
      //이제 variable(:username, 변수에 대응하는 것이 URL에서 자동으로 파싱되어 라우트 상태에 저장됨)도 넣을 수 있다. URL의 Param을 가져와서 웹에 반영함. 매우 웹스러운 라우터임.
      path: "/users/:username",
      builder: (context, state) {
        final username = state.params['username'];
        final tab = state.queryParams['show'];
        return UserProfileScreen(username: username!, tab: tab!);
      },
    )
  ],
);
