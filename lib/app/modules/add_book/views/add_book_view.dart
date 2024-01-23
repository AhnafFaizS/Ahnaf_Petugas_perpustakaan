import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_book_controller.dart';

class AddBookView extends GetView<AddBookController> {
  const AddBookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddBookView'),
        centerTitle: true,
      ),
      body: Center(
    child: Form(
    key: controller.formKey,
      child: Column(
        children: [
          TextFormField(
              controller: controller.judulController,
              decoration: InputDecoration(hintText: "Masukkan judul"),
              validator: (value){
                if (value!.length <5){
                  return "judul tidak boleh kosong";
                }
                return null;
              }
          ),
          TextFormField(
              controller: controller.penulisController,
              decoration: InputDecoration(hintText: "Masukkan penulis"),
              validator: (value){
                if (value!.length <5){
                  return "penulis tidak boleh kosong";
                }
                return null;
              }
          ),
          TextFormField(
              controller: controller.penerbitController,
              decoration: InputDecoration(hintText: "Masukkan penerbit"),
              validator: (value){
                if (value!.length <5){
                  return "penerbit tidak boleh kosong";
                }
                return null;
              }
          ),
          TextFormField(
              controller: controller.tahunTerbitController,
              decoration: InputDecoration(hintText: "Masukkan tahun terbit"),
              validator: (value){
                if (value!.length <5){
                  return "tahun terbit tidak boleh kosong";
                }
                return null;
              }
          ),
          Obx(() => controller.loading.value?
          CircularProgressIndicator():
          ElevatedButton(onPressed: () {
            controller.post();
          }, child: Text("Tambah"))
          )
        ],
      ),
    ),
    ),
    );
  }
}
