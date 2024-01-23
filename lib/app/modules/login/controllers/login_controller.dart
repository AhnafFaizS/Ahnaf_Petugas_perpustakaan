

import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:ahnap_petugas/app/data/constant/endpoint.dart';
import 'package:ahnap_petugas/app/data/model/storage_provider.dart';
import 'package:ahnap_petugas/app/data/provider/api_provider.dart';
import 'package:ahnap_petugas/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class LoginController extends GetxController {
  final loading = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //TODO: Implement LoginController

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    //cel status login jika sudah login akan di redirect ke menu hose
    String status = StorageProvider.read(StorageKey.status);
    log("Status : $status");
    if (status == "logged") {
      Get.offAllNamed(Routes.HOME);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  login() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        final response = await ApiProvider.instance().post(Endpoint.login,
            data: dio.FormData.fromMap(
                {
                  "username": usernameController.text.toString(),
                  "password": passwordController.text.toString()
                }));
        if (response.statusCode == 200) {
          await StorageProvider.write(StorageKey.status, "logged");
          Get.offAllNamed(Routes.HOME);
        } else {
          Get.snackbar("Soory", "Login Gagal", backgroundColor: Colors.orange);
        }
        loading(false);
      }
  }on dio.DioException catch (e) {
      loading(false);
      if (e.response != null) {
        Get.snackbar("Sorry", "${e.response?.data['message']}",
            backgroundColor: Colors.orange);
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      loading(false);
      Get.snackbar("Eror", e.toString(), backgroundColor: Colors.red);
    }
  }
}
