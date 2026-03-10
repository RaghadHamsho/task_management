import 'package:flutter/material.dart';
import '../common.dart';


extension WidgetExtension on Widget? {
  SizedBox withSize({double width = 0.0, double height = 0.0}) {
    return SizedBox(height: height, width: width, child: this);
  }

  SizedBox withWidth(double width) => SizedBox(width: width, child: this);

  SizedBox withHeight(double height) => SizedBox(height: height, child: this);

  Padding paddingTop(double top) {
    return Padding(padding: EdgeInsets.only(top: top), child: this);
  }

  Padding paddingLeft(double left) {
    return Padding(padding: EdgeInsets.only(left: left), child: this);
  }

  Padding paddingRight(double right) {
    return Padding(padding: EdgeInsets.only(right: right), child: this);
  }

  Padding paddingBottom(double bottom) {
    return Padding(padding: EdgeInsets.only(bottom: bottom), child: this);
  }

  Padding paddingAll(double padding) {
    return Padding(padding: EdgeInsets.all(padding), child: this);
  }

  Padding paddingOnly({
    double top = 0.0,
    double left = 0.0,
    double bottom = 0.0,
    double right = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: this,
    );
  }

  Padding paddingSymmetric({double vertical = 0.0, double horizontal = 0.0}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child: this,
    );
  }

  Widget visible(bool visible, {Widget? defaultWidget}) {
    return visible ? this! : (defaultWidget ?? const SizedBox());
  }

  ClipRRect cornerRadiusWithClipRRectOnly({
    int bottomLeft = 0,
    int bottomRight = 0,
    int topLeft = 0,
    int topRight = 0,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(bottomLeft.toDouble()),
        bottomRight: Radius.circular(bottomRight.toDouble()),
        topLeft: Radius.circular(topLeft.toDouble()),
        topRight: Radius.circular(topRight.toDouble()),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: this,
    );
  }

  ClipRRect cornerRadiusWithClipRRect(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: this,
    );
  }

  Widget opacity({
    required double opacity,
    int durationInSecond = 1,
    Duration? duration,
  }) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: duration ?? const Duration(milliseconds: 500),
      child: this,
    );
  }

  Widget rotate({
    required double angle,
    bool transformHitTests = true,
    Offset? origin,
  }) {
    return Transform.rotate(
      origin: origin,
      angle: angle,
      transformHitTests: transformHitTests,
      child: this,
    );
  }

  Widget scale({
    required double scale,
    Offset? origin,
    AlignmentGeometry? alignment,
    bool transformHitTests = true,
  }) {
    return Transform.scale(
      scale: scale,
      origin: origin,
      alignment: alignment,
      transformHitTests: transformHitTests,
      child: this,
    );
  }

  Widget translate({
    required Offset offset,
    bool transformHitTests = true,
    Key? key,
  }) {
    return Transform.translate(
      offset: offset,
      transformHitTests: transformHitTests,
      key: key,
      child: this,
    );
  }

  Widget center({double? heightFactor, double? widthFactor}) {
    return Center(
      heightFactor: heightFactor,
      widthFactor: widthFactor,
      child: this,
    );
  }

  Widget onTap(
    Function? function, {
    BorderRadius? borderRadius,
    Color? splashColor,
    Color? hoverColor,
    Color? highlightColor,
  }) {
    return InkWell(
      onTap: function as void Function()?,
      splashColor: splashColor ?? Colors.teal,
      hoverColor: hoverColor ?? Colors.teal,
      highlightColor: highlightColor ?? Colors.teal,
      child: this,
    );
  }

  Future<T?> launch<T>(BuildContext context,
      {bool isNewTask = false,
      PageRouteAnimation? pageRouteAnimation,
      Duration? duration}) async {
    if (isNewTask) {
      return await Navigator.of(context).pushAndRemoveUntil(
        buildPageRoute(
            this!, pageRouteAnimation ?? PageRouteAnimation.fade, duration),
        (route) => false,
      );
    } else {
      return await Navigator.of(context).push(
        buildPageRoute(
            this!, pageRouteAnimation ?? PageRouteAnimation.fade, duration),
      );
    }
  }

  Widget withShaderMask(
    List<Color> colors, {
    BlendMode blendMode = BlendMode.srcATop,
  }) {
    return withShaderMaskGradient(
      LinearGradient(colors: colors),
      blendMode: blendMode,
    );
  }

  Widget withShaderMaskGradient(
    Gradient gradient, {
    BlendMode blendMode = BlendMode.srcATop,
  }) {
    return ShaderMask(
      shaderCallback: (rect) => gradient.createShader(rect),
      blendMode: blendMode,
      child: this,
    );
  }

  Widget expand({flex = 1}) => Expanded(flex: flex, child: this!);

  Widget flexible({flex = 1, FlexFit? fit}) {
    return Flexible(flex: flex, fit: fit ?? FlexFit.loose, child: this!);
  }

  Widget fit({BoxFit? fit, AlignmentGeometry? alignment}) {
    return FittedBox(
      fit: fit ?? BoxFit.contain,
      alignment: alignment ?? Alignment.center,
      child: this,
    );
  }

  Widget validate({Widget value = const SizedBox()}) => this ?? value;

  Widget withTooltip({required String msg}) {
    return Tooltip(message: msg, child: this);
  }

  Widget get makeRefreshable {
    return Stack(children: [ListView(), this!]);
  }
}

