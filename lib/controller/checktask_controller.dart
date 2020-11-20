import 'package:flutter/material.dart';
import 'package:todo/helper/db_helper.dart';
import 'package:todo/models/task.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckTaskController extends GetxController{

	final checkTaskModelList = List<CheckTask>().obs;
	final taskModelList = List<Task>().obs;
	var taskModel = Task().obs;

	final checkedTaskCount = 0.obs;
	final checkTaskCount = 0.obs;
	var dateNow = "".obs;
	var countTodoToday = 0.obs;

	@override
  	void onInit() { 
    	super.onInit();		
  		getTaskAll();
  		getCountTodoToday();
    	initTask();
  	}

  	@override
  	void onClose() {
    	checkTaskModelList.close();
    	taskModelList.close();
    	taskModel.close();
    	checkedTaskCount.close();
    	checkTaskCount.close();
    	dateNow.close();
    	super.onClose();
  	}

  	void initTask() async {
  		var newFormat = DateFormat("dd MMMM yyyy");
    	dateNow.value = newFormat.format(DateTime.now());	
    	print(dateNow.value);
  		await DBHelper.task_getall().then((List<Map<String, dynamic>> taskList){
  			print(taskList.length);
	  		if(taskList.length == 0){
	  			addTask(0,0, 'Personal');
	  			addTask(1,1, 'Work');
	  			addTask(2,2, 'Home');
	  		}
  		});
  	}

	

	TextEditingController contentTextController = TextEditingController();

	Future<void> addCheckTask(int id_task, String status) async {
		final now = DateTime.now();
		final today = DateTime(now.year, now.month, now.day);
		final tomorrow = DateTime(now.year, now.month, now.day + 1); 
		var newFormat = DateFormat("yyyy-MM-dd");
		await DBHelper.note_insert(
			CheckTask(
				idTask: id_task,
				name : contentTextController.text,
				checked : 0,
				createdAt : newFormat.format(((status == "Tomorrow") ? tomorrow : today)),
			)
		);
		
	}

	void updateCheckTask(CheckTask checkTask) async { 
		await DBHelper.note_update(checkTask);
		getCheckTask(checkTask.idTask);
	}

	void getCheckTask(int id_task) async {
		contentTextController.text = '';
		List<Map<String, dynamic>> checkTaskList = await DBHelper.note_getbyid(id_task);
		checkTaskModelList.value = checkTaskList.map((data) => new CheckTask.fromJson(data)).toList();
	}



	Future<void> addTask(int color,int icon, String name) async => await DBHelper.task_insert(
		Task(
			name : name,
			color : color,
			icon : icon,
		)
	);

	void updateTask(Task task) async { 
		await DBHelper.task_update(task);
	}

	void getTaskAll() async {
		List<Map<String, dynamic>> taskList = await DBHelper.task_getall();
		taskModelList.value = taskList.map((data) => new Task.fromJson(data)).toList();
	}

	void getCountTodoToday() async {
		final now = DateTime.now();
		var newFormat = DateFormat("yyyy-MM-dd");
		List<Map<String, dynamic>> checkTaskList = await DBHelper.note_today(newFormat.format(now));
		countTodoToday.value = checkTaskList.length;
	}

	void getTaskById(int id) async {
		Task task = await DBHelper.task_getbyid(id);
		taskModel.value = task;
	}
}