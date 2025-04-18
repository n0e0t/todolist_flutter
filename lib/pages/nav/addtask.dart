import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/model/task.dart';
import 'package:flutter_application_1/pages/loading_dialog.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Addtask extends StatefulWidget {
  final VoidCallback onTaskSaved;
  const Addtask({super.key, required this.onTaskSaved});

  @override
  State<Addtask> createState() => _AddtaskState();
}

class _AddtaskState extends State<Addtask> {
  final uuid = Uuid();
  bool check = true;
  int selectedPriority = 1;
  String selectedcategory = "None";
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();

  final TextEditingController _field1Controller = TextEditingController();
  final TextEditingController _field2Controller = TextEditingController();

  final FocusNode _focus1 = FocusNode();
  final FocusNode _focus2 = FocusNode();

  @override
  void dispose() {
    _field1Controller.dispose();
    _field2Controller.dispose();
    _focus1.dispose();
    _focus2.dispose();
    super.dispose();
  }

Future<void> _selectDate() async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: selectedDate, 
    firstDate: DateTime(2025),
    lastDate: DateTime(2030),
  );

  if (pickedDate != null) { 
    setState(() {
      selectedDate = pickedDate;
    });
  }
}

Future<void> _selectTime() async{
  final TimeOfDay? timeOfDay = await showTimePicker(
  context: context,
  initialTime: selectedTime,
  initialEntryMode: TimePickerEntryMode.input
  );
  if(timeOfDay != null){
    setState(() {
      selectedTime = timeOfDay;
    });
  }
}

Future<void> _selectPriority() async{
  final priority = await _priorityBuilder(context,selectedPriority);
  if (priority != null){
    setState(() {
      selectedPriority = priority;
    });
  }
}

Future<void> _selectCategory() async{
  final category = await _categoryBuilder(context,selectedcategory);
  if (category != null){
    setState(() {
      selectedcategory = category;
    });
  }
}

Future<void> sortItems() async {
  final currentlist = List.from(currentUser.value!.taskList.value);
  currentlist.sort((a,b) => a.priority.compareTo(b.priority));
  currentlist.sort((a,b) => a.date.compareTo(b.date));
  currentUser.value?.taskList.value =  List<Task>.from(currentlist);
}

Widget _buildFormContent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text(
        "Add Task",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      const SizedBox(height: 16),
      _buildCustomTextFieldwitherror("Task Name", _field1Controller, _focus1, check),
      const SizedBox(height: 16),
      _buildCustomTextField("Description", _field2Controller, _focus2),
      const SizedBox(height: 16),
      Row(
        children: [
          IconButton(
            icon: const Icon(Iconsax.clock, color: Colors.white),
            onPressed: _selectTime,
          ),
          IconButton(
            icon: const Icon(Iconsax.calendar, color: Colors.white),
            onPressed: _selectDate,
          ),
          IconButton(
            icon: const Icon(Iconsax.flag, color: Colors.white),
            onPressed: _selectPriority,
          ),
          IconButton(
            icon: const Icon(Iconsax.tag, color: Colors.white),
            onPressed: _selectCategory,
          ),
        ],
      ),
      const SizedBox(height: 16),
      Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: _saveTask,
          child: const Text("Save", style: TextStyle(color: Colors.white)),
        ),
      ),
    ],
  );
}

void _saveTask() async {
  if (_field1Controller.text != '') {
    final task = Task(
      id: uuid.v4(),
      name: _field1Controller.text,
      description: _field2Controller.text,
      date: selectedDate,
      time: selectedTime,
      priority: selectedPriority,
      category: selectedcategory,
      status: false,
    );

    currentUser.value?.taskList.value = [
      ...currentUser.value!.taskList.value,
      task
    ];
    await sortItems();
    _field1Controller.clear();
    _field2Controller.clear();
    selectedPriority = 0;
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();
    selectedcategory = 'none';
    setState(() {
      check = true;
    });

    showLoadingDialog(context);
    await Future.delayed(const Duration(seconds: 1));
    hideLoadingDialog(context);
    widget.onTaskSaved();
  } else {
    setState(() {
      check = false;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          left: 16,
          right: 16,
          top: 20,
        ),
        child: Align(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 350),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16.0),
              child: _buildFormContent(context),
            ),
          ),
        ),
      ),
    );
  }
}



Widget _buildCustomTextField(String hint, TextEditingController controller, FocusNode focusNode) {
  return Focus(
    focusNode: focusNode,
    child: Builder(
      builder: (context) {
        final hasFocus = focusNode.hasFocus;
        return TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            enabledBorder: hasFocus
                ? const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  )
                : InputBorder.none,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            fillColor: Colors.grey[850],
            filled: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
        );
      },
    ),
  );
}

Widget _buildCustomTextFieldwitherror(String hint, TextEditingController controller, FocusNode focusNode,bool check) {
  return Focus(
    focusNode: focusNode,
    child: Builder(
      builder: (context) {
        final hasFocus = focusNode.hasFocus;
        return TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            errorText: check ? null:"Task Name is empty",
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            enabledBorder: hasFocus
                ? const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  )
                : InputBorder.none,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            fillColor: Colors.grey[850],
            filled: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
        );
      },
    ),
  );
}


Future<int?> _priorityBuilder(BuildContext context,int cur_pri) async {
  int? selectedPriority = cur_pri; 

  return showDialog<int?>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: const Text('Select Task Priority'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(10, (index) {
                      final number = index + 1;
                      final isSelected = selectedPriority == number;
                      return SizedBox(
                        width: 65,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : null,
                          ),
                          onPressed: () {
                            setState(() {
                              selectedPriority = number;
                            });
                          },
                          child: Text('$number',
                          style: TextStyle(color: isSelected? Colors.white:Theme.of(context).colorScheme.primary)
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(); // Just close
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Save'),
                onPressed: () {
                  if (selectedPriority != null) {
                    Navigator.of(context).pop(selectedPriority); 
                  }
                },
              ),
            ],
          );
        },
      );
    },
  );
}

Future<String?> _categoryBuilder(BuildContext context,String cur_cat) async {
  String? selectedCategory = cur_cat; 

  return showDialog<String?>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: const Text('Select Task Category'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(catagory_list.length, (index) {
                      // ignore: non_constant_identifier_names
                      final cur_category = catagory_list[index];
                      final isSelected = selectedCategory == cur_category['name'];
                      return SizedBox(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 60,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isSelected
                                      ? cur_category['color'] as Color
                                      : null,
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedCategory = cur_category['name'] as String?;
                                  });
                                },
                                child: Image.asset("assets/category/${cur_category['name']}.png"),
                              ),
                            ),
                            Text(cur_category['name'] as String,
                              style: TextStyle(color: isSelected? Colors.red:Theme.of(context).colorScheme.primary)
                              ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(); // Just close
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Save'),
                onPressed: () {
                  if (selectedCategory != null) {
                    Navigator.of(context).pop(selectedCategory); 
                  }
                },
              ),
            ],
          );
        },
      );
    },
  );
}