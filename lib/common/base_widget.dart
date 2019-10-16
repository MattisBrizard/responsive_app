import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_app/models/device_screen_type.dart';
import 'package:responsive_app/models/sizing_information.dart';

class BaseWidget extends StatelessWidget {
  const BaseWidget({
    Key key,
    @required this.builder,
  })  : assert(builder != null),
        super(key: key);

  final Widget Function(
    BuildContext context,
    SizingInformation sizingInformation,
  ) builder;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return LayoutBuilder(
      builder: (context, boxConstraints) {
        final sizingInformation = SizingInformation(
          orientation: mediaQuery.orientation,
          deviceScreenType: getDeviceType(mediaQuery),
          screenSize: mediaQuery.size,
          localWidgetSize: Size(
            boxConstraints.maxWidth,
            boxConstraints.maxHeight,
          ),
        );
        return builder(context, sizingInformation);
      },
    );
  }

  DeviceScreenType getDeviceType(MediaQueryData mediaQuery) {
    final orientation = mediaQuery.orientation;
    double deviceWidth = 0;

    if (kIsWeb) {
      deviceWidth = mediaQuery.size.width;

      if (deviceWidth > 950) {
        return DeviceScreenType.desktop;
      }
      return DeviceScreenType.mobile;
    } else {
      if (orientation == Orientation.landscape) {
        deviceWidth = mediaQuery.size.height;
      } else {
        deviceWidth = mediaQuery.size.width;
      }

      if (deviceWidth > 950) {
        return DeviceScreenType.desktop;
      }

      if (deviceWidth > 600) {
        return DeviceScreenType.tablet;
      }

      return DeviceScreenType.mobile;
    }
  }
}
