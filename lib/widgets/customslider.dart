// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const CustomSlider({super.key, required this.value, required this.onChanged});

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.signal_cellular_alt_1_bar,
              color: Colors.orange, size: 40),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 25, // Adjust the height to accommodate larger thumb
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey,
              ),
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackShape: GradientRectSliderTrackShape(),
                  thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 20.0), // Increased thumb radius
                  trackHeight: 10.0, // Reduced track height
                  thumbColor: Colors.transparent, // Changed thumb color
                  overlayColor: Colors.transparent,
                ),
                child: Slider(
                  value: widget.value,
                  onChanged: widget.onChanged,
                  inactiveColor: Colors.deepOrange,
                  activeColor: Colors.deepOrange,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.light_mode, color: Colors.orange, size: 40),
        ],
      ),
    );
  }
}

class GradientRectSliderTrackShape extends SliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset? offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackTop =
        (offset?.dy ?? 0) + (parentBox.size.height - trackHeight) / 2;
    return Rect.fromLTWH(
        offset?.dx ?? 0, trackTop, parentBox.size.width, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    Offset? secondaryOffset,
    required TextDirection textDirection,
    required Animation<double> enableAnimation,
    Offset? thumbCenter,
    bool isDiscrete = false,
    bool isEnabled = true,
  }) {
    secondaryOffset ??= Offset.zero;
    final Rect rect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    context.canvas.drawRect(
      rect,
      Paint()..color = Colors.grey,
    );
  }
}
