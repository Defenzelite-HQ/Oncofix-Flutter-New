import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:get/get.dart';
import 'package:oncofix/app/helpers/Global.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/Sizes.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/layouts/MasterLayout.dart';
import '../../../shared/views/widgets/LoadingIconWidget.dart';
import '../controllers/WebviewController.dart';

class WebviewPage extends StatelessWidget {
  late WebViewController webcontroller;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return GetBuilder<WebviewController>(
      init: WebviewController(),
      builder: (WebviewController controller) {
        return !controller.isConnected
            ? NotConnectedErrorPage()
            : controller.isBusy
                ? LoadingIconWidget(message: "Please wait...")
                : WillPopScope(
                    onWillPop: () async {
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.portraitUp,
                      ]);
                      if (controller.url
                          .split("?")
                          .first
                          .contains("https://oncofix.com/panel/user-profile")) {
                        await auth.getUser();
                      }
                      bool? goBack = await webcontroller.canGoBack();
                      if (goBack != true)
                        return true;
                      else {
                        webcontroller.goBack();
                        return false;
                      }
                    },
                    child: MasterLayout(
                      leading: IconButton(
                        icon: Icon(
                          Icons.west,
                          size: spacer5,
                        ),
                        onPressed: () async {
                          if (controller.url.split("?").first.contains(
                              "https://oncofix.com/panel/user-profile")) {
                            await auth.getUser();
                          }
                          Get.back();
                        },
                      ),
                      title: "${controller.pageTitle}",
                      body: Obx(
                        () => Stack(
                          children: [
                            if (!controller.isConnected)
                              Center(
                                child: NotConnectedErrorPage(),
                              )
                            else
                              WebView(
                                debuggingEnabled: true,
                                onWebViewCreated: (controller) =>
                                    webcontroller = controller,
                                initialUrl: controller.url,
                                javascriptMode: JavascriptMode.unrestricted,
                                onPageStarted: (url) {
                                  controller.onLoadingPercent(0);
                                },
                                onProgress: (progress) {
                                  controller.onLoadingPercent(progress);
                                },
                                onPageFinished: (finish) async {
                                  controller.onLoadingPercent(100);
                                },
                                onWebResourceError: (WebResourceError error) {
                                  log.e(
                                      "WebResourceError: ${error.description}");
                                  // if (error.errorCode == 100) {
                                  //   // Handle JavaScript errors here.
                                  //   log.e(
                                  //       "JavaScript error occurred on the web page.");
                                  // }
                                },
                                navigationDelegate:
                                    (NavigationRequest request) {
                                  log.w(controller.url);
                                  log.w(request.url);

                                  /// +++++++++++++++++++++
                                  /// Url Handlers
                                  /// +++++++++++++++++++++
                                  final List<Map<String, dynamic>> urlHandlers =
                                      [
                                    {
                                      "pattern": "whatsapp:",
                                      "scheme": "whatsapp"
                                    },
                                    {"pattern": "mailto:", "scheme": "email"},
                                    {"pattern": "tel:", "scheme": "tel"},
                                    {
                                      "pattern": "google.com/maps",
                                      "scheme": "map"
                                    },
                                    {"pattern": ".pdf", "scheme": "pdf"},
                                    {"pattern": "sms:", "scheme": "sms"},
                                    {
                                      "pattern": "content://media/",
                                      "scheme": "gallery"
                                    },
                                    {"pattern": "camera:", "scheme": "camera"},
                                  ];

                                  /// +++++++++++++++++++++
                                  /// For Loop to check condition for url
                                  /// +++++++++++++++++++++
                                  for (var handler in urlHandlers) {
                                    if (request.url
                                        .contains(handler["pattern"])) {
                                      launchUrl(Uri.parse(request.url),
                                          mode: LaunchMode.externalApplication);
                                      return NavigationDecision.prevent;
                                    }
                                  }
                                  if (request.url.startsWith('javascript:')) {
                                    return NavigationDecision.prevent;
                                  }
                                  return NavigationDecision.navigate;
                                },
                              ),
                            if (controller.loadingPercentage < 100)
                              LinearProgressIndicator(
                                value: controller.loadingPercentage / 100.0,
                                color: kcTabBar,
                                backgroundColor: kcOffWhite,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
      },
    );
  }
}
