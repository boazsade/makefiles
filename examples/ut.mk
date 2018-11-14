project_root=$(shell while [ ! -f build.sh ]; do cd ..; done ; pwd )

BOOST_LIBS += boost_log boost_log_setup  \
	      boost_unit_test_framework boost_test_exec_monitor \
	      boost_thread boost_filesystem \
	      boost_system
#utils logging opencv z dl 
LIBS_LIST := ml_models 
APP_EXTRA_LIB += pthread svm
# -DPRINT_MODEL_RESULTS
CXXFLAGS += $(INCLUDE_DL_OP) $(BOOST_INCLUDE_FLAG) $(LIBSVM_INCLUDE_FLAG) -I../src/svm_impl
include $(project_root)/etc/makefiles/app_builder.mk
