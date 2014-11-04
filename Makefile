# HEY! Replace orcl below with the sid or service name of your database
all:
	$(ORACLE_HOME)/sdk/proc config=ora.cfg userid=scott/tiger@orcl mac_ora_cpp_test.pc
	clang++ -Wall\
		-std=c++11\
		-Wno-unused-const-variable\
		-Wno-unused-variable\
		-I$(ORACLE_HOME)/sdk/include\
		-L$(ORACLE_HOME)/\
		-lclntsh\
		mac_ora_cpp_test.cpp\
		-o mac_ora_cpp_test

