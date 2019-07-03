test:
	ruby test_runner.rb

task.1:
	ruby task1.rb

task.2:
	ruby task2.rb

task.plus:
	ruby task_plus.rb

rdoc:
	rdoc --all
	rm -rf docs
	mv doc docs