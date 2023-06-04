import 'package:flutter/material.dart';
import 'package:scoutes/utilis/global_variables.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
   int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
     super.dispose();
     pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
      setState(() {
      _page = page;
    });
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.black,
        centerTitle: false,
        title: const Text(
          'Scoutes',
          selectionColor: Colors.white,
        ),
        actions: [  IconButton(
            onPressed: () => navigationTapped(0),
            icon:  Icon(
              Icons.home,
              color: _page ==0? Colors.white: Colors.purple,
            ),
          ),
            IconButton(
            onPressed: () => navigationTapped(1),
            icon:  Icon(
              Icons.search,
              color:_page ==1? Colors.white: Colors.purple,
            ),
          ),
            IconButton(
            onPressed: () => navigationTapped(2),
            icon:  Icon(
              Icons.add_a_photo,
              color: _page ==2? Colors.white: Colors.purple,
            ),
          ),
            IconButton(
            onPressed: () => navigationTapped(3),
            icon:  Icon(
              Icons.favorite,
              color: _page ==3? Colors.white: Colors.purple,
            ),
          ),
          IconButton(
            onPressed: () => navigationTapped(4),
            icon: Icon(
              Icons.person,
              color: _page ==4? Colors.white: Colors.purple,
            ),
          ),
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        children: homeScreenItems,
        controller: pageController,
        onPageChanged: onPageChanged,
      ),      
    );
  }
}
