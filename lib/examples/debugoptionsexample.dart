import 'package:ar_flutter_plugin_2/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin_2/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin_2/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin_2/managers/ar_anchor_manager.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin_2/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin_2/datatypes/config_planedetection.dart';

class DebugOptionsWidget extends StatefulWidget {
  const DebugOptionsWidget({super.key});
  @override
  _DebugOptionsWidgetState createState() => _DebugOptionsWidgetState();
}

class _DebugOptionsWidgetState extends State<DebugOptionsWidget> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  bool _showFeaturePoints = false;
  bool _showPlanes = false;
  bool _showWorldOrigin = false;
  final bool _showAnimatedGuide = true;
  final String _planeTexturePath = "Images/triangle.png";
  final bool _handleTaps = false;

  @override
  void dispose() {
    super.dispose();
    arSessionManager!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debug Options')),
      body: Container(
        child: Stack(
          children: [
            ARView(
              onARViewCreated: onARViewCreated,
              planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
              showPlatformType: true,
            ),
            Align(
              alignment: FractionalOffset.bottomRight,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                color: Color(0x0fffffff).withOpacity(0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SwitchListTile(
                      title: const Text('Feature Points'),
                      value: _showFeaturePoints,
                      onChanged: (bool value) {
                        setState(() {
                          _showFeaturePoints = value;
                          updateSessionSettings();
                        });
                      },
                    ),
                    SwitchListTile(
                      title: const Text('Planes'),
                      value: _showPlanes,
                      onChanged: (bool value) {
                        setState(() {
                          _showPlanes = value;
                          updateSessionSettings();
                        });
                      },
                    ),
                    SwitchListTile(
                      title: const Text('World Origin'),
                      value: _showWorldOrigin,
                      onChanged: (bool value) {
                        setState(() {
                          _showWorldOrigin = value;
                          updateSessionSettings();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onARViewCreated(
    ARSessionManager arSessionManager,
    ARObjectManager arObjectManager,
    ARAnchorManager arAnchorManager,
    ARLocationManager arLocationManager,
  ) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;

    this.arSessionManager!.onInitialize(
      showFeaturePoints: _showFeaturePoints,
      showPlanes: _showPlanes,
      customPlaneTexturePath: _planeTexturePath,
      showWorldOrigin: _showWorldOrigin,
      showAnimatedGuide: _showAnimatedGuide,
      handleTaps: _handleTaps,
    );
    this.arObjectManager!.onInitialize();
  }

  void updateSessionSettings() {
    arSessionManager!.onInitialize(
      showFeaturePoints: _showFeaturePoints,
      showPlanes: _showPlanes,
      customPlaneTexturePath: _planeTexturePath,
      showWorldOrigin: _showWorldOrigin,
    );
  }
}
