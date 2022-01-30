import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

// import 'package:permission_handler/permission_handler.dart';
import 'package:warranty_track/app/model/category_model.dart';
import 'package:warranty_track/app/modules/auth/controller/login_controller.dart';
import 'package:warranty_track/app/modules/home/controller/home_controller.dart';
import 'package:warranty_track/app/modules/home/view/home_widgets/map_dialog.dart';
import 'package:warranty_track/app/modules/transaction_details/controller/setting_controller.dart';
import 'package:warranty_track/app/service/firebase_config.dart';
import 'package:warranty_track/common/common.dart';
import 'package:warranty_track/common/constants.dart';
import 'package:warranty_track/common/date_time_calculation.dart';
import 'package:warranty_track/common/my_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image;
  File? _receiptImage;
  File? _sellerimage;
  File? _profilePic;
  final picker = ImagePicker();
  String? selectedString;
  LocationData? locationData;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  HomeViewController homeScreenController = Get.find();
  late bool permissionGranted;
  final SettingController _settingController = Get.find();
  final LoginController _loginController = Get.find();
  String? _warrantyYear = '1';

  late double timeDilation;

  Future<void> showImagePickerOption({required String title}) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 25,
              ),
              Container(
                height: 3,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Gallery Image'),
                onTap: () {
                  Navigator.pop(context);
                  getImage(title: title, imageSource: ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  getImage(title: title, imageSource: ImageSource.camera);
                },
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          );
        });
  }

  Future<void> showLogoutPopup({required String title}) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 25,
              ),
              Container(
                height: 3,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: const Icon(Icons.logout_sharp),
                title: const Text('Logout'),
                onTap: () {
                  // Navigator.pop(context);
                  _loginController.logout();
                },
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          );
        });
  }

  Widget textFieldContainer(
      {String? title,
      int maxline = 1,
      bool readonly = false,
      TextEditingController? controll,
      TextInputType? textInputType}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        readOnly: readonly,
        keyboardType: textInputType,
        controller: controll,
        maxLines: maxline,
        decoration: InputDecoration(
          label: Text(title!),
          border: InputBorder.none,
          // hintText: title,
          hintStyle: TextStyle(
            color: AppColor.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future getImage({String? title, required ImageSource imageSource}) async {
    final pickedFile =
        await picker.pickImage(source: imageSource, imageQuality: 15);
    setState(() {
      if (pickedFile != null) {
        if (title == 'Image') {
          _image = File(pickedFile.path);
        } else if (title == 'Receipt') {
          _receiptImage = File(pickedFile.path);
        } else if (title == 'Seller') {
          _sellerimage = File(pickedFile.path);
        } else {
          _profilePic = File(pickedFile.path);
        }
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  Widget imagePicContainer(
      {Size? size,
      String? title,
      Function()? onTap,
      Color? color,
      IconData? icon,
      File? pickImage}) {
    Color? colorChange() {
      if (title == 'Image') {
        return AppColor.primaryColor;
      } else {
        return AppColor.primaryColor;
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: size!.height * 0.21,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: pickImage == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon == null
                      ? Icon(
                          Icons.camera_alt,
                          color: colorChange(),
                          size: 60,
                        )
                      : Icon(
                          icon,
                          color: colorChange(),
                          size: 60,
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    title!,
                    style: TextStyle(
                      fontSize: 18,
                      color: colorChange(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image(
                  image: FileImage(pickImage),
                  fit: BoxFit.cover,
                  width: size.width,
                  height: size.height,
                ),
              ),
      ),
    );
  }

  // Future _getStoragePermission() async {
  //   if (await Permission.storage.request().isGranted) {
  //     setState(() {
  //       permissionGranted = true;
  //     });
  //   } else if (await Permission.storage.request().isPermanentlyDenied) {
  //     await openAppSettings();
  //   } else if (await Permission.storage.request().isDenied) {
  //     await _getStoragePermission();
  //   }
  // }

  _selectDate(BuildContext context) async {
    int intitialDate = homeScreenController.warrantyTillDate.text != 'Lifetime'
        ? int.parse(homeScreenController.warrantyTillDate.text)
        : DateTime.now().millisecondsSinceEpoch;
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.fromMillisecondsSinceEpoch(intitialDate),
        firstDate: DateTime(2000),
        lastDate: DateTime(2120));
    if (pickedDate == null) {
      // return DateTime.fromMillisecondsSinceEpoch(intitialDate);
      homeScreenController.warrantyTillDate.text = intitialDate.toString();
    } else {
      setState(() {
        homeScreenController.warrantyTillDate.text =
            pickedDate.millisecondsSinceEpoch.toString();
      });
    }
  }

  setDefaultWarrantyDate() {
    homeScreenController.warrantyTillDate.text = DateTime.now()
        .add(const Duration(days: 365))
        .millisecondsSinceEpoch
        .toString();
    _warrantyYear = '1';
  }

  @override
  void initState() {
    super.initState();
    // _getStoragePermission();
    setDefaultWarrantyDate();
  }

  @override
  void dispose() {
    homeScreenController.onClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Stream _api =
        FirebaseConf().fref.reference().child("Categories").onValue;

    return Scaffold(
      key: _key,
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: AppColor.primaryColor,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          elevation: 0,
        ),
        preferredSize: const Size.fromHeight(0),
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColor.primaryColor,
          appBarTheme: AppBarTheme(
            color: AppColor.primaryColor,
          ),
        ),
        child: const MyNavigationDrawer(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: AppColor.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      _key.currentState!.openDrawer();
                      FocusScope.of(context).unfocus();
                    },
                    child: Image(
                      image: AssetImage(AppIcons.drawer),
                      width: 25,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // showImagePickerOption(title: 'Profile');
                      showLogoutPopup(title: 'Logout');
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: _profilePic != null
                            ? Image(
                                image: FileImage(
                                  _profilePic!,
                                ),
                                fit: BoxFit.cover,
                              )
                            : Image(
                                image: AssetImage(
                                  AppImages.profilePic,
                                ),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: size.height * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(size.width, 50.0)),
                    color: AppColor.primaryColor,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Choose Your Category',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Select Category

                      SizedBox(
                        height: size.height * 0.045,
                        width: size.width * 1,
                        child: StreamBuilder(
                          stream: _api,
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snap) {
                            if (snap.hasData &&
                                snap.data.snapshot.value != null) {
                              List<CategoryModel> _catList = [];
                              Map data = snap.data.snapshot.value;
                              data.forEach(
                                (key, value) {
                                  _catList.add(CategoryModel(
                                      id: key,
                                      catName: value['name'],
                                      count: value['count']));
                                },
                              );

                              if (_catList.length > 1) {
                                _catList.sort((a, b) {
                                  return a.count.compareTo(b.count);
                                });
                              }

                              _settingController.getCatData(_catList);

                              return ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _catList.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        setState(() {
                                          selectedString =
                                              _catList[index].catName;
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: selectedString ==
                                                  _catList[index].catName
                                              ? AppColor.secondaryColor
                                              : AppColor.primaryColor,
                                        ),
                                        child: Text(
                                          _catList[index].catName,
                                          style: TextStyle(
                                            color: selectedString ==
                                                    _catList[index].catName
                                                ? AppColor.primaryColor
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Image Picker
                Positioned(
                  top: size.height * 0.145,
                  child: SizedBox(
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: imagePicContainer(
                                pickImage: _image,
                                color: const Color(0xffFFBF2A),
                                title: 'Image',
                                size: size,
                                onTap: () {
                                  showImagePickerOption(title: 'Image');
                                }),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: imagePicContainer(
                                pickImage: _receiptImage,
                                color: const Color(0xffFF5A62),
                                title: 'Receipt',
                                size: size,
                                onTap: () {
                                  showImagePickerOption(title: 'Receipt');
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // input field
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.378),
                  width: size.width,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: Column(
                      children: [
                        textFieldContainer(
                          title: 'Item Name',
                          controll: homeScreenController.itemname,
                        ),
                        textFieldContainer(
                          textInputType: TextInputType.number,
                          title: 'Amount (Optional)',
                          controll: homeScreenController.amount,
                        ),

                        const SizedBox(height: 8),

                        // Expansion of Advance Input
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: ExpansionTile(
                            backgroundColor: const Color(0xffe8e8f1),
                            collapsedBackgroundColor: const Color(0xffe8e8f1),
                            collapsedTextColor: AppColor.textSecondarycolor,
                            initiallyExpanded: false,
                            iconColor: AppColor.textPrimarycolor,
                            onExpansionChanged: (val) {
                              if (!val) {
                                _sellerimage = null;
                                homeScreenController.shopPurchached.text = '';
                                homeScreenController.personWhoServed.text = '';
                                homeScreenController.note.text = '';
                                homeScreenController.isLocation.value = false;
                                resetLocation();
                                setDefaultWarrantyDate();

                                setState(() {});
                              }
                            },
                            title: ListTile(
                              title: Text(
                                'Advance input',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.textSecondarycolor),
                              ),
                            ),
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              // Date Warranty
                              Container(
                                color: Colors.white,
                                child: Container(
                                    height: 80,
                                    margin: const EdgeInsets.only(
                                        top: 16, bottom: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: ListTile(
                                        title: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: _warrantyYear == '1'
                                                ? Center(
                                                    child: Text(
                                                      '1',
                                                      style: TextStyle(
                                                          color: AppColor
                                                              .textSecondarycolor,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )
                                                : Center(
                                                    child: Text(
                                                      _warrantyYear!,
                                                      style: TextStyle(
                                                          color: AppColor
                                                              .textSecondarycolor,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                            isExpanded: true,
                                            iconSize: 30.0,
                                            style: const TextStyle(
                                                color: Colors.blue),
                                            items:
                                                AppConstants.dropdownYear.map(
                                              (val) {
                                                return DropdownMenuItem<String>(
                                                  value: val,
                                                  child: ListTile(
                                                      title: Text(val)),
                                                );
                                              },
                                            ).toList(),
                                            onChanged: (String? val) {
                                              setState(() {
                                                _warrantyYear = val;
                                              });
                                              if (val != 'Lifetime') {
                                                DateTime t = DateTime.now();

                                                var newDate = DateTime(
                                                    t.year + int.parse(val!),
                                                    t.month,
                                                    t.day);
                                                homeScreenController
                                                        .warrantyTillDate.text =
                                                    newDate
                                                        .millisecondsSinceEpoch
                                                        .toString();
                                              } else {
                                                homeScreenController
                                                    .warrantyTillDate
                                                    .text = "Lifetime";
                                              }
                                            },
                                          ),
                                        ),
                                        subtitle: const Padding(
                                          padding: EdgeInsets.only(left: 18.0),
                                          child: Text('Warranty Year'),
                                        ),
                                        trailing: Column(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                homeScreenController
                                                            .warrantyTillDate
                                                            .text !=
                                                        'Lifetime'
                                                    ? MyDateCalculation()
                                                        .timestampToDate(
                                                            homeScreenController
                                                                .warrantyTillDate
                                                                .text)
                                                    : 'Lifetime',
                                              ),
                                            ),
                                            Expanded(
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .resolveWith(
                                                  (states) =>
                                                      AppColor.primaryColor,
                                                )),
                                                child: const Text(
                                                    'Warranty Expiry'),
                                                onPressed: () {
                                                  // homeScreenController
                                                  //     .warrantyTillDate.text = 'adsf';

                                                  _selectDate(context);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              ),
                              // Shop Purchased
                              Container(
                                color: Colors.white,
                                child: textFieldContainer(
                                  textInputType: TextInputType.name,
                                  title: 'Shop Purchased',
                                  controll: homeScreenController.shopPurchached,
                                ),
                              ),
                              // Person who served you
                              Container(
                                color: Colors.white,
                                child: textFieldContainer(
                                  textInputType: TextInputType.name,
                                  title: 'Person who served you',
                                  controll:
                                      homeScreenController.personWhoServed,
                                ),
                              ),

                              // Location
                              Container(
                                color: Colors.white,
                                child: Container(
                                  color: Colors.white,
                                  margin: const EdgeInsets.only(
                                      top: 8, bottom: 8, left: 20, right: 15),
                                  child: Obx(
                                    () => Row(
                                      children: [
                                        const Expanded(
                                            flex: 3,
                                            child: Text(
                                              'Location:',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black87),
                                            )),
                                        Expanded(
                                          flex: 6,
                                          child: homeScreenController
                                                  .isLocation.value
                                              ? Column(
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Latitute: ${homeScreenController.lat.toStringAsPrecision(5)}',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16),
                                                        ),
                                                        Text(
                                                          'Longitute:  ${homeScreenController.long.toStringAsPrecision(5)}',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    ElevatedButton(
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .resolveWith(
                                                        (states) => AppColor
                                                            .primaryColor,
                                                      )),
                                                      child: const Text(
                                                          'Change on Map'),
                                                      onPressed: () {
                                                        // homeScreenController
                                                        //     .warrantyTillDate.text = 'adsf';

                                                        // _selectDate(context);

                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return MapPopupDialog(
                                                                lat:
                                                                    homeScreenController
                                                                        .lat
                                                                        .value,
                                                                long:
                                                                    homeScreenController
                                                                        .long
                                                                        .value,
                                                              );
                                                            });
                                                      },
                                                    ),
                                                  ],
                                                )
                                              : const SizedBox(),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Switch(
                                              activeColor:
                                                  AppColor.primaryColor,
                                              value: homeScreenController
                                                  .isLocation.value,
                                              onChanged: (val) {
                                                homeScreenController.isLocation
                                                    .toggle();

                                                val
                                                    ? homeScreenController
                                                        .getCurrentLocation()
                                                    : resetLocation();
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Note
                              Container(
                                color: Colors.white,
                                child: textFieldContainer(
                                  textInputType: TextInputType.multiline,
                                  title: 'Note',
                                  controll: homeScreenController.note,
                                  maxline: 2,
                                ),
                              ),
                              // Seller Image
                              Container(
                                color: Colors.white,
                                child: Container(
                                  color: Colors.white,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Expanded(
                                      //   flex: 1,
                                      //   child: mapViewWidget(size),
                                      // ),
                                      // const SizedBox(width: 8),
                                      Expanded(
                                        flex: 1,
                                        child: imagePicContainer(
                                            pickImage: _sellerimage,
                                            color: const Color(0xffFF5A62),
                                            title: 'Seller',
                                            size: size,
                                            icon: Icons.people_alt,
                                            onTap: () {
                                              showImagePickerOption(
                                                  title: 'Seller');
                                            }),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // success show and submit button

                        Obx(
                          () => homeScreenController.loading.isFalse
                              ? Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 20),
                                  child: GestureDetector(
                                    onTap: () {
                                      homeScreenController.homeScreenDataGet(
                                        image: _image,
                                        receiptImage: _receiptImage,
                                        sellerimage: _sellerimage,
                                        category: selectedString,
                                        warrantyyearcount: _warrantyYear,
                                        func: () {
                                          homeScreenController.loading.value =
                                              false;
                                          homeScreenController.amount.text = '';
                                          homeScreenController.itemname.text =
                                              '';

                                          _receiptImage = null;
                                          _image = null;
                                          _sellerimage = null;

                                          CommonFunc().customSuccessSnackbar(
                                              msg: 'Receipt added successfully',
                                              isTrue: false);
                                          setState(() {});
                                        },
                                        nofunc: () {},
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15,
                                      ),
                                      width: size.width,
                                      decoration: BoxDecoration(
                                        color: AppColor.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Submit',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: AppColor.textPrimarycolor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 20),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                    ),
                                    width: size.width,
                                    decoration: BoxDecoration(
                                      color: AppColor.secondaryColor,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Uploading.....',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: AppColor.primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  resetLocation() {
    homeScreenController.lat.value = 0.0;
    homeScreenController.long.value = 0.0;
  }

  // Widget mapViewWidget(Size size) {
  //   return Container(
  //       alignment: Alignment.center,
  //       height: size.height * 0.21,
  //       decoration: BoxDecoration(
  //         color: const Color(0xffFFBF2A),
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: const [
  //           Icon(
  //             Icons.camera_alt,
  //             color: Colors.pink,
  //             size: 60,
  //           ),
  //           const SizedBox(
  //             height: 10,
  //           ),
  //           Text(
  //             'title!',
  //             style: TextStyle(
  //               fontSize: 18,
  //               color: Colors.white,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ],
  //       ));
  // }

}
