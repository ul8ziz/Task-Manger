import 'package:flutter/material.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

//remove page when you click button or any tools (called this function)
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false);

//TextButton

// Widget TextButton({
//   required Function function,
//   required String text,
//   required Text child,
//   Color color=Colors.blue,
//
// }) =>
//     TextButton(
//
//       child: Text(
//         text.toUpperCase(),
//         style: TextStyle(
//           color: color,
//         ),
//       ),
//     );

// TextBoxField

Widget ul8zizTextBox({
  required TextEditingController textcontroller,
  TextInputType? type,
  required Function onsubmit,
  FormFieldValidator? validate,
  required String lable,
  IconData? prefixicon,
  IconData? suffix,
  bool isPass = false,
  double? height,
  double? width,
  Color color = Colors.black,
}) =>
    Container(
      height: height,
      width: width,
      child: TextFormField(
        keyboardType: type,
        validator: validate,
        onTap: () {
          onsubmit;
        },
        obscureText: isPass,
        decoration: InputDecoration(
          labelText: lable,
          hintStyle: TextStyle(fontSize: 5),
          labelStyle: TextStyle(color: Colors.black, fontSize: 15),
          prefixIcon: Icon(prefixicon),
          suffixIcon: Icon(suffix),
          border: OutlineInputBorder(),
          isDense: true,
          contentPadding: EdgeInsets.all(8),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: color)),
        ),
        controller: textcontroller,
      ),
    );

//Button

Widget ButtonGDTS({
  double width = double.infinity,
  Color? backgroundcolor,
  Color? colortxt,
  double radius = 0.0,
  required Function? function,
  required String text,
  TextStyle? style,
}) =>
    Container(
      width: width,
      child: ElevatedButton(
        onPressed: () {
          function;
        },
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: colortxt,
          ),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: backgroundcolor,
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(74, 0, 0, 0),
                blurRadius: 4,
                offset: Offset.fromDirection(8, 4),
                blurStyle: BlurStyle.inner)
          ]),
    );

Widget myDivider() => Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.blue,
    );

Widget ul8zizAppBar({
  BuildContext? context,
  required String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context!);
        },
        icon: Icon(Icons.arrow_back_ios),
      ),
      title: Text(title!),
      titleSpacing: 0.0,
      actions: actions,
    );

Widget ul8zizFormField({
  required TextEditingController controller,
  required TextInputType Type,
  required IconData perfix,
  String? labl,
  IconData? suffix,
  bool ispassword = false,
  Function? onSubmit,
  Function? onChange,
  GestureTapCallback? ontap,
  //Function? validate,
  Function? suffixpressed,
  bool isClickable = true,
  required String? Function(dynamic value) validate,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: Type,
      obscureText: ispassword,
      enabled: isClickable,
      onTap: ontap,
      onFieldSubmitted: (String value) {},
      validator: validate,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labl,
        prefixIcon: Icon(perfix),
        suffix: Icon(suffix),
      ),
    );

Widget ul8zizSizeblBox({
  double width = double.infinity,
  double height = 10,
}) =>
    SizedBox(
      width: width,
      height: height,
    );

Widget ul8zizListItem(Map model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text('${model['time']}'),
          ),
          SizedBox(
            width: 20.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${model['title']}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                '${model['date']}',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              )
            ],
          )
        ],
      ),
    );
