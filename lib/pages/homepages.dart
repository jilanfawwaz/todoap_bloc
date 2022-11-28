import 'package:flutter/material.dart';
import 'package:todoapp_bloc/bloc/bloc_export.dart';
import 'package:todoapp_bloc/bloc/bottompage/bottompage_bloc.dart';
import 'package:todoapp_bloc/model/task.dart';
import 'package:todoapp_bloc/pages/completedpages.dart';
import 'package:todoapp_bloc/pages/favoritepages.dart';
import 'package:todoapp_bloc/pages/pendingpages.dart';
import 'package:todoapp_bloc/pages/trashbinpages.dart';
import 'package:todoapp_bloc/pages/widget/mydrawer.dart';
import 'package:todoapp_bloc/services/IDGenerator.dart';

class HomePages extends StatelessWidget {
  HomePages({super.key});
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
            color: Theme.of(context).primaryColor,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Add Data'),
                TextField(
                  autofocus: true,
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
                const SizedBox(
                  height: 20,
                ),
                const Text('Description'),
                TextField(
                  autofocus: true,
                  autocorrect: false,
                  enableSuggestions: false,
                  maxLines: 3,
                  // expands: true,
                  controller: _descriptionController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    //! content padding untuk mengatur tinggi dari textfield
                    // contentPadding: const EdgeInsets.only(left: 50, top: 50, bottom: 50),
                    filled: true,
                    fillColor: Colors.amber,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          40,
                        ),
                        borderSide: BorderSide.none),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<TaskBloc>().add(
                          AddTask(
                            task: Task(
                              id: IDGenerator.generate(),
                              title: _taskController.text,
                              desc: _descriptionController.text,
                              date: DateTime.now().toString(),
                            ),
                          ),
                        );
                    Navigator.pop(context);
                    _taskController.clear();
                    _descriptionController.clear();
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
    String appBarName(int index) {
      switch (index) {
        case 1:
          return 'Pending Page';
        case 2:
          return 'Completed Page';
        case 3:
          return 'Favorite Page';
        case 4:
          return 'Trash Bin Page';
        default:
          return 'Pending Pages';
      }
    }

    Widget contentPage(int index) {
      switch (index) {
        case 1:
          return PendingPages(
            onEdit: () => _addText(context),
            modalBottomContext: context,
          );
        case 2:
          return CompletedPages();
        case 3:
          return FavoritePages();
        case 4:
          return TrashBinPage();
        default:
          return PendingPages(
            onEdit: () => _addText(context),
            modalBottomContext: context,
          );
      }
    }

    Color navBarColor(int index, int state) {
      if (index == state) {
        return Colors.white;
      }
      return Colors.black;
    }

    Color navBarColorBackground(int index, int state) {
      if (index == state) {
        return Colors.grey.shade800;
      }
      return Colors.grey;
    }

    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final bloc = context.read<BottomPageBloc>();
    return Scaffold(
      // bottomNavigationBar: BottomNavigationBar,
      //! resizeToAvoidBottomInset supaya layout ga keresize pass keyboard muncul
      resizeToAvoidBottomInset: false,
      drawer: MyDrawer(),
      appBar: AppBar(
        title: BlocBuilder<BottomPageBloc, int>(
          builder: (context, state) {
            return Text(
              appBarName(state),
            );
          },
        ),
        actions: [
          BlocBuilder<BottomPageBloc, int>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.only(bottom: w * 0.18),
                child: (state == 1)
                    ? IconButton(
                        onPressed: () {
                          _addText(context);
                        },
                        icon: Icon(Icons.add),
                      )
                    : null,
              );
            },
          ),
        ],
      ),
      floatingActionButton: BlocBuilder<BottomPageBloc, int>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(bottom: w * 0.18),
            child: (state == 1)
                ? FloatingActionButton(
                    onPressed: () {
                      _addText(context);
                    },
                    //! ketika floating action button dipencet lama, maka akan keluar text ini
                    tooltip: 'add task',
                    child: const Icon(
                      Icons.add,
                    ),
                  )
                : null,
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: Stack(
        children: [
          Center(
            child: BlocBuilder<BottomPageBloc, int>(
              builder: (context, state) {
                return contentPage(state);
              },
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
          //? navbar
          BlocBuilder<BottomPageBloc, int>(
            builder: (context, state) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.center,
                  height: h * 0.1,
                  width: w,
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: navBarColorBackground(1, state),
                        width: w / 3,
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                bloc.add(
                                  ChangePage(page: 1),
                                );
                              },
                              icon: Icon(
                                Icons.pending_actions,
                                size: 35,
                                color: navBarColor(1, state),
                              ),
                            ),
                            Text(
                              'Pending Task',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: navBarColor(1, state),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: navBarColorBackground(2, state),
                        width: w / 3,
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                bloc.add(
                                  ChangePage(page: 2),
                                );
                              },
                              icon: Icon(
                                Icons.check,
                                size: 35,
                                color: navBarColor(2, state),
                              ),
                            ),
                            Text(
                              'Completed Task',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: navBarColor(2, state),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: navBarColorBackground(3, state),
                        width: w / 3,
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                bloc.add(
                                  ChangePage(page: 3),
                                );
                              },
                              icon: Icon(
                                Icons.favorite,
                                size: 35,
                                color: navBarColor(3, state),
                              ),
                            ),
                            Text(
                              'Favorite Task',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: navBarColor(3, state),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
