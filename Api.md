
# APi

These method are used to api response get and post


## Post Api

#### App Service
```dart
 @override
  Future<ApiResponse> createService({required Map<String, dynamic> body}) async {
    return await Request.post('/url', body: body, authenticate: true);
  }
```
#### Mock Service
```dart
 @override
  Future<ApiResponse> createService({required Map<String, dynamic> body}) {
    // TODO: implement getData
    throw UnimplementedError();
  }
```
#### Service

```dart
Future<ApiResponse> createService({required Map<String, dynamic> body});
```


#### Controller
```dart
 Future<void> methodName() async {
     if (!formKey.currentState!.validate()) {
       return;
     }
    _servicename.init();
    Map<String, dynamic> body = {
      "key": value,
    };

    ApiResponse response = await _serviceService.createService(body: body);

    if (response.hasValidationErrors()) {
      Toastr.show(message: "${response.validationError}");
      return;
    }

    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      return;
    }
    await auth.getUser();
    _servicename.close();
    Get.back();
    Toastr.show(message: "${response.message}");
  }
```

## Get Api Single Variable

#### App Service
```dart
Future<ApiResponse> methodName() async {
    return await Request.get('/url', authenticate: true);
  }
```
#### Mock Service
```dart
 Future<ApiResponse> methodName() {
    // TODO: implement methodName
    throw UnimplementedError();
  }
```
#### Service
```dart
Future<ApiResponse> methodName();
```
### Controller

#### Observables
```dart
 var _variableName = ModelName().obs;
```
#### Getters
```dart
 ModelName get variableName => _variableName.value;
```
#### Method
```dart
Future<void> methodName({bool immediate = false}) async {
    if (!immediate) setBusy(true);
    setBusy(true);
    _serviceService.init();

    ApiResponse response = await _serviceService.methodName();

    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      setBusy(false);
      return;
    }

    if (response.hasData()) {
      _variableName(ModelName.fromJson(response.data));
      }
    } 
  
    setBusy(false);
    _serviceService.close();
  }
```


## Get Api List Variable

#### App Service
```dart
Future<ApiResponse> methodName() async {
    return await Request.get('/url', authenticate: true);
  }
```
#### Mock Service
```dart
 Future<ApiResponse> methodName() {
    // TODO: implement methodName
    throw UnimplementedError();
  }
```
#### Service
```dart
Future<ApiResponse> methodName();
```
### Controller

#### Observables
```dart
 var _variableName = <ModelName>[].obs;
 var _page = 1.obs;
 var _dataEnded = false.obs;
 var _loadingMore = false.obs;
```
#### Getters
```dart
 List<ModelName> get variableName => _variableName;
 bool get loadingMore => _loadingMore.value;value;
```
* Initialize Method to onInit
```dart
 @override
  void onInit() async {
    super.onInit();
    methodName();
    scrollController.addListener(() {
      if (double.parse((scrollController.positions.last.maxScrollExtent - 10).toString()) <= scrollController.positions.last.pixels) {
        if (!_dataEnded.value) methodName(next: true);
      }
    });
  }
``` 

#### Method
```dart
 Future<void> methodName({bool refresh = false, bool next = false}) async {
    _serviceService.init();
    if (!refresh && !next) setBusy(true);
    if (next) setBusy(false);
    if (next) _loadingMore(true);
    if (next) _page(_page.value + 1);

    ApiResponse response = await _serviceService.methodName(page: _page.value);

    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      setBusy(false);
      return;
    }

    if (response.hasData()) {
      if (next) {
        _variableName.addAll(List<ModelName>.from(response.data.map((x) => ModelName.fromJson(x))));
      } else {
        _variableName.assignAll(List<ModelName>.from(response.data.map((x) => ModelName.fromJson(x))));
      }
    } else {
      if (!next) {
        _variableName.clear();
      }
      _dataEnded(true);
    }
    _loadingMore(false);
    _serviceService.close();
    setBusy(false);
  }
```

* SingleChildScrollView add controller
```dart
controller: controller.scrollController,
```
* Add this loading at the end of the page

```dart
 ///Loading Widget
  Obx(() => active
        ? Container(
            decoration: BoxDecoration(
              color: kcWhite,
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            child: LoadingIcon(),
          )
        : SizedBox.shrink()),

```

## Delete Api

#### App Service
```dart
 @override
  Future<ApiResponse> deleteMethodName({required int id}) async {
    return await Request.get('/url/$id/remove', authenticate: true);
  }
```

#### Mock Service
```dart
 @override
  Future<ApiResponse> deleteMethodName({required int id}) {
    // TODO: implement deleteMethodName
    throw UnimplementedError();
  }
```
#### Service
```dart
  Future<ApiResponse> deleteMethodName({required int id});
```

#### Controller
```dart
Future<void> deleteMethodName({required int id}) async {
    try {
      _serviceService.init();
      ApiResponse response = await _serviceService.deleteMethodName(id: id);

      if (response.hasError()) {
        Toastr.show(message: "${response.message}");
        setBusy(false);
        return;
      } else {
        Toastr.show(message: "Deleted successful");
        setBusy(false);
        _serviceService.close();
        Get.back();
      }
    } on Exception catch (e) {
      Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    }
  }
```

## Set data

### Controller

Put the authentication data in the input box
#### Variables
```dart
TextEditingController firstNameInput = TextEditingController();
```

#### Method
```dart
  void setData() async {
    setBusy(true);
    firstNameInput.text = auth.user.name!.contains("Guest") || auth.user.name == null ? "" : auth.user.name!;
  // More data sets to be added.
    setBusy(false);
  }
```
#### onInit
``` dart
 @override
  Future<void> onInit() async {
    super.onInit();
    setData();
  }
```
