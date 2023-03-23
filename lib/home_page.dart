import 'package:Bulohaton/about_us.dart';
import 'package:Bulohaton/add_update_page.dart';
import 'package:Bulohaton/auth_controller.dart';
import 'package:Bulohaton/calculator.dart';
import 'package:Bulohaton/calendar.dart';
import 'package:Bulohaton/db_handler.dart';
import 'package:Bulohaton/model.dart';
import 'package:Bulohaton/pick_image.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  DBHelper? dbHelper;
  late Future<List<TodoModel>> dataList;

  @override
  void initState(){
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async {
    dataList = dbHelper!.getDataList();
    print(dataList);
  }

  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/bg_page.png"),
            fit: BoxFit.cover
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: Drawer(
          child: Container(
            color: Colors.amberAccent[100],
            child: Center(
              child: ListView(
                children: [
                  DrawerHeader(
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.pink,
                      size: 60,
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.home_outlined,
                      color: Color(0xFF1D4E89),
                    ),
                    title: Text(
                      'Main Menu',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1D4E89),
                        fontSize: 20,
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.add,
                      color: Color(0xFFCE5A00),
                    ),
                    title: Text(
                      'Add Task',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFCE5A00),
                        fontSize: 20,
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddUpdateTask(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.calculate_outlined,
                      color: Color(0xFFE0144C),
                    ),
                    title: Text(
                      'Calendar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE0144C),
                        fontSize: 20,
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Calendar(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.browse_gallery_outlined,
                      color: Color(0xFFD782BA),
                    ),
                    title: Text(
                      'Calculator',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD782BA),
                        fontSize: 20,
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Calculator(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.calculate_outlined,
                      color: Color(0xFF7DB954),
                    ),
                    title: Text(
                      'Image Viewer',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF7DB954),
                        fontSize: 20,
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PickImage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.info_outline,
                      color: Color(0xFF989E6A),
                    ),
                    title: Text(
                      'About Us',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF989E6A),
                        fontSize: 20,
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AboutUs(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.logout_outlined,
                      color: Colors.black,
                    ),
                    title: Text(
                      'Log Out',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    onTap: (){
                      AuthController.instance.logOut();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        appBar: AppBar(
          title: Text("BULOHATON",
            style: TextStyle(
              color: Color(0xFF5F0F0A),
              fontSize: 22,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.help_center_rounded,
                size: 30,
              ),
            ),
          ],
        ),
        body: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                    future: dataList,
                    builder: (context, AsyncSnapshot<List<TodoModel>> snapshot){
                      if(!snapshot.hasData || snapshot.data == null){
                        return Center(
                            child: CircularProgressIndicator()
                        );
                      } else if (snapshot.data!.length == 0) {
                        return Center(
                            child: Text("No Tasks Found",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index){
                            int todoId = snapshot.data![index].id!.toInt();
                            String todoTitle = snapshot.data![index].title.toString();
                            String todoDesc = snapshot.data![index].desc.toString();
                            String todoDT = snapshot.data![index].dateandtime.toString();
                            return Dismissible(
                                key: ValueKey<int>(todoId),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  color: Colors.red,
                                  child: Icon(
                                    Icons.delete_forever,
                                    color: Colors.white,
                                  ),
                                ),
                                onDismissed: (DismissDirection direction){
                                  setState(() {
                                    dbHelper!.delete(todoId);
                                    dataList = dbHelper!.getDataList();
                                    snapshot.data!.remove(snapshot.data![index]);
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFD689),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        contentPadding: EdgeInsets.all(10),
                                        title: Padding(
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: Text(
                                            todoTitle,
                                            style: TextStyle(fontSize: 19),
                                          ),
                                        ),
                                        subtitle: Text(
                                          todoDesc,
                                          style: TextStyle(
                                              fontSize: 17
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        thickness: 0.8,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 3,
                                          horizontal: 10,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              todoDT,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: (){
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => AddUpdateTask(
                                                        todoId: todoId,
                                                        todoTitle: todoTitle,
                                                        todoDesc: todoDesc,
                                                        todoDT: todoDT,
                                                        update: true,
                                                      ),
                                                    )
                                                );
                                              },
                                              child: Icon(
                                                Icons.edit_note,
                                                size: 28,
                                                color: Color(0xFF023047),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            );
                          },
                        );
                      }
                    }
                ),),
            ]
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xFFAB2A18),
            child: Icon(Icons.add),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context)=> AddUpdateTask(),
              ));
            }),
      ),
    );
  }
}