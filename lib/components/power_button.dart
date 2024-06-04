import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PowerButton extends StatefulWidget {
  const PowerButton({
    super.key,
    required this.onPressed,
    required this.status,
    this.size = 220,
  });

  final double size;
  final String status;
  final Function onPressed;

  @override
  State<PowerButton> createState() => _PowerButtonState();
}

class _PowerButtonState extends State<PowerButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        widget.onPressed();
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          gradient: _isPressed
              ? LinearGradient(
                  begin: Alignment(0.25, -0.97),
                  end: Alignment(-0.25, 0.97),
                  colors: [Color(0xFF383848), Color(0xFF414151)],
                )
              : const LinearGradient(
                  begin: Alignment(0.25, -0.97),
                  end: Alignment(-0.25, 0.97),
                  colors: [Color(0xFF414151), Color(0xFF383848)],
                ),
          shape: BoxShape.circle,
          border: Border.all(
              width: 1, color: Theme.of(context).colorScheme.background),
        ),
        child: Center(
          child: Container(
            width: widget.size * 0.7419354838709677,
            height: widget.size * 0.7419354838709677,
            decoration: BoxDecoration(
              gradient: _isPressed
                  ? LinearGradient(
                      begin: Alignment(0.49, -0.87),
                      end: Alignment(-0.49, 0.87),
                      colors: [Color(0xFF383848), Color(0xFF48485E)],
                    )
                  : const LinearGradient(
                      begin: Alignment(0.49, -0.87),
                      end: Alignment(-0.49, 0.87),
                      colors: [Color(0xFF48485E), Color(0xFF383848)],
                    ),
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: Color(0xFF5D5D76)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x26000000),
                  blurRadius: 50,
                  offset: const Offset(8, 12),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: widget.size * 0.5299596774193549,
                height: widget.size * 0.5299596774193549,
                decoration: BoxDecoration(
                  gradient: _isPressed
                      ? const LinearGradient(
                          begin: Alignment(0.55, -0.84),
                          end: Alignment(-0.55, 0.84),
                          colors: [Color(0xFF4A4A61), Color(0xFF39394C)],
                        )
                      : const LinearGradient(
                          begin: Alignment(0.55, -0.84),
                          end: Alignment(-0.55, 0.84),
                          colors: [Color(0xFF39394C), Color(0xFF4A4A61)],
                        ),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1, color: Color(0xFF5D5D76)),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/power.svg',
                    semanticsLabel: 'Power Icon',
                    height: widget.size * 0.24193548387096775,
                    width: widget.size * 0.24193548387096775,
                    colorFilter: ColorFilter.mode(
                      (widget.status == 'connected')
                          ? Theme.of(context).colorScheme.secondary
                          : Color(0xffA1A1AC),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
