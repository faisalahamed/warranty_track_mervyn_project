import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:path_provider/path_provider.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:path/path.dart' as p;
import 'package:url_launcher/url_launcher.dart';
import 'package:warranty_track/app/model/secure_storage.dart';
import 'package:warranty_track/app/modules/export/controller/export_controller.dart';
import 'package:warranty_track/common/bloc/loading.dart';
import 'package:warranty_track/common/constants.dart';

class ExportsScreen extends StatefulWidget {
  const ExportsScreen({Key? key}) : super(key: key);

  @override
  _ExportScreenState createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportsScreen> {
  bool isLocalDownloadDone = false;
  String uploadStatus = 'remaining';
  final _loading = LoadingBloc();
  final _isSuccessful = LoadingBloc();
  late File csvFile;
  final storage = SecureStorage();
  // TransactionController transactionController = Get.find();
  ExportController exportController = Get.put(ExportController());

  static const _clientId =
      '478534178274-cmj10q2hpnptlomfegc92fcf6q914o85.apps.googleusercontent.com';
  static const _scopes = [ga.DriveApi.driveFileScope];

  //Upload File in Google Drive
  Future<void> upload(File file) async {
    final client = await getHttpClient();
    var drive = ga.DriveApi(client);

    await drive.files.create(ga.File()..name = p.basename(file.absolute.path),
        uploadMedia: ga.Media(file.openRead(), file.lengthSync()));
  }

  //Get Authenticated Http Client
  Future<http.Client> getHttpClient() async {
    //Get Credentials
    var credentials = await storage.getCredentials();

    if (credentials == null) {
      //Needs user authentication
      var authClient =
          await clientViaUserConsent(ClientId(_clientId), _scopes, (url) {
        //Open URL in Browser
        launch(url);
      });
      return authClient;
    } else {
      //Already Authenticated
      return authenticatedClient(
          http.Client(),
          AccessCredentials(
              AccessToken(
                  credentials['type'],
                  credentials['data'],
                  DateTime.parse(
                    credentials['expiry'],
                  )),
              credentials['refreshToken'],
              _scopes));
    }
  }

  Future<void> generateCSVFile() async {
    List<List<dynamic>> csvData = [
      <String>[
        'id',
        'Date',
        'Time',
        'Description',
        'category',
        'Price',
      ],
      ...exportController.transactionListRx.map((item) => [
            "${exportController.transactionListRx.indexOf(item) + 1}",
            DateFormat('dd-MM-yyyy').format(DateTime.parse(item.dateadded)),
            DateFormat('hhh:mm:ssa').format(DateTime.parse(item.dateadded)),
            item.itemname,
            item.category,
            item.price,
          ]),
    ];

    String csv = const ListToCsvConverter().convert(csvData);

    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/transactions.csv';
    final File file = File(path);
    await file.writeAsString(csv);

    csvFile = file;
    _isSuccessful.loadingsink.add(await exportController.saveImageLocal());
    _loading.loadingsink.add(false);
  }

  @override
  void dispose() {
    super.dispose();
    _loading.dispose();
    _isSuccessful.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Exports"),
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!isLocalDownloadDone)
            SizedBox(
              width: size.width,
              child: Row(
                children: [
                  Expanded(child: Container()),
                  StreamBuilder<bool>(
                      initialData: false,
                      stream: _isSuccessful.loadingstrim,
                      builder: (context, sucSnap) {
                        return StreamBuilder<bool>(
                          initialData: false,
                          stream: _loading.loadingstrim,
                          builder: (context, snapshot) {
                            if (snapshot.data!) {
                              return const CircularProgressIndicator();
                            } else {
                              return GestureDetector(
                                onTap: () async {
                                  _loading.loadingsink.add(true);
                                  if (!sucSnap.data!) {
                                    generateCSVFile();
                                  } else {
                                    isLocalDownloadDone =
                                        await exportController.downloadZip(
                                      csvFile,
                                      upload,
                                      (String value) {
                                        uploadStatus = value;
                                      },
                                      isUploadDrive: isLocalDownloadDone,
                                    );
                                    setState(() {});

                                    _isSuccessful.loadingsink
                                        .add(!sucSnap.data!);
                                    _loading.loadingsink.add(false);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.primaryColor,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 18, horizontal: 35),
                                  child: Column(
                                    children: [
                                      Image(
                                        image: AssetImage(AppIcons.export),
                                        color: Colors.white,
                                        height: 40,
                                        width: 40,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        !sucSnap.data!
                                            ? 'Export CSV'
                                            : 'Download ZIP',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      }),
                  Expanded(child: Container()),
                ],
              ),
            ),
          if (isLocalDownloadDone)
            SizedBox(
              width: size.width,
              child: Row(
                children: [
                  Expanded(child: Container()),
                  GestureDetector(
                    onTap: () async {
                      await exportController.downloadZip(csvFile, upload,
                          (String value) {
                        uploadStatus = value;
                        setState(() {});
                      }, isUploadDrive: isLocalDownloadDone);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 35, horizontal: 35),
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage(AppIcons.googleDrive),
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            uploadStatus == 'Completed'
                                ? 'BackUp Successfully Completed!!!'
                                : 'Upload Google Drive',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
