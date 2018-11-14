project_root ?= $(shell while [ ! -f build.sh ]; do cd ..; done ; pwd)

include $(project_root)/etc/makefiles/app_builder.mk

#APPS_DIRECTORY := $(project_root)/prediction $(project_root)/training
LIBS_DIRECTORY := $(project_root)/libs
TARGET_REPO := $(project_root)/installs
TARGET_DIR := $(TARGET_REPO)
TARGET_FILE_BASE_NAME := backend_binaries
TARGET_VERSION_FILE := $(TARGET_DIR)/$(TARGET_FILE_BASE_NAME).tar.gz
#APPS_DIRS_TMP :=  $(dir $(wildcard $(APPS_DIRECTORY)/Makefile))
APPS_DIRS:= $(project_root)/prediction
#$(project_root)/training
TRAIN_APP := $(project_root)/apps/training
#$(dir $(APPS_DIRS_TMP))
LIBS_DIRS := $(dir $(wildcard $(LIBS_DIRECTORY)/*/ut/))
#APP_UT_DIRS := $(dir $(wildcard $(APPS_DIRECTORY)/*/ut/))
LIBS_UT_DIRS := $(LIBS_DIRS)
#APPS_NAMES := $(wildcard $(APPS_DIRECTORY)/*)
#APPS_DIRS := $(addprefix $(APPS_DIRECTORY)/, $(APPS_NAMES)) 
#APPS_DIRS := $(APPS_DIRS)
UT_DIRS := $(LIBS_UT_DIRS) $(APP_UT_DIRS)

.PHONY: apps_build $(APPS_DIRS) $(TRAIN_APP)
.PHONY: apps_uts $(UT_DIRS)
.PHONY: all $(UT_DIRS) $(APPS_DIRS) $(TRAIN_APP)
.PHONY: clean_all

#$(error "THIRD_PARTIES_DIR = $(THIRD_PARTIES_DIR)")
#$(error "apps dirs = $(APPS_DIRS)")

apps_build: $(APPS_DIRS) $(TRAIN_APP)

$(THIRD_PARTIES_DIR):
	@echo "$(THIRD_PARTIES_DIR) missing!"
	exit 1

$(TARGET_DIR):
	@echo "creating directory $(TARGET_DIR)"
	@mkdir -p $(TARGET_DIR)	

$(UT_DIRS):
	@echo "running unit test $@"
	@$(MAKE) -C $@ ut

$(TRAIN_APP):
	@echo "building training app $@"
	@$(MAKE) -C $@ app

$(APPS_DIRS):
	@echo "building $@"
	@$(MAKE) -C $@ addon

#install:
#	@echo "generating version $(VERSION_NUMBER) at $(TARGET_DIR)"
#	@rm -f ${TARGET_DIR}/$(TARGET_VERSION_FILE)
#	@$(project_root)/make_version.sh $(VERSION_NUMBER) $(TARGET_REPO) $(project_root) || exit 1
#	@echo "successfully generated installation file $(TARGET_VERSION_FILE)"

#$(TARGET_VERSION_FILE): apps_uts apps_build install $(THIRD_PARTIES_DIR) | $(TARGET_DIR) 
$(TARGET_VERSION_FILE): 
	@echo "not building anything yet - PLEASE FIX THAT ASAP"
	@echo "finish build and unit testing"

apps_uts: $(UT_DIRS)

all: $(UT_DIRS) $(APPS_DIRS) $(TRAIN_APP)

#version: $(TARGET_VERSION_FILE) 

clean_all:
	@rm -rf $(project_root)/build
	@for sub_lib in $(APPS_DIRS); do make --no-print-directory -C $$sub_lib clean; done
	@for sub_app in $(TRAIN_APP); do make --no-print-directory -C $$sub_app clean_app; done
	@find $(project_root) -name .objs | xargs rm -rf
	@find $(project_root) -name .depends | xargs rm -rf
