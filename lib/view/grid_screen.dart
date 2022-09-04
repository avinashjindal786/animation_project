


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../core/enum.dart';
import '../layout.dart';
import '../list.dart';

class GridScreen extends StatefulWidget {
  const GridScreen({Key? key}) : super(key: key);

  @override
  _GridScreenState createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {

  late final ValueNotifier<ScrollDirection> scrollDirectionNotifier;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollDirectionNotifier =
        ValueNotifier<ScrollDirection>(ScrollDirection.forward);
    super.initState();
  }

  @override
  void dispose() {
    scrollDirectionNotifier.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dessert Recipes'),
        leading: GestureDetector(
          onTap: () {
            scrollDirectionNotifier.value = ScrollDirection.forward;
            scrollController.animateTo(
              scrollController.position.minScrollExtent,
              duration: const Duration(milliseconds: 4000),
              curve: Curves.ease,
            );
          },
          child: Container(
            width: 100,
            height: 100,
            color: Colors.black,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              scrollDirectionNotifier.value = ScrollDirection.reverse;
              scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 4000),
                curve: Curves.ease,
              );
            },
            child: Container(
              width: 100,
              height: 100,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: NotificationListener<UserScrollNotification>(
        onNotification: (UserScrollNotification notification) {
          if (notification.direction == ScrollDirection.forward ||
              notification.direction == ScrollDirection.reverse) {
            scrollDirectionNotifier.value = notification.direction;
          }
          return true;
        },
        child: GridView.builder(

            controller: scrollController,
            padding: EdgeInsets.only(
              left: ScreenSize.of(context).isLarge ? 5 : 3.5,
              right: ScreenSize.of(context).isLarge ? 5 : 3.5,
              top: 10,
              bottom: MediaQuery.of(context).padding.bottom,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: RecipesLayout.of(context).gridCrossAxisCount,
              childAspectRatio: RecipesLayout.of(context).gridChildAspectRatio,
            ),
            itemCount: RecipesData.dessertMenu.length,
            cacheExtent: 0,
            itemBuilder: (context, index) {
              return ValueListenableBuilder(valueListenable: scrollDirectionNotifier,
                  builder: (context, ScrollDirection scrollDirection, child){
                print(scrollDirection);
                return Container(
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("${RecipesData.dessertMenu[index].title}",style: TextStyle(color: Colors.black,fontSize: 18),),
                      Text("${RecipesData.dessertMenu[index].bgImageName}",style: TextStyle(color: Colors.black,fontSize: 18),),
                      Text("${RecipesData.dessertMenu[index].description}",style: TextStyle(color: Colors.black,fontSize: 18),),
                      Text("${RecipesData.dessertMenu[index].id}",style: TextStyle(color: Colors.black,fontSize: 18),),
                    ],
                  ),
                );
                  });
            }),
      ),
    );
  }
}
