import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drinksapp/config/size_config.dart';
import 'package:drinksapp/config/app_theme.dart';
import 'package:drinksapp/screen/Loading/Loading.dart';
import 'package:flutter/services.dart';

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //return LifecycleWatcher( child:
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: LoadingScreen(),
        );
      });
    });
    //);
  }
}

//class LifecycleWatcher extends StatefulWidget {
//  final Widget child;
//
//  const LifecycleWatcher({Key key, @required this.child}) : super(key: key);
//
//  @override
//  _LifecycleWatcherState createState() => _LifecycleWatcherState();
//}
//
//class _LifecycleWatcherState extends State<LifecycleWatcher>
//    with WidgetsBindingObserver {
//  @override
//  void initState() {
//    super.initState();
//    WidgetsBinding.instance.addObserver(this);
//  }
//
//  @override
//  void dispose() {
//    WidgetsBinding.instance.removeObserver(this);
//    super.dispose();
//  }
//
//  @override
//  void didChangeAppLifecycleState(AppLifecycleState state) async {
//    switch (state) {
//      case AppLifecycleState.paused:
//        MixpanelAPI mixpanelAPI = await MixpanelAPI.getInstance(MIXAPI_KEY);
//        mixpanelAPI.flush();
//        break;
//      default:
//        break;
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return widget.child;
//  }
//}
//
