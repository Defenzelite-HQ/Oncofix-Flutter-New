import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'CountrDuration.dart';

class Countr extends StatelessWidget {
  const Countr({
    Key? key,
    required this.controller,
    required this.builder,
    this.onTimerComplete,
  }) : super(key: key);

  final Widget Function(BuildContext context, CountrDuration remainingTime) builder;
  final CountrController controller;
  final Function()? onTimerComplete;

  String _strDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    /// Assign the onCompleteCallback function.
    controller.__onDoneCallback(onTimerComplete);
    return GetBuilder<CountrController>(
        init: controller,
        builder: (CountrController controller) {
          return builder(
            context,
            CountrDuration(
              days: _strDigits(controller.remainingTime.inDays),
              hours: _strDigits(controller.remainingTime.inHours.remainder(24)),
              minutes: _strDigits(controller.remainingTime.inMinutes.remainder(60)),
              seconds: _strDigits(controller.remainingTime.inSeconds.remainder(60)),
            ),
          );
        });
  }
}

class CountrController extends GetxController {
  CountrController({
    this.endTime = const Duration(seconds: 30),
    this.initializationDelay = const Duration(seconds: 0),
    this.initialize = false,
    this.reducer = 1,
  });

  RxBool _timeUp = false.obs;
  RxBool _counting = false.obs;
  final Duration endTime;
  final Duration initializationDelay;
  final bool initialize;
  Timer? countdownTimer;
  late Duration remainingTime;
  Function()? _callback;
  final int reducer;

  bool get timeUp => _timeUp.value;

  bool get counting => _counting.value;

  @override
  void onInit() {
    super.onInit();
    remainingTime = endTime;
    if (initialize) Future.delayed(initializationDelay, () => startTimer());
  }

  @override
  void onClose() {
    resetTimer(disposing: true);
    super.onClose();
  }

  void startTimer() {
    _counting(true);
    remainingTime = endTime;
    countdownTimer = Timer.periodic(1.seconds, (_) => _setCountDown());
  }

  void stopTimer({bool disposing = false}) {
    if (countdownTimer != null) countdownTimer!.cancel();
    _counting(false);
    if (!disposing) update();
  }

  void resetTimer({bool disposing = false}) {
    stopTimer(disposing: disposing);
    remainingTime = endTime;
    if (!disposing) update();
  }

  void __onDoneCallback(Function()? callback) {
    if (callback != null) _callback = callback;
  }

  void _setCountDown() {
    final seconds = remainingTime.inSeconds - reducer;
    if (seconds < 0) {
      countdownTimer!.cancel();
      _timeUp(true);
      _counting(false);
      if (_callback != null) _callback!();
    } else {
      remainingTime = Duration(seconds: seconds);
    }
    update();
  }

  void setEndTime(Duration time){
    remainingTime = time;
    update();
  }
}
