import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:social_share/social_share.dart';

class SocialShareScreen extends StatefulWidget {
  const SocialShareScreen({Key? key}) : super(key: key);

  @override
  State<SocialShareScreen> createState() => _SocialShareScreenState();
}

class _SocialShareScreenState extends State<SocialShareScreen> {
  XFile? file;
  ScreenshotController _screenshotController = ScreenshotController();
  @override
  void initState() {
    super.initState();
    // initPlatformState();
  }

  // Future<void> initPlatformState() async {
  //   String platformVersion;
  //
  //   if (!mounted) return;
  //
  //   setState(() {
  //     _platformVersion = platformVersion;
  //   });
  // }
  TextEditingController _message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Screenshot(
        controller: _screenshotController,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // ElevatedButton(
          //   onPressed: () async {
          //     final file = await ImagePicker().pickImage(
          //       source: ImageSource.gallery,
          //     );
          //     SocialShare.shareInstagramStory(
          //       file.path,
          //       backgroundTopColor: "#ffffff",
          //       backgroundBottomColor: "#000000",
          //       attributionURL: "https://deep-link-url",
          //     ).then((data) {
          //       //print(data);
          //     });
          //   },
          //   child: Text("Share On Instagram Story"),
          // ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 80,
                child: TextField(
                  controller: _message,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                ),
              ),
              InkWell(
                onTap: () async {
                  if (_message.text.isNotEmpty) {
                    SocialShare.copyToClipboard(
                      "${_message.text}",
                    ).then((data) {
                      //print(data);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("Copy")));
                    });
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Enter Text")));
                  }
                },
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      image:
                          DecorationImage(image: AssetImage("asset/copy.png"))),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 150,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    onPressed: () async {
                      file = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                      );
                      //print('Path >>.  $file');
                    },
                    child: Text("Pick Image")),
              ),
              InkWell(
                radius: 50,
                onTap: () async {
                  await _screenshotController.capture().then((image) async {
                    SocialShare.shareOptions("Hello world").then((data) {
                      //print(data);
                    });
                  });
                },
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("asset/share.png"))),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Divider(
            color: Colors.green,
            thickness: 1.5,
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: InkWell(
                  onTap: () async {
                    try {
                      // final file = await ImagePicker().pickImage(
                      //    source: ImageSource.gallery,
                      //  );
                      //  //print('Path >>.  $file');

                      SocialShare.shareInstagramStory(
                        file!.path,
                        backgroundTopColor: "#ffffff",
                        backgroundBottomColor: "#000000",
                        attributionURL: "https://deep-link-url",
                      ).then((data) {
                        //print(data);
                      });
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Select Image")));
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("asset/instagram.png"))),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // _screenshotController
                  //     .capture(delay: Duration(milliseconds: 10))
                  //     .then((value) async {
                  //   //log('value >>>  $value');
                  //   final directory = await getApplicationDocumentsDirectory();
                  //   final files =
                  //       await File('${directory.path}/temp.png').create();
                  //   await files.writeAsBytes(value!);
                  //   //facebook appId is mandatory for andorid or else share won't work
                  //
                  // });
                  try {
                    Platform.isAndroid
                        ? SocialShare.shareFacebookStory(
                            file!.path,
                            "#ffffff",
                            "#000000",
                            "https://google.com",
                            appId: "1234567289741",
                          ).then((data) {
                            //print(data);
                          })
                        : SocialShare.shareFacebookStory(
                            file!.path,
                            "#ffffff",
                            "#000000",
                            "https://google.com",
                          ).then((data) {
                            //print(data);
                          });
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Select Image")));
                  }
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("asset/facebook.png"))),
                ),
              ),
              InkWell(
                onTap: () async {
                  if (_message.text.isNotEmpty) {
                    SocialShare.shareTwitter(
                      "${_message.text}",
                      hashtags: ["hello", "world", "foo", "bar"],
                      url: "https://google.com/#/hello",
                      trailingText: "\nhello",
                    ).then((data) {
                      //print(data);
                    });
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Enter a Text")));
                  }
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("asset/twitter.png"))),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () async {
                  if (_message.text.isNotEmpty) {
                    SocialShare.shareSms(
                      "${_message.text}",
                      url: "\nhttps://google.com/",
                      trailingText: "\nhello",
                    ).then((data) {
                      //print(data);
                    });
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Enter a Text")));
                  }
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      image:
                          DecorationImage(image: AssetImage("asset/chat.png"))),
                ),
              ),
              InkWell(
                onTap: () async {
                  if (_message.text.isNotEmpty) {
                    SocialShare.shareWhatsapp(
                      "${_message.text}",
                    ).then((data) {
                      //print(data);
                    });
                  } else
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Enter a Text")));
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("asset/whatsapp.png"))),
                ),
              ),
              InkWell(
                onTap: () async {
                  if (_message.text.isNotEmpty) {
                    SocialShare.shareTelegram(
                      "${_message.text}",
                    ).then((data) {
                      //print(data);
                    });
                  } else
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Enter a Text")));
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("asset/telegram.png"))),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Divider(
            color: Colors.green,
            thickness: 1.5,
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 50,
              ),
              Text(
                "Screenshot Share on story",
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: InkWell(
                  onTap: () async {
                    _screenshotController
                        .capture(delay: Duration(milliseconds: 10))
                        .then((value) async {
                      //log('value >>>  $value');
                      final directory =
                          await getApplicationDocumentsDirectory();
                      final files =
                          await File('${directory.path}/temp.png').create();
                      await files.writeAsBytes(value!);
                      try {
                        SocialShare.shareInstagramStory(
                          files.path,
                          backgroundTopColor: "#ffffff",
                          backgroundBottomColor: "#000000",
                          attributionURL: "https://deep-link-url",
                        ).then((data) {
                          //print(data);
                        });
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Select Image")));
                      }
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("asset/instagram.png"))),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _screenshotController
                      .capture(delay: Duration(milliseconds: 10))
                      .then((value) async {
                    //log('value >>>  $value');
                    final directory = await getApplicationDocumentsDirectory();
                    final files =
                        await File('${directory.path}/temp.png').create();
                    await files.writeAsBytes(value!);
                    try {
                      Platform.isAndroid
                          ? SocialShare.shareFacebookStory(
                              files.path,
                              "#ffffff",
                              "#000000",
                              "https://google.com",
                              appId: "1234567289741",
                            ).then((data) {
                              //print(data);
                            })
                          : SocialShare.shareFacebookStory(
                              files.path,
                              "#ffffff",
                              "#000000",
                              "https://google.com",
                            ).then((data) {
                              //print(data);
                            });
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Select Image")));
                    }
                  });
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("asset/facebook.png"))),
                ),
              ),
              InkWell(
                onTap: () async {
                  _screenshotController
                      .capture(delay: Duration(milliseconds: 10))
                      .then((value) async {
                    ////log('value >>>  $value');
                    final directory = await getApplicationDocumentsDirectory();
                    final files =
                        await File('${directory.path}/temp.png').create();
                    await files.writeAsBytes(value!);
                    SocialShare.shareTwitter(
                      files.path,
                      hashtags: ["hello", "world", "foo", "bar"],
                      url: "https://google.com/#/hello",
                      trailingText: "\nhello",
                    ).then((data) {
                      ////print(data);
                    });
                  });
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("asset/twitter.png"))),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
