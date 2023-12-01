import 'package:discuss_app/config/session.dart';
import 'package:discuss_app/controller/c_add_topic.dart';
import 'package:discuss_app/controller/c_profile.dart';
import 'package:discuss_app/controller/c_search.dart';
import 'package:discuss_app/model/topic.dart';
import 'package:discuss_app/page/add_topic.dart';
import 'package:discuss_app/page/detail_topic_page.dart';
import 'package:discuss_app/page/error_page.dart';
import 'package:discuss_app/page/home_page.dart';
import 'package:discuss_app/page/login_page.dart';
import 'package:discuss_app/page/profile_page.dart';
import 'package:discuss_app/page/update_topic_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../controller/c_follower.dart';
import '../model/user.dart';
import '../page/register_page.dart';
import '../page/search_page.dart';

class AppRoute {
  static const home = '/';
  static const login = '/login';
  static const register = '/register';
  static const addTopic = '/add-topic';
  static const profile = '/profile';
  static const search = '/search';
  static const follower = '/follower';
  static const following = '/following';
  static const comment = '/comment';
  static const detailTopic = '/detail-topic';
  static const updateTopic = '/update-topic';

  static GoRouter routerConfig = GoRouter(
    errorBuilder: (context, state) => ErrorPage(
      title: 'Something Error',
      description: state.error.toString(),
    ),
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      User? user = await Session.getUser();
      if (user == null) {
        if (state.location == login || state.location == register) {
          return null;
        }

        return login;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => RegisterPage(),
      ),
      GoRoute(
        path: addTopic,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => CAddTopic(),
          child: AddTopic(),
        ),
      ),
      GoRoute(
        path: detailTopic,
        builder: (context, state) =>
            DetailTopicPage(topic: state.extra as Topic),
      ),
      GoRoute(
        path: updateTopic,
        builder: (context, state) =>
            UpdateTopicPage(topic: state.extra as Topic),
      ),
      GoRoute(
        path: search,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => CSearch(),
          child: const SearchPage(),
        ),
      ),
      GoRoute(
        path: profile,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => CProfile(),
          child: ProfilePage(user: state.extra as User),
        ),
      ),
      GoRoute(
        path: follower,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => CFollower(),
        ),
      ),
    ],
  );
}
