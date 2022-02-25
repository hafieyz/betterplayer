import 'package:better_player/better_player.dart';
import 'package:better_player_example/constants.dart';
import 'package:flutter/material.dart';

class ClearKeyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ClearKeyState();
}

class _ClearKeyState extends State<ClearKeyPage> {
  late BetterPlayerController _clearKeyControllerNetwork;

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
    );

    _clearKeyControllerNetwork =
        BetterPlayerController(betterPlayerConfiguration);

    _setupDataSources();

    super.initState();
  }

  void _setupDataSources() async {
    var _clearKeyDataSourceNetwork = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        Constants.networkTestVideoEncryptUrl,
        drmConfiguration: BetterPlayerDrmConfiguration(
            drmType: BetterPlayerDrmType.clearKey,
            clearKey: BetterPlayerClearKeyUtils.generateKey({
              "394a40dfff6320fca4a327d7c3127610":
                  "68633db62849223bb7de00c64f87166f",
            })),
        useAsmsSubtitles: true,
        useAsmsTracks: true);

    _clearKeyControllerNetwork.setupDataSource(_clearKeyDataSourceNetwork);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HyperZTV"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "ClearKey Protection Network with valid key.",
                style: TextStyle(fontSize: 16),
              ),
            ),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayer(controller: _clearKeyControllerNetwork),
            ),
          ],
        ),
      ),
    );
  }
}
