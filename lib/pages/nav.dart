import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/nav/addtask.dart';
import 'package:flutter_application_1/pages/nav/calendar.dart';
import 'package:flutter_application_1/pages/nav/focus.dart';
import 'package:flutter_application_1/pages/nav/index.dart';
import 'package:flutter_application_1/pages/nav/profile.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';


class Pagedata{
  final PreferredSizeWidget appBar;
  final Widget body;

  Pagedata({required this.appBar, required this.body});
}

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _HomepageState();
}

class _HomepageState extends State<Navbar> {

  List<Pagedata> _buildPages() {return[
  Pagedata(
    appBar: AppBar(
      centerTitle: true,
      backgroundColor: Colors.black,
      automaticallyImplyLeading: false,
      title: const Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Text('Index', style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
      actions:[
        Padding(
          padding: EdgeInsets.only(right: 10.0, top: 10 ,bottom: 5),
          child: GestureDetector(
            onTap: (){
              setState(() {
                _selectedIndex = 3;
              });
            },
            child: CircleAvatar(
              radius: 42,
              backgroundImage: AssetImage(currentUser.value!.imagePath as String),
            ),
          ),
        ),
      ],
    ),
    body: const Indexscreen(),
  ),
  Pagedata(
    appBar: AppBar(
      title: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: const Text("Calendar", style: TextStyle(fontSize: 20,color: Colors.white)),
      ),
      backgroundColor: Colors.black,
      centerTitle: true,
    ),
    body: const Calendarscreen(),
  ),
  Pagedata(
    appBar: AppBar(
      title: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: const Text("Focus", style: TextStyle(fontSize: 20,color: Colors.white)),
      ),
      backgroundColor: Colors.black,
      centerTitle: true,
    ),
    body: const Focusscreen(),
  ),
  Pagedata(
    appBar: AppBar(
      title: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: const Text("Profile", style: TextStyle(fontSize: 20,color: Colors.white)),
      ),
      backgroundColor: Colors.black,
      centerTitle: true,
    ),
    body: const Profilescreen(),
  ),
  Pagedata(appBar: AppBar(
      title: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: const Text("Add Task", style: TextStyle(fontSize: 20,color: Colors.white)),
      ),
      backgroundColor: Colors.black,
      centerTitle: true,
    ), body: Addtask(
        onTaskSaved: () {
          setState(() {
            _selectedIndex = 0; 
          });
    },))
  ];
}

int _selectedIndex = 0;

Widget navItem(int index, IconData icon, String label) {
  final isSelected = _selectedIndex == index;
  return GestureDetector(
    onTap: () {
      setState(() {
        _selectedIndex = index;
      });
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: isSelected ? Colors.white : Colors.grey),
        Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.grey, fontSize: 12)),
      ],
    ),
  );
}


 @override
Widget build(BuildContext context,) {
  final _pages = _buildPages();

  return Scaffold(
    backgroundColor: Colors.black,
    appBar: _pages[_selectedIndex].appBar,
    body: _pages[_selectedIndex].body,
    bottomNavigationBar: BottomAppBar(
      color: Colors.grey[900],
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navItem(0, Iconsax.home, "Index"),
            navItem(1, Iconsax.calendar, "Calendar"),
            const SizedBox(width: 40), // space for FAB
            navItem(2, Iconsax.clock, "Focus"),
            navItem(3, Iconsax.user, "Profile"),
          ],
        ),
      ),
    ),
    floatingActionButton: SizedBox(
      width: 70,
      height: 70,
      child: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Color.fromRGBO(136, 117, 255,1),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
        setState(() {
        _selectedIndex = 4;
      });
      },
      ),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  );
}
}
