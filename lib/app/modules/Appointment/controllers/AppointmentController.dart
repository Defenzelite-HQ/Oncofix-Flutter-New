import 'dart:convert';
import 'package:get/get.dart';
import 'package:ui_x/helpers/Helpers.dart';
import '../../../helpers/Request.dart';
import '../../../models/ApiResponse.dart';
import '../../../shared/controllers/AppController.dart';
import '../models/ScheduleModel.dart';

class AppointmentController extends AppController {
  var _scheduleData = <String, dynamic>{}.obs;
  var _schedules = <ScheduleModel>[].obs;
  var _booking = false.obs;

  var _doctorId = "".obs;
  var _selectedDate = DateTime.now().obs;
  var _selectedStartTime = "".obs;
  var _selectedEndTime = "".obs;

  List<ScheduleModel> get schedules => this._schedules;

  DateTime get selectedDate => this._selectedDate.value;
  bool get booking => this._booking.value;
  String get selectedStartTime => this._selectedStartTime.value;
  String get selectedEndTime => this._selectedEndTime.value;

  @override
  void onInit() {
    super.onInit();
    _doctorId(Get.parameters['doctor_id']);
    getSchedules();
  }

  Future<void> getSchedules() async {
    setBusy(true);
    ApiResponse response = await Request.get(
        '/appointments/schedules/${_doctorId.value}?date=${_selectedDate.value.year}-${_selectedDate.value.month}-${_selectedDate.value.day}&doctor_id=${_doctorId.value}',
        authenticate: true);

    if (response.hasError()) {
     Toastr.show(message: "${response.message}");
      setBusy(false);
      return;
    }

    if (response.hasData()) {
      _scheduleData.assignAll(Map<String, dynamic>.from(response.data));
      // _schedules.assignAll(List<ScheduleModel>.from(response.data.map((e) => ScheduleModel.fromJson(e))));


    }
    onDateSelect(DateTime.now());
    setBusy(false);
  }


  Future<void> bookAppointment() async {
    _booking(true);
    Map<String, dynamic> body = {
      "doctor_id": _doctorId.value,
      "type": "1",
      "start_time": get24HrTime(_selectedStartTime.value),
      "end_time": get24HrTime(_selectedEndTime.value),
      // "date": Jiffy(_selectedDate.value).format('yyyy-MM-dd'),
    };

    ApiResponse response = await Request.post('/appointments/store', body: body, authenticate: true);

    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      _booking(false);
      return;
    }

    if(response.hasData()){
      Get.toNamed("/appointments/checkout", parameters: {"appointment": jsonEncode(response.data)});
      // ShowSnack.toast(message: "${response.message}");
    }

    _booking(false);
  }

  void onDateSelect(DateTime date) {
    _selectedDate(date);
    //_schedules.assignAll(List<ScheduleModel>.from(_scheduleData[Jiffy(date).format('EEEE').toLowerCase()]!.map((e) => ScheduleModel.fromJson(e))));
    onTimeDeselect();
  }

  void onTimeSelect(String startTime, String endTime) {
    _selectedStartTime(startTime);
    _selectedEndTime(endTime);
  }

  void onTimeDeselect() {
    _selectedStartTime("");
    _selectedEndTime("");
  }


  String get24HrTime(String time){
    String _amPm = time.split(" ").last;
    String _t = time.split(" ").first;
    String _hour = _t.split(":").first;
    String _minutes = _t.split(":").first;

    if(_amPm.toLowerCase() == "am"){
      return "$_t:00";
    }
    return (int.parse(_hour) + 12).toString() + ":$_minutes:00";
  }
}
