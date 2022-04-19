import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_template/common/app_config.dart';
import 'package:project_template/common/colors.dart';
import 'package:project_template/common/styles.dart';
import 'package:project_template/flows/app/datalist/datalist_cubit.dart';
import 'package:project_template/flows/app/user_details/user_details_cubit.dart';
import 'package:project_template/flows/auth/signin/bloc/signin_cubit.dart';
import 'package:project_template/flows/auth/signup/bloc/signup_cubit.dart';
import 'package:project_template/navigation/app_state_cubit/app_state_cubit.dart';
import 'package:project_template/utils/app_notifier.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sizer/sizer.dart';
import 'package:uni_links/uni_links.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Routemaster.setPathUrlStrategy();
  await AppConfig().load();

  // await TokenManager.removeTokenData();

  runApp(App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final appStateCubit = AppStateCubit();

  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
  }

  Future<void> _handleIncomingLinks() async {
    linkStream.listen((receivedUri) {
      if (!mounted) return;
      print("receivedUri: ${receivedUri}");
      setState(() {
        if (receivedUri != null) {
          Uri uri = Uri.parse(receivedUri);
          if (uri.scheme == 'https://example.com/') {
            print("opened link: ${uri}");
          }
        }
      });
    }, onError: (Object err) {
      print('Got error $err');
    });
  }

  var _initialUriIsHandled = false;

  Future<void> _handleInitialUri() async {
    // In this example app this is an almost useless guard, but it is here to
    // show we are not going to call getInitialUri multiple times, even if this
    // was a weidget that will be disposed of (ex. a navigation route change).
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      print('_handleInitialUri called');
      try {
        final uri = await getInitialUri();
        if (uri == null) {
          print('no initial uri');
        } else {
          print('got initial uri: $uri');
        }
        if (!mounted) return;
        setState(() {});
      } on PlatformException {
        // Platform messages may fail but we ignore the exception
        print('falied to get initial uri');
      } on FormatException catch (err) {
        if (!mounted) return;
        print('malformed initial uri');
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // value: appStateCubit,
      providers: [
        BlocProvider<AppStateCubit>(
          create: (context) => appStateCubit,
        ),
        BlocProvider<SignupCubit>(
          create: (_) => GetIt.instance.get<SignupCubit>(),
        ),
        BlocProvider<SigninCubit>(
          create: (_) => GetIt.instance.get<SigninCubit>(),
        ),
        BlocProvider<DataListCubit>(
          create: (_) => GetIt.instance.get<DataListCubit>(),
        ),
        BlocProvider<UserDetailsCubit>(
          create: (_) => GetIt.instance.get<UserDetailsCubit>(),
        ),
      ],
      child: BlocBuilder<AppStateCubit, AppState>(
        bloc: appStateCubit,
        builder: (context, state) {
          return Sizer(
            builder: (
              BuildContext context,
              Orientation orientation,
              DeviceType deviceType,
            ) {
              return MaterialApp.router(
                title: 'Example',
                debugShowCheckedModeBanner: false,
                scaffoldMessengerKey: snackbarKey,
                routeInformationParser: RoutemasterParser(),
                routerDelegate: RoutemasterDelegate(
                  routesBuilder: (context) => state.routeMap,
                ),
                theme: ThemeData(
                  ///Default implementation
                  ///Change if need
                  appBarTheme: AppBarTheme(
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.almostBlack,
                    titleTextStyle: AppTextStyles.sfProDisplaySemiBold17,
                  ),
                  tabBarTheme: TabBarTheme(
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(width: 2, color: AppColors.green),
                    ),
                    labelStyle: AppTextStyles.bodyS,
                    labelColor: AppColors.almostBlack,
                    unselectedLabelStyle: AppTextStyles.bodyS,
                    unselectedLabelColor: AppColors.darkGrey,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
