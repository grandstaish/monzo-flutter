import 'dart:ui' as ui show TextBox, lerpDouble;

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// The Monzo logo, in widget form. This widget respects the [IconTheme].
///
/// See also:
///
///  * [IconTheme], which provides ambient configuration for icons.
///  * [Icon], for showing icons the Material design icon library.
///  * [ImageIcon], for showing icons from [AssetImage]s or other [ImageProvider]s.
class MonzoLogo extends StatelessWidget {
  /// Creates a widget that paints the Monzo logo.
  const MonzoLogo({
    Key key,
    this.width,
    this.height,
    this.textColor: const Color(0xFF616161),
    this.style: MonzoLogoStyle.markOnly,
    this.duration: const Duration(milliseconds: 750),
    this.curve: Curves.fastOutSlowIn,
  }) : super(key: key);

  /// The width of the logo in logical pixels.
  ///
  /// Defaults to the current [IconTheme] size, if any. If there is no
  /// [IconTheme], or it does not specify an explicit width, then it defaults
  /// to 24.0.
  final double width;

  /// The height of the logo in logical pixels.
  ///
  /// Defaults to the current [IconTheme] size, if any. If there is no
  /// [IconTheme], or it does not specify an explicit height, then it defaults
  /// to 24.0.
  final double height;

  /// The color used to paint the "Monzo" text on the logo, if [style] is
  /// [MonzoLogoStyle.horizontal] or [MonzoLogoStyle.stacked].
  final Color textColor;

  /// Whether and where to draw the "Monzo" text. By default, only the logo
  /// itself is drawn.
  final MonzoLogoStyle style;

  /// The length of time for the animation if the [style], [colors], or
  /// [textColor] properties are changed.
  final Duration duration;

  /// The curve for the logo animation if the [style], [colors], or [textColor]
  /// change.
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    final double widthSize = width ?? iconTheme.size;
    final double heightSize = height ?? iconTheme.size;
    return new AnimatedContainer(
      width: widthSize,
      height: heightSize,
      duration: duration,
      curve: curve,
      decoration: new MonzoLogoDecoration(
        style: style,
        textColor: textColor,
      ),
    );
  }
}

/// Possible ways to draw Monzo's logo.
enum MonzoLogoStyle {
  /// Show only Monzo's logo, not the "Monzo" label.
  ///
  /// This is the default behavior for [MonzoLogoDecoration] objects.
  markOnly,

  /// Show Monzo's logo on the left, and the "Monzo" label to its right.
  horizontal,

  /// Show Monzo's logo above the "Monzo" label.
  stacked,
}

/// An immutable description of how to paint Monzo's logo.
class MonzoLogoDecoration extends Decoration {
  /// Creates a decoration that knows how to paint Monzo's logo.
  ///
  /// The [style] controls whether and where to draw the "Monzo" label. If one
  /// is shown, the [textColor] controls the color of the label.
  ///
  /// The textColor], [style], and [margin] arguments must not be null.
  const MonzoLogoDecoration({
    this.textColor: const Color(0xFF616161),
    this.style: MonzoLogoStyle.markOnly,
    this.margin: EdgeInsets.zero,
  }) : assert(textColor != null),
        assert(style != null),
        assert(margin != null),
        _position = style == MonzoLogoStyle.markOnly ? 0.0 : style == MonzoLogoStyle.horizontal ? 1.0 : -1.0, // ignore: CONST_EVAL_TYPE_BOOL_NUM_STRING
        _opacity = 1.0;

  const MonzoLogoDecoration._(this.textColor, this.style, this.margin, this._position, this._opacity);

  /// The color used to paint the "Monzo" text on the logo, if [style] is
  /// [MonzoLogoStyle.horizontal] or [MonzoLogoStyle.stacked].
  final Color textColor;

  /// Whether and where to draw the "Monzo" text. By default, only the logo
  /// itself is drawn.
  final MonzoLogoStyle style;

  /// How far to inset the logo from the edge of the container.
  final EdgeInsets margin;

  final double _position; // -1.0 for stacked, 1.0 for horizontal, 0.0 for no logo
  final double _opacity; // 0.0 .. 1.0

  bool get _inTransition => _opacity != 1.0 || (_position != -1.0 && _position != 0.0 && _position != 1.0);

  @override
  bool debugAssertIsValid() {
    assert(textColor != null
        && style != null
        && margin != null
        && _position != null
        && _position.isFinite
        && _opacity != null
        && _opacity >= 0.0
        && _opacity <= 1.0);
    return true;
  }

  @override
  bool get isComplex => !_inTransition;

  /// Linearly interpolate between two Monzo logo descriptions.
  ///
  /// Interpolates both the color and the style in a continuous fashion.
  ///
  /// If both values are null, this returns null. Otherwise, it returns a
  /// non-null value. If one of the values is null, then the result is obtained
  /// by scaling the other value's opacity and [margin].
  ///
  /// The `t` argument represents position on the timeline, with 0.0 meaning
  /// that the interpolation has not started, returning `a` (or something
  /// equivalent to `a`), 1.0 meaning that the interpolation has finished,
  /// returning `b` (or something equivalent to `b`), and values in between
  /// meaning that the interpolation is at the relevant point on the timeline
  /// between `a` and `b`. The interpolation can be extrapolated beyond 0.0 and
  /// 1.0, so negative values and values greater than 1.0 are valid (and can
  /// easily be generated by curves such as [Curves.elasticInOut]).
  ///
  /// Values for `t` are usually obtained from an [Animation<double>], such as
  /// an [AnimationController].
  ///
  /// See also:
  ///
  ///  * [Decoration.lerp], which interpolates between arbitrary decorations.
  static MonzoLogoDecoration lerp(MonzoLogoDecoration a, MonzoLogoDecoration b, double t) {
    assert(t != null);
    assert(a == null || a.debugAssertIsValid());
    assert(b == null || b.debugAssertIsValid());
    if (a == null && b == null)
      return null;
    if (a == null) {
      return new MonzoLogoDecoration._(
        b.textColor,
        b.style,
        b.margin * t,
        b._position,
        b._opacity * t.clamp(0.0, 1.0),
      );
    }
    if (b == null) {
      return new MonzoLogoDecoration._(
        a.textColor,
        a.style,
        a.margin * t,
        a._position,
        a._opacity * (1.0 - t).clamp(0.0, 1.0),
      );
    }
    if (t == 0.0)
      return a;
    if (t == 1.0)
      return b;
    return new MonzoLogoDecoration._(
      Color.lerp(a.textColor, b.textColor, t),
      t < 0.5 ? a.style : b.style,
      EdgeInsets.lerp(a.margin, b.margin, t),
      a._position + (b._position - a._position) * t,
      (a._opacity + (b._opacity - a._opacity) * t).clamp(0.0, 1.0),
    );
  }

  @override
  MonzoLogoDecoration lerpFrom(Decoration a, double t) {
    assert(debugAssertIsValid());
    if (a == null || a is MonzoLogoDecoration) {
      assert(a == null || a.debugAssertIsValid());
      return MonzoLogoDecoration.lerp(a, this, t);
    }
    return super.lerpFrom(a, t);
  }

  @override
  MonzoLogoDecoration lerpTo(Decoration b, double t) {
    assert(debugAssertIsValid());
    if (b == null || b is MonzoLogoDecoration) {
      assert(b == null || b.debugAssertIsValid());
      return MonzoLogoDecoration.lerp(this, b, t);
    }
    return super.lerpTo(b, t);
  }

  @override
  bool hitTest(Size size, Offset position, { TextDirection textDirection }) {
    return true;
  }

  @override
  BoxPainter createBoxPainter([VoidCallback onChanged]) {
    assert(debugAssertIsValid());
    return new _MonzoLogoPainter(this);
  }

  @override
  bool operator ==(dynamic other) {
    assert(debugAssertIsValid());
    if (identical(this, other))
      return true;
    if (other is! MonzoLogoDecoration)
      return false;
    final MonzoLogoDecoration typedOther = other;
    return textColor == typedOther.textColor
        && _position == typedOther._position
        && _opacity == typedOther._opacity;
  }

  @override
  int get hashCode {
    assert(debugAssertIsValid());
    return hashValues(textColor, _position, _opacity);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(new DiagnosticsNode.message('$textColor'));
    properties.add(new EnumProperty<MonzoLogoStyle>('style', style));
    if (_inTransition)
      properties.add(new DiagnosticsNode.message('transition $_position:$_opacity'));
  }
}


/// An object that paints a [BoxDecoration] into a canvas.
class _MonzoLogoPainter extends BoxPainter {
  _MonzoLogoPainter(this._config)
      : assert(_config != null),
        assert(_config.debugAssertIsValid()),
        super(null) {
    _prepareText();
  }

  final MonzoLogoDecoration _config;

  // these are configured assuming a font size of 100.0.
  TextPainter _textPainter;
  Rect _textBoundingRect;

  void _prepareText() {
    const String kLabel = 'monzo';
    _textPainter = new TextPainter(
      text: new TextSpan(
        text: kLabel,
        style: new TextStyle(
          color: _config.textColor,
          fontFamily: 'MontserratBold',
          fontSize: 100.0 * 68.0 / 42.0,
          textBaseline: TextBaseline.alphabetic,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    _textPainter.layout();
    final ui.TextBox textSize = _textPainter.getBoxesForSelection(const TextSelection(baseOffset: 0, extentOffset: kLabel.length)).single;
    _textBoundingRect = new Rect.fromLTRB(textSize.left, textSize.top, textSize.right, textSize.bottom);
  }

  // This class contains a lot of magic numbers. They were derived from the
  // values in the SVG files exported from the original artwork source.

  void _paintLogo(Canvas canvas, Rect rect) {
    // Our points are in a coordinate space that's 94 pixels wide and 85 pixels high.
    // First, transform the rectangle so that our coordinate space is a square 94 pixels
    // to a side, with the top left at the origin.
    canvas.save();
    canvas.translate(rect.left, rect.top);
    canvas.scale(rect.width / 94.0, rect.height / 94.0);
    // Next, offset it some more so that the 85 vertical pixels are centered
    // in that square (as opposed to being on the top side of it).
    canvas.translate(0.0, (94.0 - 85.0) / 2.0);

    // Set up the styles.
    final Paint redPaint = new Paint()
      ..color = const Color(0xFFE34B5F);
    final Paint yellowPaint = new Paint()
      ..color = const Color(0xFFE7CE9C);
    final Paint bluePaint = new Paint()
      ..color = const Color(0xFF1E7889);
    final Paint greenPaint = new Paint()
      ..color = const Color(0xFF97BAA6);

    // Draw the basic shape.
    final Path redPath = new Path()
      ..moveTo(93.41, 61.37)
      ..relativeArcToPoint(const Offset(-1.265, 3.053), radius: const Radius.circular(4.32))
      ..lineTo(72.814, 83.756)
      ..relativeCubicTo(-1.087, 1.088, -2.947, 0.317, -2.947, -1.22)
      ..lineTo(69.867, 39.214)
      ..lineTo(93.41, 16.07)
      ..lineTo(93.41, 61.37);
    canvas.drawPath(redPath, redPaint);

    final Path yellowPath = new Path()
      ..moveTo(77.983, 0.64)
      ..relativeArcToPoint(const Offset(-2.442, 0.0), radius: const Radius.circular(1.727), clockwise: false)
      ..lineTo(46.798, 29.388)
      ..relativeLineTo(0.0, 33.298)
      ..relativeLineTo(46.611, -46.618)
      ..lineTo(77.983, 0.64);
    canvas.drawPath(yellowPath, yellowPaint);

    final Path bluePath = new Path()
      ..moveTo(0.187, 61.37)
      ..relativeArcToPoint(const Offset(1.264, 3.053), radius: const Radius.circular(4.32), clockwise: false)
      ..relativeLineTo(19.331, 19.333)
      ..relativeCubicTo(1.087, 1.088, 2.947, 0.317, 2.947, -1.22)
      ..lineTo(23.729, 39.214)
      ..lineTo(0.187, 16.07)
      ..lineTo(0.187, 61.37);
    canvas.drawPath(bluePath, bluePaint);

    final Path greenPath = new Path()
      ..moveTo(18.055, 0.64)
      ..relativeArcToPoint(const Offset(-2.442, 0.0), radius: const Radius.circular(1.727), clockwise: false)
      ..lineTo(0.187, 16.068)
      ..relativeLineTo(23.542, 23.546)
      ..lineTo(46.8, 62.686)
      ..lineTo(46.8, 29.388)
      ..lineTo(18.054, 0.64);
    canvas.drawPath(greenPath, greenPaint);

    canvas.restore();
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    offset += _config.margin.topLeft;
    final Size canvasSize = _config.margin.deflateSize(configuration.size);
    if (canvasSize.isEmpty) {
      return;
    }

    Size logoSize;
    if (_config._position > 0.0) {
      // horizontal style
      logoSize = const Size(136.0, 30.0);
    } else if (_config._position < 0.0) {
      // stacked style
      logoSize = const Size(699.0, 665.0);
    } else {
      // only the mark
      logoSize = const Size(30.0, 30.0);
    }

    final FittedSizes fittedSize = applyBoxFit(BoxFit.contain, logoSize, canvasSize);
    assert(fittedSize.source == logoSize);
    final Rect rect = Alignment.center.inscribe(fittedSize.destination, offset & canvasSize);
    final double centerSquareHeight = canvasSize.shortestSide;
    final Rect centerSquare = new Rect.fromLTWH(
        offset.dx + (canvasSize.width - centerSquareHeight) / 2.0,
        offset.dy + (canvasSize.height - centerSquareHeight) / 2.0,
        centerSquareHeight,
        centerSquareHeight
    );

    Rect logoTargetSquare;
    if (_config._position > 0.0) {
      // horizontal style
      logoTargetSquare = new Rect.fromLTWH(rect.left, rect.top, rect.height, rect.height);
    } else if (_config._position < 0.0) {
      // stacked style
      final double logoHeight = rect.height * 420.0 / 665.0;
      logoTargetSquare = new Rect.fromLTWH(
          rect.left + (rect.width - logoHeight) / 2.0,
          rect.top,
          logoHeight,
          logoHeight
      );
    } else {
      // only the mark
      logoTargetSquare = centerSquare;
    }

    final Rect logoSquare = Rect.lerp(centerSquare, logoTargetSquare, _config._position.abs());

    if (_config._opacity < 1.0) {
      canvas.saveLayer(
          offset & canvasSize,
          new Paint()
            ..colorFilter = new ColorFilter.mode(
              const Color(0xFFFFFFFF).withOpacity(_config._opacity),
              BlendMode.modulate,
            )
      );
    }

    if (_config._position != 0.0) {

      if (_config._position > 0.0) {
        // horizontal style
        final double fontSize = logoSquare.height * (1 - 13.0 / 30.0);

        final double scale = fontSize / 100.0;

        final double finalLeftTextPosition = (41.0 / 136.0) * rect.width - (6 / 68.0) * fontSize;

        final double initialLeftTextPosition = rect.width / 2.0 - _textBoundingRect.width * scale;

        final Offset textOffset = new Offset(
            rect.left + ui.lerpDouble(initialLeftTextPosition, finalLeftTextPosition, _config._position),
            rect.top + (rect.height - _textBoundingRect.height * scale) / 2.0 - (16 / 68.0) * fontSize
        );

        canvas.save();

        canvas.clipRect(new Rect.fromLTRB(logoSquare.right, rect.top, canvasSize.width, rect.bottom));

        canvas.translate(textOffset.dx, textOffset.dy);

        canvas.scale(scale, scale);

        _textPainter.paint(canvas, Offset.zero);

        canvas.restore();
      } else if (_config._position < 0.0) {
        // stacked style
        final double fontSize = 0.5 * logoTargetSquare.height * (1 - 13.0 / 30.0);

        final double scale = fontSize / 100.0;

        canvas.save();

        canvas.translate(
            logoTargetSquare.center.dx - (_textBoundingRect.width * scale / 2.0),
            logoTargetSquare.bottom
        );

        canvas.scale(scale, scale);

        _textPainter.paint(canvas, Offset.zero);

        canvas.restore();
      }
    }

    _paintLogo(canvas, logoSquare);

    if (_config._opacity < 1.0) {
      canvas.restore();
    }
  }
}
