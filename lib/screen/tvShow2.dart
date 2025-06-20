// ignore_for_file: file_names
// // ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

// import 'package:apptvshow/color/colorapp.dart';
// import 'package:apptvshow/constant.dart';
// import 'package:apptvshow/modelview/model_suggested.dart';
// import 'package:apptvshow/screen/tvShow.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class TvShow2 extends StatefulWidget {
//   TvShow2(
//       {super.key,
//       this.chid,
//       this.ch_name,
//       this.ch_image,
//       this.chUrl,
//       this.ch_desc,
//       this.ch_type,
//       this.ch_videoid,
//       this.ctag_name,
//       this.web,
//       this.ch_useragent});

//   final chid;

//   final ch_name;
//   final ch_image;
//   final chUrl;
//   final ch_desc;
//   final ch_type;
//   final ch_videoid;
//   final web;
//   final ctag_name;
//   final ch_useragent;

//   @override
//   State<TvShow2> createState() => _TvShowState();
// }

// class _TvShowState extends State<TvShow2> {
//   ModelSuggested modelSuggested = Get.put(ModelSuggested());
//   @override
//   void initState() {
//     // modelSuggested.suggestedApp();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.black26,
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                 children: [
//                   Container(
//                       height: 450,
//                       width: double.infinity,
//                       child: CachedNetworkImage(
//                         imageUrl: widget.ch_image,
//                         height: 450,
//                         imageBuilder: (context, imageProvider) => Container(
//                           decoration: BoxDecoration(
//                             image: DecorationImage(
//                               image: imageProvider,
//                               fit: BoxFit.fill,
//                               // colorFilter: const ColorFilter.mode(
//                               //     Colors.deepPurple,
//                               //     BlendMode.colorBurn),
//                             ),
//                           ),
//                         ),
//                         placeholder: (context, url) =>
//                             Image.asset("images/tv.png"),
//                         errorWidget: (context, url, error) => Icon(Icons.error),
//                       )),
//                   Container(
//                     height: 450,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           Colors.black.withOpacity(0),
//                           Colors.black.withOpacity(0.4),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     right: 10,
//                     top: 30,
//                     child: CircleAvatar(
//                       radius: 25,
//                       backgroundColor: Colors.black.withOpacity(0.1),
//                       child: IconButton(
//                         onPressed: () {},
//                         icon: Icon(
//                           Icons.favorite,
//                           color: Colors.white,
//                           size: 30,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 10,
//                     top: 30,
//                     child: CircleAvatar(
//                       radius: 25,
//                       backgroundColor: Colors.black.withOpacity(0.1),
//                       child: IconButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                         icon: Icon(
//                           Icons.arrow_back_ios,
//                           color: Colors.white,
//                           size: 30,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 25,
//                     left: 20,
//                     child: Row(
//                       children: [
//                         Image.asset(
//                           "images/go3.png",
//                           height: 60,
//                           width: 60,
//                         ),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         const Text(
//                           "Watch Now",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold),
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Card(
//                     color: Colors.transparent,
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             widget.ch_name,
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(
//                             height: 15,
//                           ),
//                           Text(
//                             widget.ctag_name,
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   // Padding(
//                   //   padding: const EdgeInsets.only(right: 20),
//                   //   child: CircleAvatar(
//                   //     radius: 25,
//                   //     backgroundColor: Colors.black.withOpacity(0.3),
//                   //     child: IconButton(
//                   //       onPressed: () {},
//                   //       icon: Icon(
//                   //         Icons.favorite,
//                   //         color: Colors.white,
//                   //         size: 30,
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   widget.ch_desc,
//                   maxLines: 20,
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                       height: 1.5,
//                       color: Colors.white,
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               // FutureBuilder(
//               //   future: modelSuggested.suggestedApp(widget.web, widget.chid),
//               //   builder: (context, snapshot) => Container(
//               //     height: 270,
//               //     width: double.infinity,
//               //     child: ListView.builder(
//               //         itemCount: modelSuggested.movieshome.length,
//               //         scrollDirection: Axis.horizontal,
//               //         itemBuilder: (context, i) {
//               //           final chid = modelSuggested.movieshome[i].channelId;
//               //           final ch_name =
//               //               modelSuggested.movieshome[i].channelName;
//               //           final ch_image = "$UrlApp$upload" +
//               //               "${modelSuggested.movieshome[i].channelImage}";
//               //           final chUrl = modelSuggested.movieshome[i].channelUrl;
//               //           final ch_desc =
//               //               modelSuggested.movieshome[i].channelDescription;
//               //           final ch_type =
//               //               modelSuggested.movieshome[i].channelType;
//               //           final ch_videoid = modelSuggested.movieshome[i].videoId;
//               //           final ctag_name =
//               //               modelSuggested.movieshome[i].categoryName;
//               //           final ch_useragent =
//               //               modelSuggested.movieshome[i].userAgent;
//               //           final web = detail;
//               //           return InkWell(
//               //             onTap: () {
//               //               Get.to(TvShow(
//               //                   chid: chid,
//               //                   ch_desc: ch_desc,
//               //                   ch_image: ch_image,
//               //                   ch_name: ch_name,
//               //                   ch_type: ch_type,
//               //                   chUrl: chUrl,
//               //                   ch_videoid: ch_videoid,
//               //                   ch_useragent: ch_useragent,
//               //                   ctag_name: ctag_name,
//               //                   web: web));
//               //             },
//               //             child: Padding(
//               //               padding: const EdgeInsets.all(8.0),
//               //               child: Container(
//               //                 // color: Colors.yellow,
//               //                 width: 150,
//               //                 child: Column(
//               //                   children: [
//               //                     Stack(
//               //                       children: [
//               //                         ClipRRect(
//               //                           borderRadius: BorderRadius.circular(25),
//               //                           child: CachedNetworkImage(
//               //                             imageUrl: modelSuggested
//               //                                     .movieshome.isEmpty
//               //                                 ? imagesloding
//               //                                 : "$UrlApp$upload" +
//               //                                     "${modelSuggested.movieshome[i].channelImage}",
//               //                             height: 200,
//               //                             imageBuilder:
//               //                                 (context, imageProvider) =>
//               //                                     Container(
//               //                               decoration: BoxDecoration(
//               //                                 image: DecorationImage(
//               //                                   image: imageProvider,
//               //                                   fit: BoxFit.fill,
//               //                                   // colorFilter:
//               //                                   //     ColorFilter.mode(Colors.red, BlendMode.darken),
//               //                                 ),
//               //                               ),
//               //                             ),
//               //                             placeholder: (context, url) => Center(
//               //                               child: Container(
//               //                                 child:
//               //                                     Image.asset("images/tv.png"),
//               //                               ),
//               //                             ),
//               //                             errorWidget: (context, url, error) =>
//               //                                 const Icon(Icons.error),
//               //                           ),
//               //                         ),
//               //                         Positioned(
//               //                           right: 10,
//               //                           top: 10,
//               //                           child: Container(
//               //                             decoration: const BoxDecoration(
//               //                                 borderRadius: BorderRadius.only(
//               //                                     topRight: Radius.circular(20),
//               //                                     bottomLeft:
//               //                                         Radius.circular(20)),
//               //                                 color: Colors.red),
//               //                             child: Padding(
//               //                               padding: const EdgeInsets.all(5.0),
//               //                               child: Text(
//               //                                 modelSuggested.movieshome.isEmpty
//               //                                     ? "a"
//               //                                     : "${modelSuggested.movieshome[i].categoryName}",
//               //                                 style: const TextStyle(
//               //                                     fontSize: 10,
//               //                                     color: Colors.yellowAccent,
//               //                                     fontWeight: FontWeight.bold),
//               //                               ),
//               //                             ),
//               //                           ),
//               //                         )
//               //                       ],
//               //                     ),
//               //                     Padding(
//               //                       padding: const EdgeInsets.all(10.0),
//               //                       child: Container(
//               //                         alignment: Alignment.bottomLeft,
//               //                         child: Text(
//               //                           modelSuggested.movieshome.isEmpty
//               //                               ? "a"
//               //                               : "${modelSuggested.movieshome[i].channelName}",
//               //                           style: TextStyle(
//               //                               overflow: TextOverflow.ellipsis,
//               //                               fontSize: 15,
//               //                               color: Colors.white,
//               //                               fontWeight: FontWeight.bold),
//               //                         ),
//               //                       ),
//               //                     ),
//               //                   ],
//               //                 ),
//               //               ),
//               //             ),
//               //           );
//               //         }),
//               //   ),
//               // )
//             ],
//           ),
//         ));
//   }
// }
