import 'package:csgo/product/service/matches_result_services.dart';
import 'package:csgo/product/model/cs_model.dart';
import 'package:flutter/material.dart';

class MathResultView extends StatefulWidget {
  const MathResultView({super.key});

  @override
  State<MathResultView> createState() => _MathResultViewState();
}

class _MathResultViewState extends State<MathResultView> {
  final MatchResultService _matchResultService = MatchResultService();
  late Future<List<MatchesResultModel>?> _matchResults;
  final String errorPath =
      "https://community.akamai.steamstatic.com/economy/image/IzMF03bi9WpSBq-S-ekoE33L-iLqGFHVaU25ZzQNQcXdB2ozio1RrlIWFK3UfvMYB8UsvjiMXojflsZalyxSh31CIyHz2GZ-KuFpPsrTzBGp8bPUU3biajXIKh7ICVt7CeoBaweFr3HysPORQz3NE7p4EgkNLKpS8G0bP5iANxpugIZY82HglBMrHEV-cJFFKVfuhGQdNvsmxy0dN8YXxWCpZsiQiFdlbEJuXq9lB0LZ/330x192";

  @override
  void initState() {
    super.initState();
    _matchResults = _matchResultService.fetchMatchResults();
  }

  @override
  Widget build(BuildContext context) {
    const appBarTitle = "Cs:Go Matches";
    return Scaffold(
        appBar: const MatchesAppBar(appBarTitle: appBarTitle),
        body: _MathResultFuture(
            matchResults: _matchResults, errorPath: errorPath));
  }
}

class _MathResultFuture extends StatelessWidget {
  const _MathResultFuture({
    required Future<List<MatchesResultModel>?> matchResults,
    required this.errorPath,
  }) : _matchResults = matchResults;

  final Future<List<MatchesResultModel>?> _matchResults;
  final String errorPath;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MatchesResultModel>?>(
      future: _matchResults,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.orangeAccent,
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text("Bir Hata İle Karşılaşıldı"));
        } else {
          final matchRespons = snapshot.data!;
          return ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                    endIndent: 100,
                    indent: 100,
                    color: Colors.blue,
                  ),
              itemCount: matchRespons.length,
              itemBuilder: (context, index) {
                final teamsRespons = matchRespons[index].teams;
                return _MatchesCard(
                  teamsRespons: teamsRespons!,
                  errorPath: errorPath,
                );
              });
        }
      },
    );
  }
}

class _MatchesCard extends StatelessWidget {
  const _MatchesCard({
    required this.errorPath,
    required this.teamsRespons,
  });
  final List<Teams> teamsRespons;
  final String errorPath;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Column(
              children: [
                _TeamLogoWidget(
                  errorPath: errorPath,
                  logoPath: errorPath, //teamsRespons[0].logo ??
                ),
                Text(
                  teamsRespons[0].name ?? "hata",
                ),
              ],
            ),
          ),
          Row(
            children: [
              _ResultContainer(
                  text: "${teamsRespons[0].result}",
                  res2: "${teamsRespons[1].result}"),
              const SizedBox(
                width: 5,
              ),
              _ResultContainer(
                  text: "${teamsRespons[1].result}",
                  res2: "${teamsRespons[0].result}"),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                _TeamLogoWidget(
                  errorPath: errorPath,
                  logoPath: errorPath, //teamsRespons[1].logo ??
                ),
                Text(
                  teamsRespons[1].name ?? "Hata",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TeamLogoWidget extends StatelessWidget {
  final String logoPath;
  const _TeamLogoWidget({
    required this.errorPath,
    required this.logoPath,
  });

  final String errorPath;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      logoPath,
      errorBuilder: (context, error, stackTrace) =>
          SizedBox(height: 70, child: Image.network(errorPath)),
      height: 50,
    );
  }
}

class _ResultContainer extends StatelessWidget {
  final String text;
  final String res2;
  const _ResultContainer({required this.text, required this.res2});

  bool resultControl(String result1, String result2) {
    final int res1 = int.parse(
      result1,
    );
    final int res2 = int.parse(
      result2,
    );
    if (res1 > res2) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool sonuc = resultControl(text, res2);
    return Container(
      width: 50,
      height: 40,
      decoration: BoxDecoration(
          color: sonuc ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(6)),
      child: Center(
        child: Text(
          text,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class MatchesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MatchesAppBar({
    super.key,
    required this.appBarTitle,
  });

  final String appBarTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.orangeAccent,
      centerTitle: true,
      title: Text(
        appBarTitle,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 50);
}
