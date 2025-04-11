import 'package:flutter/material.dart';
import 'package:flutter_application_1/function/push_to_page.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/model/user.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';



class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  bool uservalidate = false;
  bool passvalidate = false;
  String erroemas = 'password not match';

  int incompleteCount = currentUser.value?.taskList.value
    .where((task) => task.status == false)
    .length ?? 0;

  int completeCount = currentUser.value?.taskList.value
    .where((task) => task.status == true)
    .length ?? 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage(currentUser.value!.imagePath as String),
          ),
          SizedBox(height: 8,),
          Text(currentUser.value!.username,style: TextStyle(color: Colors.white,fontSize: 20),),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 58,
                width: 154,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(255, 48, 48, 48)
                ),
                child: Center(child: Text('$incompleteCount Task left',style: TextStyle(color: Colors.white),)),
              ),
              SizedBox(width: 15,),
              Container(
                height: 58,
                width: 154,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(255, 48, 48, 48)
                ),
                child: Center(child: Text('$completeCount Task done',style: TextStyle(color: Colors.white),)),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(right: 20.0,left: 20,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(width: 20,),
                Text('Account',style: TextStyle(color: Color.fromARGB(255, 175, 175, 175)),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0,left: 20,bottom: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: Size(300, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    TextEditingController nameController = TextEditingController();
                    return StatefulBuilder(
                      builder: (context, setStateDialog) {
                        return AlertDialog(
                          backgroundColor: Color.fromARGB(255, 33, 33, 33),
                          title: Text("Change Account Name", style: TextStyle(color: Colors.white)),
                          content: TextField(
                            controller: nameController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              errorText: uservalidate ? 'already use' : null,
                              hintText: "Enter new name",
                              hintStyle: TextStyle(color: Colors.grey),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white24),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                setStateDialog(() {
                                  uservalidate = false;
                                });
                                Navigator.of(context).pop(); // close dialog
                              },
                              child: Text("Cancel", style: TextStyle(color: Colors.redAccent)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                User? matchedUser;
                                String newName = nameController.text.trim();
                                try{
                                  matchedUser = userList.value.firstWhere((user)=>user.username == newName);
                                } catch(e){
                                  matchedUser = null;
                                }
                                if(matchedUser!=null){
                                  setStateDialog(() {
                                    uservalidate = true;
                                  });
                                }
                                else if (newName.isNotEmpty) {
                                  setStateDialog(() {
                                    uservalidate = false;
                                    currentUser.value!.username = newName;
                                  });
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Text("Edit"),
                            ),
                          ],
                        );
                      }
                    );
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Iconsax.user, size: 20),
                      SizedBox(width: 10),
                      Text('Change account name'),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios, size: 20),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0,left: 20,bottom: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: Size(300, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    TextEditingController passController = TextEditingController();
                    TextEditingController passCController = TextEditingController();
                    return StatefulBuilder(
                      builder: (context,setStateDialog) {
                        return AlertDialog(
                          backgroundColor: Color.fromARGB(255, 33, 33, 33),
                          title: Text("Change Account Name", style: TextStyle(color: Colors.white)),
                          content: SizedBox(
                            height: 136,
                            child: Column(
                              children: [
                                TextField(
                                  controller: passController,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    errorText: passvalidate ? erroemas : null,
                                    hintText: "Enter new password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white24),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                ),
                                TextField(
                                  controller: passCController,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    errorText: passvalidate ? erroemas : null,
                                    hintText: "Confirm password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white24),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                setStateDialog(() {
                                  passvalidate = false;
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text("Cancel", style: TextStyle(color: Colors.redAccent)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                String newPass = passController.text.trim();
                                String newPassC = passCController.text.trim();
                        
                                if (newPass == currentUser.value!.password) {
                                  setStateDialog(() {
                                    passvalidate = true;
                                    erroemas = 'Don\'t use the old password';
                                  });
                                } else if (newPass != newPassC) {
                                  setStateDialog(() {
                                    passvalidate = true;
                                    erroemas = 'Password not match';
                                  });
                                } else if (newPass.isNotEmpty && newPass == newPassC) {
                                  setStateDialog(() {
                                    passvalidate = false;
                                    currentUser.value!.password = newPass;
                                  });
                                  Navigator.of(context).pop();
                                } else {
                                  setStateDialog(() {
                                    passvalidate = true;
                                    erroemas = 'Invalid input';
                                  });
                                }
                              },
                              child: Text("Edit"),
                            ),
                          ],
                        );
                      }
                    );
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lock_outline, size: 20),
                      SizedBox(width: 10),
                      Text('Change account password'),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios, size: 20),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0,left: 20,bottom: 10),
            child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize: Size(320, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

                    if (image != null) {
                      // Get app directory
                      final Directory appDir = await getApplicationDocumentsDirectory();

                      // Define a new path to copy the image
                      final String fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.png';
                      await File(image.path).copy('${appDir.path}/assets/user/$fileName');

                      currentUser.value!.imagePath = '${appDir.path}/assets/user/$fileName';
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.image_outlined, size: 20),
                          SizedBox(width: 10),
                          Text('Change account image'),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, size: 20),
                    ],
                  ),
                ),

          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0,left: 20,bottom: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: Size(300, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                pushToPage(context, Login(), 200);
                currentUser = ValueNotifier(null);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Iconsax.logout, size: 20,color: Colors.red,),
                      SizedBox(width: 10),
                      Text('Logout',style: TextStyle(color: Colors.red),),
                    ],
                  ),
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}