import 'package:flutter/material.dart';
import 'package:todo/shared/bloc/cubit.dart';

Widget defaultformfield({
  required TextEditingController controle ,
  TextInputType? type,
  bool obscure = false,
  String? label,
  String? hint,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? onpress,
  FormFieldValidator? validate,
  GestureTapCallback? ontap,
  bool isClickable = true,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  Color? iconColor,
  Color? textColor,

}) => TextFormField(
  onFieldSubmitted: onSubmit,
  enabled: isClickable,
  onTap: ontap,
validator: validate,
controller: controle,
keyboardType: type,
obscureText: obscure ,
decoration: InputDecoration(
  hintStyle: TextStyle(
    color: textColor
  ),
 labelStyle: TextStyle(
    color: textColor,
  ),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular (30),
  borderSide: BorderSide(
      width: 3,
  ),

),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(
        width: 3,
    ),
  ),
labelText: label,
hintText: hint,
prefixIcon: Icon(
prefix,
  color: iconColor ,
),
suffixIcon:IconButton(
icon : Icon(
  suffix,
),

onPressed: onpress,
),
),
  onChanged: onChange,
);

Widget defaultTextButton({
  required VoidCallback onPress,
  required String text,
  Color? textColor,
  Color? pressColor,
  double? fontSize,
}) => TextButton(
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed))
            return pressColor; //<-- SEE HERE
          return null; // Defer to the widget's default.
        },
      ),
    ),
    onPressed: onPress,
    child: Text(text,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize
      ),));

Widget buildTaskItem(Map model, context) => Dismissible(
  key: Key(model['title']),
  child: Padding(
    padding: EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(

          radius: 35,

          child: Text('${model['time']}',

            ),

        ),
        SizedBox(width: 20,),
        Expanded(

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            mainAxisSize: MainAxisSize.min,

            children: [

              Text('${model['title']}',

                maxLines: 2,

                overflow: TextOverflow.ellipsis,

                style: TextStyle(

                  fontWeight: FontWeight.bold,

                  fontSize: 20,

                ),),

              Text('${model['date']}',

                maxLines: 2,

                overflow: TextOverflow.ellipsis,

                style: TextStyle(

                    fontSize: 18,

                    color: Colors.grey

                ),),

            ],

          ),

        ),
        IconButton(

          onPressed: (){

            ToDo.get(context).UpdateData(

                status: 'done',

              id: model['id'],

            );

            },

            icon: Icon(

              Icons.check_box,

              color: Colors.greenAccent,

            ) ,

        ),
        SizedBox(width: 12,),
        IconButton(

          onPressed: (){

            ToDo.get(context).UpdateData(

                status: 'archive',

                id: model['id'],

            );

          },

          icon: Icon(

            Icons.archive,

            color: Colors.black54,

          ) ,

        ),
      ],
    ),
  ),
  onDismissed: (direction){
  ToDo.get(context).DeleteData(id: model['id']);
  },
);

Widget myDivider() => Padding(
  padding:  EdgeInsetsDirectional.only(
    start: 20,
  ),
  child: Container(
    height: 1,
    width: double.infinity,
    color: Colors.grey[400],
  ),
);


navigateTo(context , widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);
navigateAndFinish(context , widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(
  builder: (context) => widget,
), (route) => false
);





void printFullText(String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}






