import 'package:calculatrice/src/blocs/theme/theme_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_expressions/math_expressions.dart';

class CalcScreen extends StatefulWidget {
  const CalcScreen({super.key});

  @override
  State<CalcScreen> createState() => _CalcScreenState();
}

class _CalcScreenState extends State<CalcScreen> {
  String _currentExpression = "0";
  String _finalExpression = "0";
  final Parser _parser = Parser();

  @override
  void initState() {
    _currentExpression = "0";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeBloc>().isDark;
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  _buildThemeSwither(isDark, context),
                  const Spacer(),
                  Text(
                    "Landry Calc",
                    style: TextStyle(
                      fontSize: 20,
                      color: theme.colorScheme.primary,
                    ),
                  )
                ],
              ),
            ),
            _bigSpacer(),
            _buildExps(theme),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  _buildRowScrollButtons(),
                  _buildCalcButtons(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding _buildExps(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _currentExpression,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onBackground.withOpacity(0.8),
                ),
                textAlign: TextAlign.end,
              ),
              const SizedBox(height: 8),
              Text(
                _finalExpression,
                style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onBackground),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ],
      ),
    );
  }

  CupertinoSwitch _buildThemeSwither(bool isDark, BuildContext context) {
    return CupertinoSwitch(
      activeColor: Theme.of(context).colorScheme.primary,
      value: isDark,
      onChanged: (value) {
        context.read<ThemeBloc>().add(ChangeThemeEvent(light: value));
      },
    );
  }

  Widget _buildCalcButtons() {
    final theme = Theme.of(context);
    final listNums = [7, 8, 9, 4, 5, 6, 1, 2, 3].map(
      (e) => CalcButton(
        text: e.toString(),
        onTap: _manageExps,
      ),
    );

    final listFirstSigns = [
      {
        "text": "AC",
        "filled": false,
      },
      {
        "text": "⌫",
        "filled": false,
      },
      {
        "text": "/",
        "filled": true,
      },
      {
        "text": "*",
        "filled": true,
      }
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ...listFirstSigns.map(
              (e) => CalcButton(
                text: e["text"].toString(),
                foregroundColor: e["filled"] == true
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onBackground,
                backgroundColor: e["filled"] == true
                    ? theme.colorScheme.primary.withOpacity(0.3)
                    : null,
                onTap: _manageExps,
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    children: [
                      ...listNums,
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CalcButton(
                        text: "0",
                        size: const Size(137, 60),
                        onTap: _manageExps,
                      ),
                      CalcButton(
                        text: ".",
                        onTap: _manageExps,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CalcButton(
                    text: "-",
                    backgroundColor: theme.colorScheme.primary.withOpacity(0.3),
                    onTap: _manageExps,
                  ),
                  CalcButton(
                    text: "+",
                    size: const Size(60, 97.5),
                    backgroundColor: theme.colorScheme.primary.withOpacity(0.3),
                    onTap: _manageExps,
                  ),
                  CalcButton(
                    text: "=",
                    size: const Size(60, 97.5),
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    elevation: 10,
                    onTap: _manageExps,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  SingleChildScrollView _buildRowScrollButtons() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...[".", "e", "µ", "sin", "deg", "cos", "tan"].map(
            (e) {
              return e == "."
                  ? const SizedBox()
                  : CalcButton(
                      text: e,
                      size: const Size(60, 35),
                      fontSize: 14,
                      onTap: _manageExps,
                    );
            },
          ),
        ],
      ),
    );
  }

  SizedBox _bigSpacer() => const SizedBox(height: 35);

  _manageExps(String exp) {
    if (_currentExpression == "0") {
      _currentExpression = "";
    }
    if (exp == "AC") {
      _currentExpression = "0";
    } else if (exp == "=") {
      onValidate();
    } else if (exp == "⌫") {
      _currentExpression =
          _currentExpression.substring(0, _currentExpression.length - 1);
      if (_currentExpression.isEmpty) {
        _currentExpression = "0";
      }
    } else {
      _currentExpression += exp;
    }

    setState(() {});
  }

  void onValidate() {
    try {
      final Expression expr = _parser.parse(_currentExpression);
      final result = expr.evaluate(EvaluationType.REAL, ContextModel());
      if (result is double) {
        _finalExpression = result.toString();
      }
    } catch (e) {
      print(e);
      _finalExpression = "Erreur ❌";
    }

    setState(() {});
  }
}

class CalcButton extends StatelessWidget {
  const CalcButton({
    super.key,
    required this.text,
    this.foregroundColor,
    this.fontSize,
    this.backgroundColor,
    this.size,
    this.radius,
    this.elevation,
    this.onTap,
  });

  final String text;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final double? fontSize;
  final Size? size;
  final double? radius;
  final double? elevation;
  final Function(String exp)? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? theme.colorScheme.background,
          elevation: isDark(theme) ? 5 : elevation ?? 0,
          shadowColor: isDark(theme)
              ? theme.colorScheme.onBackground.withOpacity(0.1)
              : null,
          padding: EdgeInsets.zero,
          minimumSize: size ?? const Size(0, 0),
          fixedSize: size ?? const Size(60, 60),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 35),
          ),
        ),
        onPressed: () {
          onTap?.call(text);
        },
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: foregroundColor ?? theme.colorScheme.primary,
              fontSize: fontSize ?? 22,
            ),
          ),
        ),
      ),
    );
  }

  bool isDark(ThemeData theme) => theme.brightness == Brightness.dark;
}
