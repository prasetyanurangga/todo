import 'package:flutter/material.dart';
import 'package:todo/helper/db_helper.dart';
import 'package:todo/models/task.dart';
import 'package:get/get.dart';

class CheckTaskController extends GetxController{

	final checkTaskModelList = List<CheckTask>().obs;
	final checkedTaskCount = 0.obs;
	final checkTaskCount = 0.obs;

	final taskCountList = List<Map<String, dynamic>>().obs;

	@override
	  void onReady() {
	    getCheckTask(1);
	    for (var task in tasks) { 
	    	getCheckedCheckTaskCount(task.id);
	    	getAllCheckTaskCount(task.id);
	    	taskCountList.insert(task.id, { 'all' : checkTaskCount.value, 'checked' : checkedTaskCount.value});
		} 
	    
	    super.onReady();
	  }

	

	TextEditingController contentTextController = TextEditingController();

	Future<void> addCheckTask(int id_task) async => await DBHelper.insert(
		CheckTask(
			idTask: id_task,
			name : contentTextController.text,
			checked : 0
		)
	);

	void updateCheckTask(CheckTask checkTask) async { 
		await DBHelper.update(checkTask);
		getCheckTask(checkTask.idTask);
	}

	void getCheckTask(int id_task) async {
		contentTextController.text = '';
		List<Map<String, dynamic>> checkTaskList = await DBHelper.getbyid(id_task);
		checkTaskModelList.value = checkTaskList.map((data) => new CheckTask.fromJson(data)).toList();
	}

	void getCheckedCheckTaskCount(int id_task) async {
		contentTextController.text = '';
		List<Map<String, dynamic>> checkTaskList = await DBHelper.getchecked(id_task);
		checkedTaskCount.value = checkTaskList.length;
	}

	void getAllCheckTaskCount(int id_task) async {
		contentTextController.text = '';
		List<Map<String, dynamic>> checkTaskList = await DBHelper.getchecked(id_task);
		checkTaskCount.value = checkTaskList.length;
	}
}