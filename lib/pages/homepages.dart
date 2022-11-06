import 'package:flutter/material.dart';
import 'package:todoapp_bloc/bloc/bloc_export.dart';
import 'package:todoapp_bloc/model/task.dart';
import 'package:todoapp_bloc/pages/pendingpages.dart';

class HomePages extends StatelessWidget {
  HomePages({super.key});
  TextEditingController _taskController = TextEditingController();

  _addText(BuildContext context) {
    return showModalBottomSheet(
      //! kalau rounded langsung ditaroh di child container, nanti pass discroll tampilannya balik jadi kotak, makanya atur di 'shape:' aja
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      backgroundColor: Colors.white,
      // clipBehavior: Clip.antiAliasWithSaveLayer,
      clipBehavior: Clip.antiAlias,
      context: context,
      //! isScrollControlled, kalau childnya adalah singlechildscroll atau listview, kalau true maka akan mengaktifkan sifat draggableBottomSheet
      //! bisa juga untuk memanjangkan showModalBottom
      //! kalau ada keyboard, showModalBottom jadi gaketutup (wajib ditemani mediaquery.viewinsets)
      isScrollControlled: true,
      builder: (context) {
        //! bisa juga gapake singlechildscrollview, tapi lebih baik dipake biar gaada overlapping dalam sheet nya
        return SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          //! mengambil ukuran padding yang disebabkan sama keyboard
          child: Container(
            padding: const EdgeInsets.only(
              bottom: 50,
              top: 50,
              left: 20,
              right: 20,
            ),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('data 1'),
                TextField(
                  autocorrect: false,
                  enableSuggestions: false,
                  // maxLines: 1,
                  // expands: true,
                  controller: _taskController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    //! content padding untuk mengatur tinggi dari textfield
                    // contentPadding: const EdgeInsets.only(left: 50, top: 50, bottom: 50),
                    filled: true,
                    fillColor: Colors.amber,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          50,
                        ),
                        borderSide: BorderSide.none),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<TaskBloc>().add(
                          AddTask(
                            task: Task(
                              title: _taskController.text,
                            ),
                          ),
                        );
                    Navigator.pop(context);
                    _taskController.clear();
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      //! resizeToAvoidBottomInset supaya layout ga keresize pass keyboard muncul
      resizeToAvoidBottomInset: false,
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text(
          'Pending Task',
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: w * 0.18),
        child: FloatingActionButton(
          onPressed: () {
            _addText(context);
          },
          //! ketika floating action butoon dipencet lama, maka akan keluar text ini
          tooltip: 'add task',
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                PendingPages(),
              ],
            ),
          ),
          /*DraggableScrollableSheet(
            //? snap langsung ke snap atas dan bawah
            
            snap: true,
            initialChildSize: 0.2,
            minChildSize: 0.2,
            maxChildSize: 0.5,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(50),
                  ),
                  color: Colors.grey.shade300,
                ),
                child: SingleChildScrollView(
                  //? clampingScrollPhysic membuat scrollview jadi gakescroll dalam draggable

                  physics: ClampingScrollPhysics(),
                  controller: scrollController,
                  child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                        height: 6,
                        width: 80,
                        decoration: const ShapeDecoration(
                          shape: StadiumBorder(),
                          color: Colors.grey,
                        ),
                      ),
                      Text('data'),
                      Text('data'),
                      Text('data'),
                      Text('data'),
                      Text('data'),
                      Text('data'),
                    ],
                  ),
                ),
              );
            },
          ),*/
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: h * 0.1,
              width: w,
              color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.pending_actions,
                          size: 35,
                        ),
                      ),
                      const Text(
                        'Pending Task',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.check,
                          size: 35,
                        ),
                      ),
                      const Text(
                        'Pending Task',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite,
                          size: 35,
                        ),
                      ),
                      const Text(
                        'Pending Task',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
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
