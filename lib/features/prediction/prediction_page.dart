import 'package:body_checkup/common/widget/app_bar/appbar.dart';
import 'package:body_checkup/common/widget/custome%20_shapes/container/rounded_container.dart';
import 'package:body_checkup/features/prediction/prediction_controller.dart';
import 'package:body_checkup/utils/constants/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class PredictionPage extends StatelessWidget {
  const PredictionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PredictionController());

  return Scaffold(
    appBar: AppBar(
      title: const Text('Prediction Page'),
    ),
  );
  }

  Widget _buildTile(String title, String value) {
    return TRoundedContainer(
showborder: true,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Iconsax.health),
        title: Text(title),
        trailing: Text(value,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }
}
