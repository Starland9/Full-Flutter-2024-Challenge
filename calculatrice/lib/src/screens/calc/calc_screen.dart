import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:calculatrice/src/screens/calc/components/calc_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final isDark = AdaptiveTheme.of(context).mode != AdaptiveThemeMode.light;
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
            _buildExps(theme),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 26.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildRowScrollButtons(),
                    _buildCalcButtons(),
                  ],
                ),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _currentExpression,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.8),
                ),
                textAlign: TextAlign.end,
              ),
              const SizedBox(height: 8),
              Text(
                _finalExpression,
                style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface),
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
        if (isDark) {
          AdaptiveTheme.of(context).setLight();
        } else {
          AdaptiveTheme.of(context).setDark();
        }
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
                    : theme.colorScheme.onSurface,
                backgroundColor: e["filled"] == true
                    ? theme.colorScheme.primary.withOpacity(0.3)
                    : null,
                onTap: _manageExps,
              ),
            ),
          ],
        ),
        Row(
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
                    spacing: 0,
                    runSpacing: 0,
                    children: [
                      ...listNums,
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CalcButton(
                        text: "0",
                        size: Size(137.h, 60.h),
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
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CalcButton(
                    text: "-",
                    backgroundColor: theme.colorScheme.primary.withOpacity(0.3),
                    onTap: _manageExps,
                  ),
                  CalcButton(
                    text: "+",
                    size: Size(60.h, 97.5.h),
                    backgroundColor: theme.colorScheme.primary.withOpacity(0.3),
                    onTap: _manageExps,
                  ),
                  CalcButton(
                    text: "=",
                    size: Size(60.h, 97.5.h),
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
                      size: Size(60.w, 35.h),
                      fontSize: 14,
                      onTap: _manageExps,
                    );
            },
          ),
        ],
      ),
    );
  }

  SizedBox _bigSpacer() => SizedBox(height: 30.h);

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
      _finalExpression = "Erreur ❌";
    }

    setState(() {});
  }
}
