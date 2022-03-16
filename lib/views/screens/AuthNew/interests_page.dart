// import 'package:flutter/material.dart';
// import 'package:tiktok_tutorial/Components/custom_button_inter.dart';
// import 'package:tiktok_tutorial/Components/custom_text_button.dart';
// import 'package:tiktok_tutorial/Theme/colors.dart';

// class InterestPage extends StatefulWidget {
//   const InterestPage({Key? key}) : super(key: key);

//   @override
//   _InterestPageState createState() => _InterestPageState();
// }

// class _InterestPageState extends State<InterestPage> {
//   double paddingHor = 24;
//   double paddingVert = 24;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           SizedBox(
//             width: 80,
//             child: Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 Positioned(
//                   left: 20,
//                   child: Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                         shape: BoxShape.circle, color: textFieldColor),
//                     child: const Text('3'),
//                   ),
//                 ),
//                 Positioned(
//                   left: -20,
//                   child: Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                         shape: BoxShape.circle, color: textFieldColor),
//                     child: const Text('1'),
//                   ),
//                 ),
//                 Positioned(
//                   left: 0,
//                   child: Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [btnGradLeft, btnGradRight],
//                       ),
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Text('2'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             "What are you interested in?",
//             // textAlign: TextAlign.center,
//             style: Theme.of(context)
//                 .textTheme
//                 .headline5!
//                 .copyWith(color: lightTextColor),
//           ),
//           Text(
//             'Choose a few categories you like you can change them later',
//             // textAlign: TextAlign.center,
//             style: Theme.of(context).textTheme.subtitle1,
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: CustomTextButtonIntr(
//                   onTap: () {},
//                   isGradient: true,
//                   text: '#Holidays',
//                   paddingHor: paddingHor,
//                   paddingVert: paddingVert,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: CustomTextButtonIntr(
//                   onTap: () {},
//                   isGradient: false,
//                   text: '#Animals',
//                   paddingHor: paddingHor,
//                   paddingVert: paddingVert,
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               CustomTextButtonIntr(
//                 onTap: () {},
//                 isGradient: true,
//                 text: '#Havefun',
//                 paddingHor: paddingHor,
//                 paddingVert: paddingVert,
//               ),
//               CustomTextButtonIntr(
//                 onTap: () {},
//                 isGradient: true,
//                 text: '#Designers',
//                 paddingHor: paddingHor,
//                 paddingVert: paddingVert,
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               CustomTextButtonIntr(
//                 onTap: () {},
//                 isGradient: false,
//                 text: '#4like4like',
//                 paddingHor: paddingHor,
//                 paddingVert: paddingVert,
//               ),
//               CustomTextButtonIntr(
//                 onTap: () {},
//                 isGradient: false,
//                 text: '#Engineering',
//                 paddingHor: paddingHor,
//                 paddingVert: paddingVert,
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               CustomTextButtonIntr(
//                 onTap: () {},
//                 isGradient: true,
//                 text: '#Musiccover',
//                 paddingHor: paddingHor,
//                 paddingVert: paddingVert,
//               ),
//               CustomTextButtonIntr(
//                 onTap: () {},
//                 isGradient: false,
//                 text: '#Abstract',
//                 paddingHor: paddingHor,
//                 paddingVert: paddingVert,
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: CustomTextButton(
//                 onTap: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) => const NamePage(),
//                   ));
//                 },
//                 isGradient: true,
//                 text: 'Next Step'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ignore: must_be_immutable
