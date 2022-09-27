import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:mlog/app/view/profile/profile_view_model.dart';

class Profile extends GetView<ProfileViewModel> {
  /// Mini User Profile
   Profile({Key? key}) : super(key: key);
  @override
  final ProfileViewModel viewModel = Get.put(ProfileViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  Stack(
          children: <Widget>[
            ClipPath(
              clipper: getClipper(),
              child: Container(color: Colors.black.withOpacity(0.8)),
            ),
            Positioned(
                width: 350.0,
                top: MediaQuery.of(context).size.height / 5,
                child: Column(
                  children: <Widget>[
                    Container(
                        width: 150.0,
                        height: 150.0,
                        decoration:  BoxDecoration(
                            color: Colors.purpleAccent[50],
                            image: const DecorationImage(
                                image: NetworkImage(
                                    'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                                fit: BoxFit.cover),
                            borderRadius: const BorderRadius.all(Radius.circular(75.0)),
                            boxShadow:const  [
                              BoxShadow(blurRadius: 7.0, color: Colors.purple)
                            ])),
                   const  SizedBox(height: 90.0),
                    Text(
                      viewModel.name.toString(),
                      style:const TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                   const  SizedBox(height: 15.0),

            ,
                   const  SizedBox(height: 25.0),

                  ],
                ))
          ],
        ));
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
