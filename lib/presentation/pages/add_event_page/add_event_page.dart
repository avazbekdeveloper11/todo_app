import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/aplication/calendar_bloc/calendar_bloc.dart';
import 'package:todo_app/infrastructure/extensions/extensions.dart';
import 'package:todo_app/infrastructure/models/todo_model.dart';
import 'package:todo_app/infrastructure/services/db_service.dart';
import 'package:todo_app/presentation/components/buttons/custom_buttons.dart';
import 'package:todo_app/presentation/components/custom_text_field.dart';
import 'package:todo_app/presentation/components/un_focus.dart';
import 'package:todo_app/presentation/styles/theme_warpper.dart';

class AddEventPage extends StatefulWidget {
  final TodoModel? todoModel;
  const AddEventPage({super.key, required this.todoModel});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  late FocusNode focusNode;
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController locationController;
  late TextEditingController timeController;
  late List<Map<String, String>> dropDownItems;
  late GlobalKey<FormState> _formKey;
  late bool isSelected;
  AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: OnUnFocusTap(
            child: ThemeWrapper(
              builder: (context, colors, fonts, icons, controller) {
                return Scaffold(
                  backgroundColor: colors.backgroundColor,
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 40.h,
                              bottom: 32.h,
                            ),
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: SvgPicture.asset(icons.arrowLeft),
                            ),
                          ),
                          CustomTextField(
                            autovalidateMode: autovalidateMode,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'input_required'.tr();
                              }
                              return null;
                            },
                            controller: nameController,
                            title: 'event_name'.tr(),
                            hintText: 'Event name',
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.h, top: 16.h),
                            child: Text(
                              'event_description'.tr(),
                              style: fonts.regular14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => focusNode.requestFocus(),
                            child: Container(
                              height: 92.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.r),
                                color: colors.filledColor,
                                border: Border.all(color: colors.stroke),
                              ),
                              child: CustomTextField(
                                controller: descriptionController,
                                hintText: 'Description...',
                                focusNode: focusNode,
                                maxLength: 150,
                                maxLines: 4,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: CustomTextField(
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'input_required'.tr();
                                }
                                return null;
                              },
                              autovalidateMode: autovalidateMode,
                              controller: locationController,
                              title: 'event_location'.tr(),
                              hintText: 'location',
                              suffixIcon: SvgPicture.asset(
                                icons.location,
                                colorFilter: ColorFilter.mode(
                                  colors.primary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.h, top: 16.h),
                            child: Text(
                              'priority_color'.tr(),
                              style: fonts.regular14,
                            ),
                          ),
                          Container(
                            height: 32.h,
                            width: 72.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: colors.filledColor,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: DropdownButton(
                              underline: const SizedBox(),
                              value: widget.todoModel == null && !isSelected
                                  ? widget.todoModel?.color ??
                                      state.dropDownValue
                                  : state.dropDownValue,
                              borderRadius: BorderRadius.circular(8.r),
                              icon: SvgPicture.asset(icons.chevronDown),
                              items: List.generate(
                                dropDownItems.length,
                                (index) => DropdownMenuItem(
                                  value: dropDownItems[index]['value'],
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 23.w,
                                    height: 20.h,
                                    margin: EdgeInsets.only(right: 8.w),
                                    color: HexColor.fromHex(
                                      dropDownItems[index]['value'],
                                    ),
                                  ),
                                ),
                              ),
                              onChanged: (String? v) {
                                isSelected = true;
                                context.read<CalendarBloc>().add(
                                      CalendarEvent.changeDropdown(
                                        dropDownValue: v ?? 'pink',
                                      ),
                                    );
                              },
                            ),
                          ),
                          SizedBox(height: 16.h),
                          GestureDetector(
                            onTap: () => getTime(),
                            child: CustomTextField(
                              autovalidateMode: autovalidateMode,
                              controller: timeController,
                              enabled: false,
                              title: 'event_time'.tr(),
                              hintText:
                                  '${DateTime.now().hour}:${DateTime.now().minute.toString().length == 1 ? 0 : ''}${DateTime.now().minute}',
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).viewInsets.bottom,
                          ),
                        ],
                      ),
                    ),
                  ),
                  bottomNavigationBar: Padding(
                    padding:
                        EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w),
                    child: CustomButton(
                      verticalPadding: 12.h,
                      title: 'save'.tr(),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          print(locationController.text);
                          TodoModel todoModel = TodoModel(
                            time: timeController.text == ''
                                ? '${DateTime.now().hour}:${DateTime.now().minute.toString().length == 1 ? 0 : ''}${DateTime.now().minute}'
                                : timeController.text,
                            name: nameController.text,
                            location: locationController.text,
                            description: descriptionController.text,
                            color: state.dropDownValue,
                            date:
                                "${state.selectedYear}-${state.selectedMonth}-${state.selectedDay}",
                          );

                          if (widget.todoModel == null) {
                            await LocalDatabase.inserttodo(todoModel)
                                .then((TodoModel? value) {
                              if (value != null) {
                                fetchData();
                              }
                            });
                          } else {
                            await LocalDatabase.updateTodo(
                              todoModel,
                              widget.todoModel!.id!,
                            ).then((value) {
                              fetchData();
                            });
                          }
                        } else {
                          autovalidateMode = AutovalidateMode.always;
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    descriptionController.dispose();
    locationController.dispose();
    nameController.dispose();
    timeController.dispose();
    super.dispose();
  }

  void fetchData() {
    context.read<CalendarBloc>()
      ..add(const CalendarEvent.getByDate())
      ..add(const CalendarEvent.getAllTodo());
    Navigator.pop(context);
    EasyLoading.showSuccess('success'.tr());
  }

  void getTime() async {
    await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: true,
          ),
          child: child!,
        );
      },
    ).then((TimeOfDay? value) {
      if (value != null) {
        timeController.text =
            '${value.hour}:${value.minute.toString().length == 1 ? 0 : ''}${value.minute}';
      }
    });
  }

  @override
  void initState() {
    focusNode = FocusNode();
    _formKey = GlobalKey<FormState>();
    nameController = TextEditingController(text: widget.todoModel?.name);
    descriptionController =
        TextEditingController(text: widget.todoModel?.description);
    locationController =
        TextEditingController(text: widget.todoModel?.location);
    timeController = TextEditingController(text: widget.todoModel?.time);
    isSelected = widget.todoModel == null ? true : false;
    dropDownItems = [
      {
        'value': '#009FEE',
      },
      {
        'value': '#EE2B00',
      },
      {
        'value': '#EE8F00',
      }
    ];
    super.initState();
  }
}
