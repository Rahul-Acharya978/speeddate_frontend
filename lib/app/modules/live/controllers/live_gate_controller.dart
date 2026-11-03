import 'dart:async';

import 'package:get/get.dart';
import 'package:sundaymixer/app/data/event_booking_api.dart';
import 'package:sundaymixer/app/data/speed_date_api.dart';
import 'package:sundaymixer/app/modules/waitingroom/views/waitingroom_view.dart';

import '../views/live_view.dart';

class LiveGateController extends GetxController {
  final phase = 'idle'.obs;
  final secondsLeft = 5.obs;
  final eventName = ''.obs;
  final message = ''.obs;
  String? _eventId;
  Timer? _timer;
  int _run = 0;

  Future<void> refresh() async {
    _run++;
    _timer?.cancel();
    phase.value = 'idle';
    await begin();
  }

  Future<void> begin() async {
    if (phase.value == 'checking' || phase.value == 'countdown' || phase.value == 'opening') {
      return;
    }

    final run = ++_run;
    _timer?.cancel();
    phase.value = 'checking';
    message.value = '';

    try {
      final event = await EventBookingApi.liveEvent();
      if (run != _run) return;
      if (event == null) {
        phase.value = 'empty';
        return;
      }

      _eventId = event['eventId'];
      eventName.value = event['eventName'] ?? 'Live event';
      secondsLeft.value = 5;
      phase.value = 'countdown';
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (run != _run) {
          timer.cancel();
          return;
        }
        if (secondsLeft.value <= 1) {
          timer.cancel();
          _connect(run);
          return;
        }
        secondsLeft.value--;
      });
    } catch (_) {
      if (run != _run) return;
      phase.value = 'error';
      message.value = 'Could not open your live event. Please try again.';
    }
  }

  Future<void> _connect(int run) async {
    final eventId = _eventId;
    if (eventId == null || eventId.isEmpty) {
      phase.value = 'empty';
      return;
    }
    phase.value = 'opening';
    try {
      final status = await SpeedDateApi.join(eventId);
      if (run != _run) return;
      phase.value = 'ready';
      if (status.phase == 'incall' && status.room.isNotEmpty) {
        Get.to(() => LiveView(eventId: eventId));
        return;
      }
      Get.to(() => WaitingroomView(eventId: eventId));
    } catch (error) {
      if (run != _run) return;
      phase.value = 'error';
      message.value = '$error'.replaceFirst('Exception: ', '');
    }
  }

  @override
  void onClose() {
    _run++;
    _timer?.cancel();
    super.onClose();
  }
}
