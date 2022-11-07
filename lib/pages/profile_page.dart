import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mlog/controllers/registration_controller.dart';

import '../theme/color.dart';

class ProfilePage extends GetView<RegisterViewModel> {

  @override
  final RegisterViewModel controller  = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,

      body: SafeArea(child: getBody(context)),
    );
  }


  Widget getBody(context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
            width: double.infinity,
            height: size.height * 0.25,
            decoration: const BoxDecoration(color: primary),
            child: Stack(
              children: [
                Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                        color: primary,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                             "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=873&q=80"

                          ),
                        ))),
                Positioned(
                    top: 90,
                    left: size.width*0.20,
                    right: size.width*0.20,
                    child: Container(
                      height: 150,width:150,
                      decoration: BoxDecoration(
                        border: Border.all(color: primary,width: 10),
                        shape: BoxShape.circle,
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://lh4.googleusercontent.com/U0rnC2ckYKRCDBN_b03KLE3r3LDeTFNaQY7_GrPka07Qx_aFaxvHUyr_z-xVZqwvqh4gPW0LxckKGhvy4bZ9bLUKrr-pcZEXWJwGJ3vWrQOpsmZ0PP3VAmaTHYko_7MlBltOJmwxK9GuwoiuB-wzpqbMkmxQskrvYP84P5p3svQ3HfsLgZnJzSQ"
                            ),
                          )
                    )))
              ],
            )
            ),
        Expanded(
          child: Container(
            height: size.height * 0.55,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: primary,
                ),
            child: getAccountSection(),
          ),
        ),
      ],
    );
  }

  Widget getAccountSection() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 25, bottom: 40, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:const [
                Text(
                  "Profile",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: grey.withOpacity(0.1),
                    spreadRadius: 10,
                    blurRadius: 10,
                    // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: secondary.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Center(
                                child: Icon(
                                  Icons.person,
                                  color: primary,
                                  size: 20,
                                ),
                              ),
                            ),
                           const  SizedBox(
                              width: 15,
                            ),
                            Text(
                             GetStorage().read('username')?? "Felix chi",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),

                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: grey.withOpacity(0.1),
                    spreadRadius: 10,
                    blurRadius: 10,
                    // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children:  [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: secondary.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12)),
                              child:const Center(
                                child: Icon(
                                  Icons.phone,
                                  color: primary,
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            const Text(
                              "234908765400",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),

                      ],
                    )
                  ],
                ),
              ),
            )  ,
            const SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: grey.withOpacity(0.1),
                    spreadRadius: 10,
                    blurRadius: 10,
                    // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: secondary.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Center(
                                child: Icon(
                                  Icons.games_outlined,
                                  color: primary,
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Football, Music, Rugby, Games",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),

                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
