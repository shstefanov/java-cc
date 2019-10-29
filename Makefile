SHELL=bash
SOURCE_PATH=src
BUILD_PATH=bin
LIB_PATH=bin

CLASS_PATH=lib/*

class=main.App

COMPILE_COMMAND = javac $(SOURCE_PATH)/$(SOURCE_FILE) \
	-sourcepath $(SOURCE_PATH) \
	-cp $(SOURCE_PATH):$(CLASS_PATH) \
	-d $(BUILD_PATH)

RUN_COMMAND = java -cp $(BUILD_PATH):$(CLASS_PATH) $(class)

init:
	@ make class name=$(class)


compile:
	@ for JAVA_FILE in `find $(SOURCE_PATH) -name *.java`; do \
		SOURCE_FILE=`echo $$JAVA_FILE | sed -e 's/^$(SOURCE_PATH)\///'`; \
		TARGET_FILE=`echo $$SOURCE_FILE | sed -e 's/\.java$$/\.class/'`; \
		make -s $(BUILD_PATH)/$$TARGET_FILE SOURCE_FILE=$$SOURCE_FILE TARGET_FILE=$$TARGET_FILE; \
	done;

$(BUILD_PATH)/$(TARGET_FILE): $(SOURCE_PATH)/$(SOURCE_FILE)
	@ echo $$ $(COMPILE_COMMAND)
	@ $(COMPILE_COMMAND)


run:
	@ echo $$ $(RUN_COMMAND)
	@ $(RUN_COMMAND)


class:
	@ PACKAGE_NAME=`echo $(name) | sed -r 's/^(.*)\.([a-zA-Z0-9]+)$$/\1/'`; \
	  CLASS_NAME=`echo $(name) | sed -r 's/^(.*)\.([a-zA-Z0-9]+)$$/\2/'`; \
	  FOLDER_PATH=`echo $$PACKAGE_NAME | sed -e 's/\./\//g'`; \
	  FILE_NAME="$$CLASS_NAME.java"; \
	  make -s __create-class-file PACKAGE_NAME=$$PACKAGE_NAME CLASS_NAME=$$CLASS_NAME FOLDER_PATH=$$FOLDER_PATH FILE_NAME=$$FILE_NAME

__create-class-file: $(SOURCE_PATH)/$(FOLDER_PATH)/$(FILE_NAME)

$(SOURCE_PATH)/$(FOLDER_PATH)/$(FILE_NAME):
	@ echo "PACKAGE_NAME: $(PACKAGE_NAME), CLASS_NAME: $(CLASS_NAME), FOLDER_PATH: $(FOLDER_PATH), FILE_NAME: $(FILE_NAME)"
	@ mkdir -p $(SOURCE_PATH)/$(FOLDER_PATH)
	@ echo "package $(PACKAGE_NAME);" >> $(SOURCE_PATH)/$(FOLDER_PATH)/$(FILE_NAME)
	@ echo "" >> $(SOURCE_PATH)/$(FOLDER_PATH)/$(FILE_NAME)
	@ echo "" >> $(SOURCE_PATH)/$(FOLDER_PATH)/$(FILE_NAME)
	@ echo "public class $(CLASS_NAME) {" >> $(SOURCE_PATH)/$(FOLDER_PATH)/$(FILE_NAME)
	@ echo "" >> $(SOURCE_PATH)/$(FOLDER_PATH)/$(FILE_NAME)
	@ echo "}" >> $(SOURCE_PATH)/$(FOLDER_PATH)/$(FILE_NAME)
	@ echo "" >> $(SOURCE_PATH)/$(FOLDER_PATH)/$(FILE_NAME)

