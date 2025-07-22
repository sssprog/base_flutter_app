import 'package:base_flutter_app/ui/home/home_cubit.dart';
import 'package:base_flutter_app/ui/model/view_state.dart';
import 'package:base_flutter_app/ui/widget/view_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/rocket.dart';

class HomeScreen extends StatelessWidget {
  final void Function(Rocket) onItemClick;

  const HomeScreen({super.key, required this.onItemClick});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, ViewState<List<Rocket>>>(
        builder: (context, state) => ViewStateWidget(
          state: state,
          onRetry: () => context.read<HomeCubit>().loadRockets(),
          builder: (context, rockets) => ListView.builder(
            itemBuilder: (context, index) => _RocketItem(
              rocket: rockets[index],
              onClick: () => onItemClick(rockets[index]),
            ),
            itemCount: rockets.length,
          ),
        ),
      ),
    );
  }
}

class _RocketItem extends StatelessWidget {
  final Rocket rocket;
  final VoidCallback onClick;

  const _RocketItem({required this.rocket, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.network(
                fit: BoxFit.cover,
                rocket.images.first,
                loadingBuilder: (context, child, loadingProgress) =>
                    loadingProgress == null ? child : Container(color: Color(0xFF999999)),
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Color(0x44FF0000),
                  alignment: Alignment.center,
                  child: Text("Error"),
                ),
              ),
            ),
            SizedBox(height: 4),
            Text(
              rocket.name,
              style: TextTheme.of(context).titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
