import 'package:clipboard/clipboard.dart';
import 'package:dims_config/dims_config.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'json_parser.dart';

class UiPc extends StatefulWidget {
  UiPc({Key? key}) : super(key: key);

  @override
  State<UiPc> createState() => _UiPcState();
}

class _UiPcState extends State<UiPc> {
  TextEditingController inputCont = TextEditingController();
  TextEditingController onputCont = TextEditingController();
  TextEditingController classNameCont = TextEditingController();
  bool animate = false;
  void animatee() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      animate = true;
    });
  }

  @override
  void initState() {
    animatee();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DimsConfig dimsConfig = DimsConfig(context);
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: dimsConfig.deviceHeight * 0.1,
            ),
            const Text(
              'JSON to Dart data class',
              style: TextStyle(fontSize: 30, wordSpacing: 2),
            ),
            AnimatedOpacity(
              opacity: animate ? 1 : 0,
              duration: const Duration(seconds: 1),
              child: ElevatedButton(
                onPressed: () {
                  launchUrl(Uri.parse('http://amrdarwish.epizy.com/'));
                },
                style: ElevatedButton.styleFrom(primary: Colors.black),
                child: const Text(
                  'About Us',
                  style: TextStyle(fontSize: 26, wordSpacing: 2),
                ),
              ),
            ),
            SizedBox(
              height: dimsConfig.deviceHeight * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Type Json here',
                      style: TextStyle(fontSize: 18, wordSpacing: 2),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 300,
                      width: 350,
                      child: TextFormField(
                        controller: inputCont,
                        maxLines: 15,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        controller: classNameCont,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                            hintText: 'Class Name',
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (classNameCont.text.isNotEmpty) {
                          if (inputCont.text.isNotEmpty) {
                            final parser = JsonParser(
                                inputCont.text, classNameCont.text, true);
                            setState(() {
                              onputCont.text = parser.convertToDartObject();
                            });
                          }
                        } else {
                          print("Nooo");
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  title: Text(
                                    'No Class Name',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                );
                              });
                        }
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      child: const Text(
                        'Generate',
                        style: TextStyle(fontSize: 18, wordSpacing: 2),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Output',
                      style: TextStyle(fontSize: 18, wordSpacing: 2),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 300,
                      width: 350,
                      child: TextFormField(
                        controller: onputCont,
                        maxLines: 15,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        FlutterClipboard.copy(onputCont.text);
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      child: const Text(
                        'Copy ',
                        style: TextStyle(fontSize: 18, wordSpacing: 2),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
