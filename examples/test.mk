project_root ?= $(shell while [ ! -f build.sh ]; do cd ..; done ; pwd)
BOOST_LIBS += boost_system boost_filesystem
APP_EXTRA_LIB += svm
CXXFLAGS += $(INCLUDE_DL_OP) $(BOOST_INCLUDE_FLAG) $(LIBSVM_INCLUDE_FLAG)
LIBS_LIST := financial_insight currency_prediction  
include $(project_root)/etc/makefiles/app_builder.mk
