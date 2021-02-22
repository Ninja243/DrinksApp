import 'package:drinksapp/controller/settings_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lottie/lottie.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  SettingsController _settingsController;

  @override
  void initState() {
    _settingsController = new SettingsController();
    _animationController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      initialData: false,
      future: _settingsController.initWithFuture(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Lottie.asset('lib/assets/error.json',
                        controller: _animationController,
                        onLoaded: (composition) {
                      _animationController.duration = composition.duration;
                      _animationController.repeat();
                    }),
                  )
                ],
              ),
              Text(snapshot.error.toString())
              //Text("Nothing's here yet!")
            ],
          ));
        } else if (snapshot.hasData) {
          ///return Obx(() {return Text("Settings my dude!");});
          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                  GestureDetector(
                  child: Lottie.asset("lib/assets/user.json",
                      height: 150,
                      width: 150,
                      controller: _animationController,
                      onLoaded: (composition) {
                    _animationController.duration = composition.duration;
                  }),
                  onTap: () {
                    if (_animationController.isCompleted) {
                      _animationController.reset();
                    }
                    _animationController.forward();
                  },
                ),
                
                ],),
                Text("User Name"),
              ],
            ),
          );
        } else {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Lottie.asset('lib/assets/loading.json',
                        controller: _animationController,
                        onLoaded: (composition) {
                      _animationController.duration = composition.duration;
                      _animationController.repeat();
                    }),
                  )
                ],
              ),
              //Text("Nothing's here yet!")
            ],
          ));
        }
      },
    ));
  }
}
