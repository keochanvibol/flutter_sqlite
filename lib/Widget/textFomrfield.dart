import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class textFormfield extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController Namecontroller;
  final Widget? widget;
  const textFormfield(
      {Key? key,
      required this.title,
      required this.hint,
      required this.Namecontroller,
      this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    cursorColor: Colors.black,
                    controller: Namecontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Input Field";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: hint,
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 0,
                          ),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 0,
                          ),
                        )),
                  ),
                ),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
