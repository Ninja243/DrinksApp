import 'package:drinksapp/common/enums.dart';
import 'package:drinksapp/controller/settings_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

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
    _settingsController = Get.put(new SettingsController());
    _animationController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
                            _animationController.duration =
                                composition.duration;
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
                return Obx(() {
                  return Scaffold(
                      body: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        FractionallySizedBox(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    if (_animationController.isCompleted) {
                                      _animationController.reset();
                                      _animationController.forward();
                                    } else if (_animationController
                                        .isAnimating) {
                                      _animationController.reverse();
                                    } else {
                                      _animationController.forward();
                                    }
                                    
                                  },
                                  child: Lottie.asset("lib/assets/user.json",
                                      height: 150,
                                      width: 150,
                                      controller: _animationController,onLoaded: (composition) {
                                        _animationController.duration =
                                            composition.duration;
                                        //_animationController.repeat();
                                      }))
                            ],
                          ),
                        ),
                        Expanded(
                            child: ListView.builder(
                          itemBuilder: (context, index) {
                            return SwitchListTile(
                                title: Text(_settingsController
                                    .getSetting(index)
                                    .getDescription()),
                                subtitle: Text(_settingsController
                                    .getSetting(index)
                                    .getID()),
                                value: _settingsController
                                        .getSetting(index)
                                        .getID() ==
                                    _settingsController
                                        .getActiveBehaviourType()
                                        .toString()
                                        .toLowerCase()
                                        .substring(_settingsController
                                                .getActiveBehaviourType()
                                                .toString()
                                                .indexOf(".") +
                                            1),
                                onChanged: (value) {
                                  if (value) {
                                    _settingsController.setActiveBehaviourType(
                                        _settingsController
                                            .convertStringToGeneratorBehaviourType(
                                                _settingsController
                                                    .getSetting(index)
                                                    .getID()));
                                    _settingsController.update();
                                    setState(() {});
                                  } else {
                                    if (_settingsController
                                            .getSetting(index)
                                            .getID() ==
                                        _settingsController
                                            .getActiveBehaviourType()
                                            .toString()
                                            .toLowerCase()
                                            .substring(_settingsController
                                                    .getActiveBehaviourType()
                                                    .toString()
                                                    .indexOf(".") +
                                                1)) {
                                      _settingsController
                                          .setActiveBehaviourType(
                                              GeneratorBehaviourType.DEFAULT);
                                      setState(() {});
                                    }
                                  }
                                });
                          },
                          itemCount: _settingsController.length(),
                        ))
                      ]));
                });
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
                            _animationController.duration =
                                composition.duration;
                            _animationController.repeat();
                          }),
                        )
                      ],
                    ),
                    //Text("Nothing's here yet!")
                  ],
                ));
              }
            }));
  }
}
