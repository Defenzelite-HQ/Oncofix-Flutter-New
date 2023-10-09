import 'package:get/get.dart';

import '../DoctorModule.dart';

List<GetPage> doctorRoutes = [
  GetPage(name: '/doctor', page: () => DoctorPage()),
  GetPage(name: '/doctorProfile', page: () => DoctorProfilePage()),
];

