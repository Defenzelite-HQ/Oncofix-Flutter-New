import 'package:get/get.dart';
import 'package:ui_x/helpers/Helpers.dart';
import '../../../helpers/Request.dart';
import '../../../models/ApiResponse.dart';
import '../../../shared/controllers/AppController.dart';
import '../models/AppointmentModel.dart';

class MyAppointmentController extends AppController {
  var _upcomingAppointments = <MyAppointmentModel>[].obs;
  var _pastAppointments = <MyAppointmentModel>[].obs;
  var _type = "1".obs;

  var _isLoading = false.obs;

  List<MyAppointmentModel> get upcomingAppointments => this._upcomingAppointments;

  List<MyAppointmentModel> get pastAppointments => this._pastAppointments;

  String get type => this._type.toString();

  bool get isLoading => this._isLoading.value;

  @override
  void onInit() {
    super.onInit();
    getMyAppointment();
  }

  Future<void> getMyAppointment({bool immediate = false}) async {
    if (!immediate) setBusy(true);
    _isLoading(true);
    ApiResponse response = await Request.get('/appointments?type=${_type.value}', authenticate: true);
    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      setBusy(false);
      _isLoading(false);
      return;
    }

    if (response.hasData()) {
      if (_type.value == '1') {
        _pastAppointments.clear();
        _upcomingAppointments.assignAll(List<MyAppointmentModel>.from(response.data.map((e) => MyAppointmentModel.fromJson(e))));
      } else {
        _upcomingAppointments.clear();
        _pastAppointments.assignAll(List<MyAppointmentModel>.from(response.data.map((e) => MyAppointmentModel.fromJson(e))));
      }
    }

    setBusy(false);
    _isLoading(false);
  }

  void onTabChanged(int index) async {
    if (index == 0) {
      _type("1");
    } else {
      _type("2");
    }
    await getMyAppointment(immediate: true);
  }
}
