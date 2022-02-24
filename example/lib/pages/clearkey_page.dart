import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

import 'package:better_player_example/constants.dart';
import 'package:better_player_example/utils.dart';

class ClearKeyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ClearKeyState();
}

class _ClearKeyState extends State<ClearKeyPage> {
  late BetterPlayerController _clearKeyControllerFile;
  late BetterPlayerController _clearKeyControllerBroken;
  late BetterPlayerController _clearKeyControllerNetwork;
  late BetterPlayerController _clearKeyControllerMemory;

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
    );
    _clearKeyControllerFile = BetterPlayerController(betterPlayerConfiguration);
    _clearKeyControllerBroken =
        BetterPlayerController(betterPlayerConfiguration);
    _clearKeyControllerNetwork =
        BetterPlayerController(betterPlayerConfiguration);
    _clearKeyControllerMemory =
        BetterPlayerController(betterPlayerConfiguration);

    _setupDataSources();

    super.initState();
  }

  void _setupDataSources() async {
    var _clearKeyDataSourceFile = BetterPlayerDataSource(
      BetterPlayerDataSourceType.file,
      await Utils.getFileUrl(Constants.fileTestVideoEncryptUrl),
      drmConfiguration: BetterPlayerDrmConfiguration(
          drmType: BetterPlayerDrmType.clearKey,
          clearKey: BetterPlayerClearKeyUtils.generateKey({
            "f3c5e0361e6654b28f8049c778b23946":
                "a4631a153a443df9eed0593043db7519",
            "abba271e8bcf552bbd2e86a434a9a5d9":
                "69eaa802a6763af979e8d1940fb88392"
          })),
    );

    _clearKeyControllerFile.setupDataSource(_clearKeyDataSourceFile);

    BetterPlayerDataSource _clearKeyDataSourceBroken = BetterPlayerDataSource(
      BetterPlayerDataSourceType.file,
      await Utils.getFileUrl(Constants.fileTestVideoEncryptUrl),
      drmConfiguration: BetterPlayerDrmConfiguration(
          drmType: BetterPlayerDrmType.clearKey,
          clearKey: BetterPlayerClearKeyUtils.generateKey({
            "f3c5e0361e6654b28f8049c778b23946":
                "a4631a153a443df9eed0593043d11111",
            "abba271e8bcf552bbd2e86a434a9a5d9":
                "69eaa802a6763af979e8d1940fb11111"
          })),
    );

    _clearKeyControllerBroken.setupDataSource(_clearKeyDataSourceBroken);

    var _clearKeyDataSourceNetwork = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      Constants.networkTestVideoEncryptUrl,
      drmConfiguration: BetterPlayerDrmConfiguration(
          drmType: BetterPlayerDrmType.clearKey,
          clearKey: BetterPlayerClearKeyUtils.generateKey({
            "0c626a3022340ea1d7af15e51a118a10":
                "543ce4c3e6139f46c4a95c57ef64f540",
          })),
    );

    _clearKeyControllerNetwork.setupDataSource(_clearKeyDataSourceNetwork);

    var _clearKeyDataSourceMemory = BetterPlayerDataSource(
      BetterPlayerDataSourceType.memory,
      "",
      bytes: File(await Utils.getFileUrl(Constants.fileTestVideoEncryptUrl))
          .readAsBytesSync(),
      drmConfiguration: BetterPlayerDrmConfiguration(
          drmType: BetterPlayerDrmType.clearKey,
          clearKey: BetterPlayerClearKeyUtils.generateKey({
            "f3c5e0361e6654b28f8049c778b23946":
                "a4631a153a443df9eed0593043db7519",
            "abba271e8bcf552bbd2e86a434a9a5d9":
                "69eaa802a6763af979e8d1940fb88392"
          })),
    );

    _clearKeyControllerMemory.setupDataSource(_clearKeyDataSourceMemory);
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
