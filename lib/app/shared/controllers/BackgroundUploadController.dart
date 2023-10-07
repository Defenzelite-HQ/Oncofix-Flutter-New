// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter_uploader/flutter_uploader.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:workmanager/workmanager.dart';
// import '../../helpers/Global.dart';
//
// class BackgroundUploadController extends GetxController {
//   static final BackgroundUploadController instance = Get.find<BackgroundUploadController>();
//
//
//  // static const task = "firstTask";
//  //  setData() {
//  //    print('SetData @@@ ');
//  //  }
//  //
//  //  void callbackDispatcher() {
//  //    Workmanager().executeTask((taskName, inputData) {
//  //      switch (taskName) {
//  //        case "firstTask":
//  //          setData();
//  //          break;
//  //        default:
//  //      }
//  //      return Future.value(true);
//  //    });
//  //  }
//
//   var _uploader = FlutterUploader().obs;
//   var _tasks = Map().obs;
//   final ImagePicker _picker = ImagePicker();
//   final videoPicker = ImagePicker();
//   var _uploadId = 1.obs;
//   var _selectedImages = <File>[].obs;
//   var _selectedImage = File('').obs;
//   var _selectedVideo = File('').obs;
//
//   String title = "FileUpload Sample app";
//   String uploadURL = "https://us-central1-flutteruploader.cloudfunctions.net/upload";
//
//   String uploadBinaryURL = "https://us-central1-flutteruploader.cloudfunctions.net/upload/binary";
//   // static const simpleTaskKey = "be.tramckrijte.workmanagerExample.simpleTask";
//   // static const rescheduledTaskKey = "be.tramckrijte.workmanagerExample.rescheduledTask";
//   // static const failedTaskKey = "be.tramckrijte.workmanagerExample.failedTask";
//   // static const simpleDelayedTask = "be.tramckrijte.workmanagerExample.simpleDelayedTask";
//   // static const simplePeriodicTask =
//   //     "be.tramckrijte.workmanagerExample.simplePeriodicTask";
//   // static const simplePeriodic1HourTask =
//   //     "be.tramckrijte.workmanagerExample.simplePeriodic1HourTask";
//
//
//   FlutterUploader get uploader => _uploader.value;
//
//   int get uploadId => _uploadId.value;
//
//   Iterable get tasks => _tasks.values;
//
//   List<File> get selectedImages => _selectedImages;
//
//   File get selectedImage => _selectedImage.value;
//
//   // Map<String, UploadItem> _tasks = {};
//   // FlutterUploader uploader = FlutterUploader();
//   late StreamSubscription progressSubscription;
//   late StreamSubscription resultSubscription;
//
//   @override
//   void onInit() {
//     super.onInit();
//     progressSubscription = uploader.progress.listen((progress) {
//       final task = _tasks[progress.tag];
//       print("progress: ${progress.progress} , tag: ${progress.tag}");
//       if (task == null) return;
//       if (task.isCompleted()) return;
//       _tasks[progress.tag] = task.copyWith(progress: progress.progress, status: progress.status);
//     });
//     resultSubscription = uploader.result.listen((result) {
//       print(
//           "id: ${result.taskId}, status: ${result.status}, response: ${result.response}, statusCode: ${result.statusCode}, tag: ${result.tag}, headers: ${result.headers}");
//
//       final task = _tasks[result.tag];
//       if (task == null) return;
//       _tasks[result.tag] = task.copyWith(status: result.status);
//     }, onError: (ex, stacktrace) {
//       print("exception: $ex");
//       print("stacktrace: $stacktrace" ?? "no stacktrace");
//       final exp = ex as UploadException;
//       final task = _tasks[exp.tag];
//       if (task == null) return;
//       _tasks[exp.tag] = task.copyWith(status: exp.status);
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     progressSubscription.cancel();
//     resultSubscription.cancel();
//   }
//
//   // void callbackDispatcher() {
//   //   Workmanager().executeTask((task, inputData) async {
//   //     switch (task) {
//   //       case simpleTaskKey:
//   //         print("$simpleTaskKey was executed. inputData = $inputData");
//   //         final prefs = await SharedPreferences.getInstance();
//   //         prefs.setBool("test", true);
//   //         print("Bool from prefs: ${prefs.getBool("test")}");
//   //         break;
//   //       case rescheduledTaskKey:
//   //         final key = inputData!['key']!;
//   //         final prefs = await SharedPreferences.getInstance();
//   //         if (prefs.containsKey('unique-$key')) {
//   //           print('has been running before, task is successful');
//   //           return true;
//   //         } else {
//   //           await prefs.setBool('unique-$key', true);
//   //           print('reschedule task');
//   //           return false;
//   //         }
//   //       case failedTaskKey:
//   //         print('failed task');
//   //         return Future.error('failed');
//   //       case simpleDelayedTask:
//   //         print("$simpleDelayedTask was executed");
//   //         break;
//   //       case simplePeriodicTask:
//   //         print("$simplePeriodicTask was executed");
//   //         break;
//   //       case simplePeriodic1HourTask:
//   //         print("$simplePeriodic1HourTask was executed");
//   //         break;
//   //       case Workmanager.iOSBackgroundTask:
//   //         print("The iOS background fetch was triggered");
//   //         Directory? tempDir = await getTemporaryDirectory();
//   //         String? tempPath = tempDir.path;
//   //         print(
//   //             "You can access other plugins in the background, for example Directory.getTemporaryDirectory(): $tempPath");
//   //         break;
//   //     }
//   //
//   //     return Future.value(true);
//   //   });
//   // }
//
//
//
//   // void backgroundUploader(String filename, String savedDir) {
//   //   final taskId = uploader.enqueue(
//   //       url: "your upload link",
//   //       //required: url to upload to
//   //       files: [FileItem(filename: filename, savedDir: savedDir, fieldname: "file")],
//   //       // required: list of files that you want to upload
//   //       method: UploadMethod.POST,
//   //       // HTTP method  (POST or PUT or PATCH)
//   //       headers: {"apikey": "api_123456", "userkey": "userkey_123456"},
//   //       data: {"name": "mayank"},
//   //       // any data you want to send in upload request
//   //       showNotification: false,
//   //       // send local notification (android only) for upload status
//   //       tag: "upload 1"); // unique tag for upload task
//   //   _uploadId.value = int.parse(taskId.toString());
//   // }
//
//   String _uploadUrl({required bool binary}) {
//     if (binary) {
//       return uploadBinaryURL;
//     } else {
//       return uploadURL;
//     }
//   }
//
//   Future getImage({required bool binary}) async {
//     var image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 20);
//     if (image != null) {
//       // log.w("File Path @@ ${image.path}");
//       final String filename = image.path;
//       final String savedDir = image.path;
//       final tag = "image upload ${_tasks.length + 1}";
//       // log.w("image upload ${_tasks.length + 1}");
//       var url = _uploadUrl(binary: binary);
//       var fileItem = FileItem(
//         filename: filename,
//         savedDir: savedDir,
//         fieldname: "file",
//       );
//
//       var taskId = binary
//           ? await uploader.enqueueBinary(
//               url: url,
//               file: fileItem,
//               method: UploadMethod.POST,
//               tag: tag,
//               showNotification: true,
//             )
//           : await uploader.enqueue(
//               url: url,
//               data: {"name": "mayank"},
//               files: [fileItem],
//               method: UploadMethod.POST,
//               tag: tag,
//               showNotification: true,
//             );
//       _tasks.putIfAbsent(
//           tag,
//           () => UploadItem(
//                 id: taskId,
//                 tag: tag,
//                 type: MediaType.Video,
//                 status: UploadTaskStatus.enqueued,
//               ));
//       jsonEncode(_selectedImage(File(image.path)));
//     } else {
//       print('No image selected.');
//     }
//   }
//
//   void getMultipleImage({required bool binary}) async {
//     FilePickerResult? image = await FilePicker.platform.pickFiles(
//       allowMultiple: true,
//       type: FileType.custom,
//       allowCompression: true,
//       allowedExtensions: ['png', 'jpg', 'jpeg', 'webp', 'pdf'],
//     );
//     if (image != null) {
//       List<File> files = image.paths.map((path) => File(path!)).toList();
//       log.w(files);
//       log.w("File Path @@ ${image.files.first.toString()}");
//       final String filename = image.files.first.toString();
//       final String savedDir = image.files.first.toString();
//       final tag = "image upload ${_tasks.length + 1}";
//       log.w("image upload ${_tasks.length + 1}");
//       var url = _uploadUrl(binary: binary);
//       var fileItem = FileItem(
//         filename: filename,
//         savedDir: savedDir,
//         fieldname: "file",
//       );
//       var taskId = binary
//           ? await uploader.enqueueBinary(
//               url: url,
//               file: fileItem,
//               method: UploadMethod.POST,
//               tag: tag,
//               showNotification: true,
//             )
//           : await uploader.enqueue(
//               url: url,
//               data: {"name": "mayank"},
//               files: [fileItem],
//               method: UploadMethod.POST,
//               tag: tag,
//               showNotification: true,
//             );
//       _tasks.putIfAbsent(
//           tag,
//           () => UploadItem(
//                 id: taskId,
//                 tag: tag,
//                 type: MediaType.Video,
//                 status: UploadTaskStatus.enqueued,
//               ));
//       _selectedImages.addAll(files);
//       Workmanager.registerOneOffTask("1", "simpleTask", tag: "tag");
//     } else {
//       // Get.snackbar(
//       //   'Error',
//       //   ' No Image Selected',
//       //   snackPosition: SnackPosition.BOTTOM,
//       //   backgroundColor: kcPrimary,
//       //   colorText: kcWhite,
//       // );
//     }
//   }
//
//   Future getVideo({required bool binary}) async {
//     var video = await videoPicker.pickVideo(source: ImageSource.gallery);
//     if (video != null) {
//       final String savedDir = video.path;
//       final String filename = video.path;
//       final tag = "video upload ${_tasks.length + 1}";
//       final url = _uploadUrl(binary: binary);
//
//       var fileItem = FileItem(
//         filename: filename,
//         savedDir: savedDir,
//         fieldname: "file",
//       );
//
//       var taskId = binary
//           ? await uploader.enqueueBinary(
//               url: url,
//               file: fileItem,
//               method: UploadMethod.POST,
//               tag: tag,
//               showNotification: true,
//             )
//           : await uploader.enqueue(
//               url: url,
//               data: {"name": "mayank"},
//               files: [fileItem],
//               method: UploadMethod.POST,
//               tag: tag,
//               showNotification: true,
//             );
//
//       _tasks.putIfAbsent(
//           tag,
//           () => UploadItem(
//                 id: taskId,
//                 tag: tag,
//                 type: MediaType.Video,
//                 status: UploadTaskStatus.enqueued,
//               ));
//       jsonEncode(_selectedVideo(File(video.path)));
//     } else {
//       print('No image selected.');
//     }
//   }
//
//   Future cancelUpload(String id) async {
//     await uploader.cancel(taskId: id);
//   }
// }
//
//
//
//
//
// enum MediaType { Image, Video }
//
// class UploadItem {
//   final String? id;
//   final String? tag;
//   final MediaType? type;
//   final int progress;
//   final UploadTaskStatus status;
//
//   UploadItem({
//     this.id,
//     this.tag,
//     this.type,
//     this.progress = 0,
//     this.status = UploadTaskStatus.undefined,
//   });
//
//   UploadItem copyWith({UploadTaskStatus? status, int? progress}) =>
//       UploadItem(id: this.id, tag: this.tag, type: this.type, status: status ?? this.status, progress: progress ?? this.progress);
//
//   bool isCompleted() => this.status == UploadTaskStatus.canceled || this.status == UploadTaskStatus.complete || this.status == UploadTaskStatus.failed;
// }
