import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_manger/shared/cubit/states.dart';

import '../../shared/components/component.dart';
import '../../shared/cubit/cubit.dart';

class Home extends StatelessWidget {
  var titlController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates states) {
          if(states is AppInserteDbState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates states) {
          AppCubit cubit=AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                  cubit.titles[cubit.currenindxe]),
            ),
            body: cubit.screens[cubit.currenindxe],
            //Condition: state is !AppGetDatabesLoadingState,
            //Bulder:(context)=>cubit.screens[cuibit]
            //fallback:(context)=>Center(child:CircularprogressIn
            floatingActionButton: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 25.0),
                child: FloatingActionButton(
                  onPressed: ()
                  {
                    if (cubit.isBootomshow) {
                      if (formKey.currentState!.validate()) {
                        cubit.inserttoDatabase(
                          title: titlController.text,
                          time: timeController.text,
                          date: dateController.text,
                        ).then((value) {
                         // Navigator.pop(context);
                          cubit.changeBottomSheetState(
                              isShow: false, icon: Icons.edit);
                        });
                      }
                    } else {
                      scaffoldKey.currentState
                          ?.showBottomSheet((context) => Container(
                                // margin: EdgeInsets.all(15),
                                color: Colors.blueGrey[50],
                                padding: EdgeInsets.all(20.0),
                                child: Form(
                                  key: formKey,
                                  child: Column
                                    (
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ul8zizFormField(
                                        labl: 'Task Title',
                                        controller: titlController,
                                        Type: TextInputType.text,
                                        ispassword: false,
                                        perfix: Icons.title,
                                        validate: (value) {
                                          if (value.isEmpty) {
                                            return 'Title must not be empty';
                                          }
                                          return null;
                                        },
                                      ),
                                      ul8zizSizeblBox(),
                                      ul8zizFormField(
                                        labl: 'Task Time',
                                        controller: timeController,
                                        Type: TextInputType.datetime,
                                        // isClickable: false,
                                        ontap: () {
                                          showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now())
                                              .then((value) {
                                            print(value?.format(context));
                                            timeController.text = value!
                                                .format(context)
                                                .toString();
                                          });
                                        },
                                        perfix: Icons.timer,
                                        validate: (value) {
                                          if (value.isEmpty) {
                                            return 'Time must not be empty';
                                          }
                                          return null;
                                        },
                                      ),
                                      ul8zizSizeblBox(),
                                      ul8zizFormField(
                                        labl: 'Task Date',
                                        controller: dateController,
                                        Type: TextInputType.datetime,
                                        //isClickable: false,
                                        ontap: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime.parse(
                                                      '2023-02-22'))
                                              .then((value) {
                                            dateController.text =
                                                DateFormat.yMMMd()
                                                    .format(value!);
                                          });
                                        },
                                        perfix: Icons.timer,
                                        validate: (value) {
                                          if (value.isEmpty) {
                                            return 'Date must not be empty';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                          .closed
                          .then((value) {
                        cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);
                      });
                      cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                      // });
                    }
                  },
                  child: Icon(cubit.botmicon),
                )),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currenindxe,
              onTap: (indxe) {
                AppCubit.get(context).changIndex(indxe);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu_outlined), label: 'Tasks'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline_sharp),
                    label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive), label: 'Archive'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
              ],
            ),
          );
        },
      ),
    );
  }
}
