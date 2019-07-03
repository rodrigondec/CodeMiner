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
	mv docs/index.html index.html
	mv docs/table_of_contents.html table_of_contents.html
	rm -rf docs
	mv doc docs
	mv index.html docs/index.html
	mv table_of_contents.html docs/table_of_contents.html