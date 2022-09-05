import 'package:app/data/local_database/local_database.dart';
import 'package:app/models/casheduser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // LocalDatabase.deleteUser();
            LocalDatabase.insertUser(
              name: nameController.text,
              age: int.parse(ageController.text),
            );
          });
        },
      ),
      appBar: AppBar(
        title: const Text("Add user"),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(style: BorderStyle.none)),
                  hintText: "name",
                  prefixIcon: Icon(Icons.person)),
              controller: nameController,
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.none),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "age : ",
                  suffixIcon: Icon(Icons.gps_off)),
              controller: ageController,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder(
                  future: LocalDatabase.getAllCachedUsers(),
                  builder: (context, AsyncSnapshot<List<CachedUser>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) => Card(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(snapshot.data![index].name),
                            Text(snapshot.data![index].age.toString()),
                            Text(snapshot.data![index].id.toString()),
                          ],
                        )),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
