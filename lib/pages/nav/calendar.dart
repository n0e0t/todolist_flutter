import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendarscreen extends StatefulWidget {
  const Calendarscreen({super.key});

  @override
  State<Calendarscreen> createState() => _CalendarscreenState();
}

class _CalendarscreenState extends State<Calendarscreen> {
  TextEditingController searchController = TextEditingController();
  String searchText = '';
  String statusFilter = 'Incomplete';
  DateTime today = DateTime.now(); // Options: All, Complete, Incomplete

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentUser.value!.taskList,
      builder: (context, tasks, _) {
        List filteredTasks = tasks.where((task) {
        final matchesSearch = task.name.toLowerCase().contains(searchText.toLowerCase());
        if (statusFilter == 'Complete') {
          return task.status && matchesSearch && 
          (task.date.day == today.day &&task.date.month == today.month &&task.date.year == today.year);
        }
        if (statusFilter == 'Incomplete') {
          return !task.status && matchesSearch&& 
          (task.date.day == today.day &&task.date.month == today.month &&task.date.year == today.year);
        }
        return matchesSearch;
      }).toList();

        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 48, 48, 48)
              ),
              child: TableCalendar(
                rowHeight: 43,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(color: Colors.white,),
                  
                  ),
                calendarFormat: CalendarFormat.week,
                selectedDayPredicate: (day)=>isSameDay(day, today),
                focusedDay: today, 
                firstDay: DateTime.utc(2010,1,1), 
                lastDay: DateTime.utc(2030,1,1),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: Colors.white),
                  weekendStyle: TextStyle(color: Colors.redAccent)
                ),
                calendarStyle: CalendarStyle(
                  defaultTextStyle: TextStyle(color: Colors.white),
                  weekendTextStyle: TextStyle(color: Colors.white)
                ),
                onDaySelected: (DateTime day,DateTime focusedDay){
                  setState(() {
                    today = day;
                  });
                },
                ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(left: 30, right: 30, top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color.fromARGB(255, 56, 56, 56)
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    SizedBox(
                      width: 137,
                      height: 49,
                      child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:statusFilter=='Incomplete'? Theme.of(context).colorScheme.primary: Color.fromARGB(255, 56, 56, 56),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color:statusFilter=='Incomplete'? Theme.of(context).colorScheme.primary: Colors.grey,width: 2),
                          borderRadius:BorderRadius.circular(5),
                        )
                      ),
                      onPressed: (){
                        setState(() {
                          statusFilter = 'Incomplete';
                        });
                      }
                      , child: Text('Today',style:  TextStyle(color:Colors.white ),)
                      ),
                    ),
                    SizedBox(width: 20,),
                    SizedBox(
                      width: 137,
                      height: 49,
                      child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:statusFilter=='Complete'? Theme.of(context).colorScheme.primary: Color.fromARGB(255, 56, 56, 56),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color:statusFilter=='Complete'? Theme.of(context).colorScheme.primary: Colors.grey,width: 2),
                          borderRadius:BorderRadius.circular(5)
                        )
                      ),
                      onPressed: (){
                        setState(() {
                          statusFilter = 'Complete';
                        });
                      }
                      , child: Text('Completed',style:  TextStyle(color:Colors.white ),)
                      ),
                    )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  final task = filteredTasks[index];
                  return Container(
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
                          onChanged: (value) {
                            setState(() {
                              task.status = !task.status;
                            });
                          },
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(task.name, style: const TextStyle(color: Colors.white,fontSize: 16)),
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
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}