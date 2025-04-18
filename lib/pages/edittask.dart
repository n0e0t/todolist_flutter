import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/model/task.dart';
import 'package:flutter_application_1/pages/loading_dialog.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;

  const EditTaskPage({Key? key, required this.task}) : super(key: key);

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late TextEditingController nameController;
  late TextEditingController descController;
  late String selectedCategory;
  late int selectedPriority;
  late bool status;
  late DateTime selectedDate;
  late TimeOfDay selectedTime;
  bool check = true;
  

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.task.name);
    descController = TextEditingController(text: widget.task.description);
    selectedCategory = widget.task.category;
    selectedPriority = widget.task.priority;
    status = widget.task.status;
    selectedDate = widget.task.date;
    selectedTime = widget.task.time;
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    super.dispose();
  }

 Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
    builder: (context, child) {
      return Theme(
        data: ThemeData.dark(), // Optional dark mode
        child: child!,
      );
    },
  );
  if (picked != null) {
    setState(() {
      selectedDate = picked;
    });
  }
}

Future<void> _selectTime(BuildContext context) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: selectedTime,
    builder: (context, child) {
      return Theme(
        data: ThemeData.dark(), // Optional
        child: child!,
      );
    },
  );
  if (picked != null) {
    setState(() {
      selectedTime = picked;
    });
  }
}


  Future<void> saveChanges() async {
    setState(() {
      widget.task.name = nameController.text;
      widget.task.description = descController.text;
      widget.task.category = selectedCategory;
      widget.task.priority = selectedPriority;
      widget.task.status = status;
      widget.task.date = selectedDate;
      widget.task.time = selectedTime;
    });
    showLoadingDialog(context);
    await Future.delayed(Duration(seconds: 1));
    hideLoadingDialog(context);
    Navigator.pop(context, true); // Return true to signal update
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: SizedBox(
          width: 350,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Edit Task", style: TextStyle(color: Colors.white, fontSize: 20)),
                const SizedBox(height: 16),
                _buildCustomTextFieldwitherror("Task Name", nameController,check),
                const SizedBox(height: 16),
                _buildCustomTextField("Description", descController),
                const SizedBox(height: 16),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Iconsax.flag, color: Colors.white),
                      onPressed: () async {
                        final priority = await _priorityBuilder(context, selectedPriority);
                        if (priority != null) {
                          setState(() => selectedPriority = priority);
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Iconsax.tag, color: Colors.white),
                      onPressed: () async {
                        final category = await _categoryBuilder(context, selectedCategory);
                        if (category != null) {
                          setState(() => selectedCategory = category);
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Iconsax.calendar, color: Colors.white),
                      onPressed: () => _selectDate(context),
                    ),
                    IconButton(
                      icon: const Icon(Iconsax.clock, color: Colors.white),
                      onPressed: () => _selectTime(context),
                    ),
                    const SizedBox(width: 8),
                    
                  ],
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context, true);
                        },
                        child: const Text("Cancle", style: TextStyle(color: Colors.white)),
                      ),
                      TextButton(
                        onPressed: 
                        (){
                          if(widget.task.name != ''){
                            setState(() {
                              check = true;
                            });
                            saveChanges();
                          }
                          else{
                            setState(() {
                              check = false;
                            });
                          }
                        }
                        ,
                        child: const Text("Save", style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomTextField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[850],

        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }
}

Widget _buildCustomTextFieldwitherror(String hint, TextEditingController controller,bool check) {
  return Builder(
    builder: (context) {
      return TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          errorText: check ? null:"Task Name is empty",
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          fillColor: Colors.grey[850],
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
      );
    },
  );
}


Future<int?> _priorityBuilder(BuildContext context,int currentdPriority) async {
  int? selectedPriority = currentdPriority; 

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
                  Navigator.of(context).pop(); 
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

Future<String?> _categoryBuilder(BuildContext context,String currentCategory) async {
  String? selectedCategory = currentCategory; 

  return showDialog<String?>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: const Text('Select Task Category'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
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