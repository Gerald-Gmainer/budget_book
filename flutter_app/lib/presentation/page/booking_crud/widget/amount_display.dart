import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';

class AmountDisplay extends StatefulWidget {
  const AmountDisplay({Key? key}) : super(key: key);

  @override
  State<AmountDisplay> createState() => AmountDisplayState();
}

class AmountDisplayState extends State<AmountDisplay> with SingleTickerProviderStateMixin {
  bool _shake = false;
  Color _backgroundColor = const Color(0x885F6971);

  void triggerShakeAnimation() async {
    setState(() {
      _shake = true;
      _backgroundColor = Colors.red;
    });
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      _shake = false;
      _backgroundColor = const Color(0x885F6971);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: _backgroundColor,
      ),
      child: ShakeWidget(
        duration: Duration(milliseconds: 3000),
        shakeConstant: ShakeHorizontalConstant2(),
        autoPlay: _shake,
        enableWebMouseHover: true,
        child: _buildView(),
      ),
    );
  }

  Widget _buildView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: BlocBuilder<CalculatorBloc, CalculatorState>(
        builder: (context, state) {
          final List<String> history = state is CalculatorUpdateState ? state.history : [];
          final double result = state is CalculatorUpdateState ? state.result : 0;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCurrency(context),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildHistory(history),
                  _buildResult(result),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCurrency(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        String value = "";
        if (state is ProfileLoadedState) {
          value = state.profileSetting.currency.symbol;
        }
        return Text(value, style: TextStyle(fontSize: 24, color: AppColors.primaryTextColor));
      },
    );
  }

  Widget _buildHistory(List<String> history) {
    return Text(history.join(), style: const TextStyle(fontSize: 18, color: AppColors.primaryTextColor));
  }

  Widget _buildResult(double result) {
    String resultFormatted = result == result.truncate() ? result.toStringAsFixed(0) : result.toStringAsFixed(2);
    return Text(resultFormatted, style: const TextStyle(fontSize: 38, color: AppColors.primaryTextColor));
  }
}
