import 'dart:async';
import 'dart:io';

import 'package:golden_toolkit/golden_toolkit.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return GoldenToolkit.runWithConfiguration(
    () async {
      await loadAppFonts();
      await testMain();
    },
    config: GoldenToolkitConfiguration(
      defaultDevices: const [
        Device.phone,
      ],
      enableRealShadows: true,
      // Golden tests are OS dependent. We allow running golden tests only from
      // MacOS. On CI we run unit tests on Linux machines. Just the
      // Golden tests are run on MacOS.
      skipGoldenAssertion: () => !Platform.isMacOS,
    ),
  );
}
