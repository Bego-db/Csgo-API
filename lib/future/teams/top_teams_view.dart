import 'package:csgo/product/model/top_teams_model.dart';
import 'package:csgo/product/service/top_teams_services.dart';
import 'package:flutter/material.dart';

class TopTeamsView extends StatefulWidget {
  const TopTeamsView({super.key});

  @override
  State<TopTeamsView> createState() => _TopTeamsViewState();
}

class _TopTeamsViewState extends State<TopTeamsView> {
  final TopTeamsServices _services = TopTeamsServices();
  late Future<List<TopTeams>?> _topTeams;
  bool isActive = false;
  int genislet = -1;
  @override
  void initState() {
    super.initState();
    _topTeams = _services.getTopTeams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _topTeams,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Bir Hata Oldu"),
            );
          } else {
            final topTeamsData = snapshot.data!;
            return listViewTeamsCard(topTeamsData);
          }
        },
      ),
    );
  }

  ListView listViewTeamsCard(List<TopTeams> topTeamsData) {
    return ListView.separated(
            separatorBuilder: (context, index) =>
                const Padding(padding: EdgeInsets.only(bottom: 10)),
            itemCount: topTeamsData.length,
            itemBuilder: (context, index) {
              final topTeamsPlayers = topTeamsData[index].players;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    genislet = index;
                  });
                },
                child: TeamsCardWidget(
                  isActive: index == genislet,
                  index: index,
                  topTeamsPlayers: topTeamsPlayers,
                  topTeamsData: topTeamsData,
                ),
              );
            },
          );
  }
}

class TeamsCardWidget extends StatelessWidget {
  final List<Players>? topTeamsPlayers;
  final List<TopTeams> topTeamsData;
  final int index;
  final bool isActive;
  const TeamsCardWidget({
    super.key,
    required this.topTeamsPlayers,
    required this.topTeamsData,
    required this.index,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(21), color: Colors.black),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: 45,
                        height: 45,
                        child: Image.network(
                          "https://www.konfeo.com/en/wp-content/uploads/sites/3/2019/09/Konfeo-dream-team-min-930x400.png",
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topTeamsData[index].name ?? "Hata",
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      topTeamsData[index].id.toString(),
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Text(
                      topTeamsData[index].ranking.toString(),
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )
              ],
            ),
            isActive
                ? Column(
                    children: [
                      const Text(
                        "Players",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 220,
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          separatorBuilder: (context, index) => const Padding(
                              padding: EdgeInsets.only(right: 20)),
                          scrollDirection: Axis.horizontal,
                          itemCount: topTeamsPlayers!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 120,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 80,
                                      child: Image.network(
                                          "https://media.istockphoto.com/id/1332100919/tr/vekt%C3%B6r/man-icon-black-icon-person-symbol.jpg?s=2048x2048&w=is&k=20&c=NAyMvVW-5t77ItryTf6wvTEe5KlIhL8mSKuXPMIgld4="),
                                    ),
                                    Text(
                                      topTeamsPlayers![index]
                                          .fullname
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(),
                                    ),
                                    Text(
                                      topTeamsPlayers![index]
                                          .nickname
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            topTeamsPlayers![index]
                                                .country!
                                                .name
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(),
                                          ),
                                          SizedBox(
                                            height: 15,
                                            child: Image.network(
                                                "https://upload.wikimedia.org/wikipedia/commons/b/bb/Turkey_flag_300.png"),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  )
                : const SizedBox()
          ]),
        ),
      ),
    );
  }
}
