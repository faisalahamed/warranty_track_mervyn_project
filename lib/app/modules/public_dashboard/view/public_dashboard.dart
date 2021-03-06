// import 'package:flutter/material.dart';
// import 'package:get/state_manager.dart';
// import 'package:warranty_track/app/modules/public_dashboard/controller/public_dashboard_controller.dart';
// import 'package:warranty_track/common/constants.dart';
// import 'package:warranty_track/common/transaction_list_widget.dart';

// class PublicDashboard extends GetView<PublicDashboardController> {
//   const PublicDashboard({Key? key}) : super(key: key);

//   // List<String> selectedCategories = [];
//   // DateTime? _start;
//   // DateTime? _end;
//   // TransactionController transactionController = Get.find();
//   // AuthService _authService = Get.find();

//   // categoryWiseFilterDialogue() {
//   //   showDialog(
//   //       context: context,
//   //       builder: (BuildContext context) {
//   //         return CategoryFilterDialogue(func: (value) {
//   //           selectedCategories = value;
//   //           setState(() {});
//   //         });
//   //       });
//   // }

//   // dateWiseFilterDialogue() {
//   //   showDialog(
//   //       context: context,
//   //       builder: (BuildContext context) {
//   //         return DateFilterDialogue(func: (DateTime? start, DateTime? end) {
//   //           _start = start;
//   //           _end = end;
//   //           setState(() {});
//   //         });
//   //       });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: false,
//         title: const Text("Global Transactions"),
//         backgroundColor: AppColor.primaryColor,
//         elevation: 0,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 18),
//             child: GestureDetector(
//               onTap: () {
//                 // categoryWiseFilterDialogue();
//               },
//               child: Image(
//                 image: AssetImage(AppIcons.filter),
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           const SizedBox(
//             width: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 18),
//             child: GestureDetector(
//               onTap: () {
//                 // dateWiseFilterDialogue();
//               },
//               child: Image(
//                 image: AssetImage(AppIcons.calendar),
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           const SizedBox(
//             width: 20,
//           ),
//         ],
//       ),
//       body:
//           // transactionController.addintorxlist(_translist);
//           Obx(
//         () => TransactionListWidget(
//           translist: controller.transactionStreamList.value,
//           isReport: true,
//         ),
//       ),
//     );
//   }
// }

// // class TransactionListWidget extends StatelessWidget {
// //   const TransactionListWidget({
// //     Key? key,
// //     required this.transactionList,
// //   }) : super(key: key);

// //   final List<TransactionModel> transactionList;

// //   @override
// //   Widget build(BuildContext context) {
// //     List<Color> _rendColor = [
// //       AppColor.successColor,
// //       AppColor.secondaryColor,
// //       Colors.blue,
// //     ];
// //     return SingleChildScrollView(
// //       child: ListView.builder(
// //         padding: const EdgeInsets.symmetric(vertical: 3),
// //         shrinkWrap: true,
// //         physics: const NeverScrollableScrollPhysics(),
// //         itemCount: transactionList.length,
// //         itemBuilder: (context, index) {
// //           return GestureDetector(
// //             onTap: () {
// //               // Get.to(
// //               //   () => TransactionDetailScreen(
// //               //     transectionItem: _translist[index],
// //               //   ),
// //               // );
// //             },
// //             child: Container(
// //               margin: const EdgeInsets.symmetric(vertical: 3),
// //               decoration: const BoxDecoration(
// //                 color: Colors.white,
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.black12,
// //                     spreadRadius: 1,
// //                     blurRadius: 10,
// //                   ),
// //                 ],
// //               ),
// //               child: Row(
// //                 children: [
// //                   Expanded(
// //                     child: Padding(
// //                       padding: const EdgeInsets.symmetric(horizontal: 10),
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Padding(
// //                             padding: const EdgeInsets.only(right: 15, top: 10),
// //                             child: Row(
// //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                               children: [
// //                                 Text(
// //                                   DateFormat("dd-MM-yyyy").format(
// //                                       DateTime.parse(
// //                                           transactionList[index].dateadded)),
// //                                   style: TextStyle(
// //                                     color: AppColor.primaryColor,
// //                                   ),
// //                                 ),
// //                                 Text(
// //                                   DateFormat("hh : mm a").format(DateTime.parse(
// //                                       transactionList[index].dateadded)),
// //                                   style: TextStyle(
// //                                     color: AppColor.primaryColor,
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                           const SizedBox(
// //                             height: 8,
// //                           ),
// //                           Text(
// //                             transactionList[index].itemname,
// //                             style: TextStyle(
// //                               color: AppColor.primaryColor,
// //                               fontWeight: FontWeight.bold,
// //                               fontSize: 16,
// //                             ),
// //                             maxLines: 1,
// //                             overflow: TextOverflow.ellipsis,
// //                           ),
// //                           const SizedBox(
// //                             height: 12,
// //                           ),
// //                           Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               ConstrainedBox(
// //                                 constraints:
// //                                     const BoxConstraints(maxWidth: 125.0),
// //                                 child: Container(
// //                                   decoration: BoxDecoration(
// //                                     color: _rendColor[
// //                                         Random().nextInt(_rendColor.length)],
// //                                     borderRadius: BorderRadius.circular(3),
// //                                   ),
// //                                   padding: const EdgeInsets.symmetric(
// //                                       horizontal: 20, vertical: 6),
// //                                   child: Text(
// //                                     transactionList[index].category,
// //                                     style: const TextStyle(
// //                                       color: Colors.black,
// //                                       fontWeight: FontWeight.w500,
// //                                       overflow: TextOverflow.ellipsis,
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                               SizedBox(
// //                                 width: 100,
// //                                 child: Text(
// //                                     transactionList[index].price == ""
// //                                         ? "RM  0.00"
// //                                         : "RM  ${transactionList[index].price}",
// //                                     style: TextStyle(
// //                                       color: transactionList[index].color,
// //                                       fontWeight: FontWeight.bold,
// //                                       fontSize: 18,
// //                                     ),
// //                                     overflow: TextOverflow.ellipsis),
// //                               ),
// //                             ],
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                   CachedNetworkImage(
// //                     imageUrl: transactionList[index].image == "null"
// //                         ? transactionList[index].rimage
// //                         : transactionList[index].image,
// //                     placeholder: (context, url) => Container(
// //                       color: Colors.black12,
// //                       alignment: Alignment.center,
// //                       child: const CircularProgressIndicator(),
// //                     ),
// //                     errorWidget: (context, url, error) =>
// //                         const Icon(Icons.error),
// //                     // height: size.height,
// //                     width: 140,
// //                     fit: BoxFit.cover,
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
