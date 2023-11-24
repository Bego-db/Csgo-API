import 'package:csgo/future/teams/top_teams_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Widget> body = [
    const TopTeamsView(),
    const Text("AnaSayfa"),
    const Text("AnaSayfa"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: const HomeViewAppBar(),
      bottomNavigationBar: const NavBar(),
      body: body[0],
    );
  }
}

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color(0xff7A7A7A),
                blurRadius: 33,
                spreadRadius: 11,
                offset: Offset(0, -2))
          ],
          color: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      child: const Padding(
        padding: EdgeInsets.all(12.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          FlutterLogo(),
          FlutterLogo(),
          FlutterLogo(),
        ]),
      ),
    );
  }
}

class HomeViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeViewAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Color(0xff7A7A7A),
            blurRadius: 33,
            spreadRadius: 11,
            offset: Offset(0, 6))
      ]),
      child: AppBar(
        bottomOpacity: 9,
        clipBehavior: Clip.antiAlias,
        centerTitle: false,
        excludeHeaderSemantics: true,
        backgroundColor: Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(24),
          ),
        ),
        title: Text(
          "Welcome Back!",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 60);
}
