import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/model/task.dart';
import 'package:flutter_application_1/pages/edittask.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Indexscreen extends StatefulWidget {
  const Indexscreen({super.key});

  @override
  State<Indexscreen> createState() => _IndexscreenState();
}


class _IndexscreenState extends State<Indexscreen> {
  TextEditingController searchController = TextEditingController();
  String searchText = '';
  String statusFilter = 'All'; // Options: All, Complete, Incomplete

Future<void> sortItems() async {
  final currentlist = List.from(currentUser.value!.taskList.value);
  currentlist.sort((a,b) => a.priority.compareTo(b.priority));
  currentlist.sort((a,b) => a.date.compareTo(b.date));
  currentUser.value?.taskList.value =  List<Task>.from(currentlist);
}

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentUser.value!.taskList,
      builder: (context, tasks, _) {
        List filteredTasks = tasks.where((task) {
        final matchesSearch = task.name.toLowerCase().contains(searchText.toLowerCase());

        if (statusFilter == 'Complete') return task.status && matchesSearch;
        if (statusFilter == 'Incomplete') return !task.status && matchesSearch;

        return matchesSearch;
      }).toList();

      if (statusFilter == 'All') {
        // Sort: unfinished (false) comes before finished (true)
        filteredTasks.sort((a, b) => a.status.toString().compareTo(b.status.toString()));
      }
        if (tasks.isEmpty) {
          return const Center(
            child: Column(
              children: [
                Expanded(flex: 1, child: SizedBox()),
                Image(image: AssetImage('assets/icons/index.png')),
                Text(
                  'What do you want to do today?',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Text(
                  'Tap + to add your tasks',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                Expanded(flex: 2, child: SizedBox()),
              ],
            ),
          );
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 5),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search tasks...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 29, 29, 29),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 15),
                child: SizedBox(
                  height: 35,
                  width: 120,
                  child: DropdownButtonFormField<String>(
                    value: statusFilter,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 54, 54, 54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    dropdownColor: const Color.fromARGB(255, 54, 54, 54),
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    items: const [
                      DropdownMenuItem(value: 'All', child: Text('All Tasks')),
                      DropdownMenuItem(value: 'Incomplete', child: Text('Incomplete')),
                      DropdownMenuItem(value: 'Complete', child: Text('Complete')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        statusFilter = value!;
                      });
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  final task = filteredTasks[index];
                  return _TaskItem(
            
                    task: task, 
                    onChanged: () {
                    setState(() {}); // Rebuild list after checkbox
                  });
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TaskItem extends StatefulWidget {
  final Task task;
  final VoidCallback onChanged;

  const _TaskItem({
    required this.task, 
    required this.onChanged
    });

  @override
  State<_TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<_TaskItem> {
  double _opacity = 1.0;

  void _handleCheckbox() async {
    setState(() => _opacity = 0.0); // fade out
    await Future.delayed(Duration(milliseconds: 400));
    setState(() {
      widget.task.status = !widget.task.status;
      _opacity = 1.0; // fade back in
    });
    widget.onChanged();
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;

    return AnimatedOpacity(
      duration: Duration(milliseconds: 400),
      opacity: _opacity,
      child: GestureDetector(
        onTap: () async {
          final result = await Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => EditTaskPage(task: task),
              transitionsBuilder: (_, anim, __, child) => FadeTransition(
                opacity: anim,
                child: child,
              ),
              transitionDuration: Duration(milliseconds: 200),
            ),
          );
          if (result == true) widget.onChanged();
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color.fromARGB(255, 44, 44, 44),
          ),
          child: Row(
            children: [
              Checkbox(
                value: task.status,
                onChanged: (_) => _handleCheckbox(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.name, style: const TextStyle(color: Colors.white, fontSize: 16)),
                  Text(
                    (task.date.day == DateTime.now().day &&
                            task.date.month == DateTime.now().month &&
                            task.date.year == DateTime.now().year)
                        ? "Today AT ${task.time.format(context)}"
                        : "${task.date.day}/${task.date.month} AT ${task.time.format(context)}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  SizedBox(
                    height: 29,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Row(
                        children: [
                          Image.asset(task.category == 'None'
                              ? "assets/icons/cat.png"
                              : "assets/category/${task.category}.png"),
                          const SizedBox(width: 3),
                          Text(task.category, style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 29,
                    width: 42,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Theme.of(context).colorScheme.primary),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Iconsax.flag, color: Colors.white, size: 15),
                          const SizedBox(width: 3),
                          Text('${task.priority}', style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}



