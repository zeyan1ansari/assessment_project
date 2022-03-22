// import 'package:flutter/material.dart';
// import 'package:inview_notifier_list/inview_notifier_list.dart';
//
// class Example extends StatefulWidget {
//   const Example({Key? key}) : super(key: key);
//
//   @override
//   _ExampleState createState() => _ExampleState();
// }
//
// class _ExampleState extends State<Example> {
//   @override
//   Widget build(BuildContext context) {
//     return InViewNotifierList(
//       isInViewPortCondition:
//           (double deltaTop, double deltaBottom, double vpHeight) {
//         return deltaTop < (0.5 * vpHeight) && deltaBottom > (0.5 * vpHeight);
//       },
//       itemCount: 10,
//       builder: (BuildContext context, int index) {
//         return InViewNotifierWidget(
//           id: '$index',
//           builder: (BuildContext context, bool isInView, _) {
//             return Container(
//               height: MediaQuery.of(context).size.height,
//               width: MediaQuery.of(context).size.width,
//               decoration: const BoxDecoration(
//                 color: Colors.black,
//
//               ),
//               child: Stack(
//                 children: [
//                   Container(color: Colors.white, height: MediaQuery.of(context).size.height,
//                     width: MediaQuery.of(context).size.width,
//                     child: Image.network(data[index].imageUrl),
//                   ),
//                   Container(padding: EdgeInsets.all(15),width: MediaQuery.of(context).size.width,
//                     child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
//                       children:  [
//                         Icon(Icons.chevron_left,size: 30,),
//                         Container(width: MediaQuery.of(context).size.width,
//                           child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//
//                               Container(width:MediaQuery.of(context).size.width*0.8,
//                                 child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                                   children:  [
//                                     Text(data[index].postDateStr,style: TextStyle(fontSize: 14),),
//                                     SizedBox(height: 5,),
//                                     Text(data[index].title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
//                                   ],
//                                 ),
//                               ),
//                               Column(children:  [
//                                 CircleAvatar(child: Icon(Icons.favorite_border,color: Colors.blueGrey,),backgroundColor: Colors.grey.withOpacity(0.25),),
//                                 const SizedBox(height: 8,),
//                                 CircleAvatar(child: Icon(Icons.comment,color: Colors.blueGrey),backgroundColor: Colors.grey.withOpacity(0.25),),
//                                 const SizedBox(height: 8,),
//                                 CircleAvatar(child: Icon(Icons.share,color: Colors.blueGrey),backgroundColor: Colors.grey.withOpacity(0.25),),
//                                 const SizedBox(height: 80,),
//                               ],),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
