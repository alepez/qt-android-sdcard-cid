QT_ROOT ?= /opt/Qt/5.8/gcc_64
QMAKE = $(QT_ROOT)/bin/qmake

APP_BUILD_DIR := $(BUILD_DIR)/app
PLUGIN_BUILD_DIR := $(BUILD_DIR)/plugin

SRC_FILES = $(shell find $(SRC_DIR) -type f)

APP_SRC_FILES = $(shell find $(SRC_DIR)/qml -type f) \
								$(shell find $(SRC_DIR)/fonts -type f) \
								$(shell find $(SRC_DIR)/images -type f) \
								$(shell find $(SRC_DIR)/js -type f) \
								$(SRC_DIR)/main.cpp \
								$(SRC_DIR)/app.qrc

PLUGIN_SRC_FILES = $(shell find $(SRC_DIR)/lib -type f) \
									 $(shell find $(SRC_DIR)/resources/data -type f) \
									 $(SRC_DIR)/plugin.qrc

.PHONY: default
default: all

.PHONY: all
all: plugin app

.PHONY: app plugin
app: $(DIST_DIR)/bin/SdcardCid

.PHONY: plugin
plugin: \
	$(DIST_DIR)/lib/plugins/net/pezzato/sdcardcid/libSdcardCidPlugin.so \
	$(DIST_DIR)/lib/plugins/net/pezzato/sdcardcid/qmldir

################################################################################
# Building Plugin
################################################################################

$(DIST_DIR)/lib/plugins/net/pezzato/sdcardcid/qmldir:
	@mkdir -p $(shell dirname $@)
	@echo 'module net.pezzato.sdcardcid' > $@
	@echo 'plugin SdcardCidPlugin' >> $@

$(DIST_DIR)/lib/plugins/net/pezzato/sdcardcid/libSdcardCidPlugin.so: $(PLUGIN_BUILD_DIR)/libSdcardCidPlugin.so
	@killall -9 SdcardCid || true
	@mkdir -p $(shell dirname $@)
	@cp $(PLUGIN_BUILD_DIR)/libSdcardCidPlugin.so $@

$(PLUGIN_BUILD_DIR)/libSdcardCidPlugin.so: $(PLUGIN_BUILD_DIR)/Makefile $(PLUGIN_SRC_FILES)
	@mkdir -p $(shell dirname $@)
	@cd $(shell dirname $@) && $(MAKE) && touch $@

$(PLUGIN_BUILD_DIR)/Makefile: $(SRC_DIR)/SdcardCidPlugin.pro
	@mkdir -p $(shell dirname $@)
	@cd $(shell dirname $@) && TARGET=$(TARGET) $(QMAKE) $(SRC_DIR)/SdcardCidPlugin.pro

################################################################################
# Building App
################################################################################

$(DIST_DIR)/bin/SdcardCid: $(DIST_DIR)/bin $(APP_BUILD_DIR)/SdcardCid
	@killall -9 SdcardCid || true
	@sleep 0.1
	@cp $(APP_BUILD_DIR)/SdcardCid $@

$(DIST_DIR)/bin:
	@mkdir -p $@

$(APP_BUILD_DIR)/SdcardCid: $(APP_BUILD_DIR)/Makefile $(shell find $(APP_SRC_FILES))
	@mkdir -p $(shell dirname $@)
	@cd $(shell dirname $@) && make

$(APP_BUILD_DIR)/Makefile: $(SRC_DIR)/SdcardCid.pro
	@mkdir -p $(shell dirname $@)
	@cd $(shell dirname $@) && TARGET=$(TARGET) $(QMAKE) $(SRC_DIR)/SdcardCid.pro

################################################################################
# Cleaning
################################################################################

clean:
	@rm -rf dist build

################################################################################
# Running
################################################################################

export QML2_IMPORT_PATH=$(DIST_DIR)/lib/plugins
export LD_LIBRARY_PATH=$(QT_ROOT)/lib/

.PHONY: run
run: app plugin
	$(DIST_DIR)/bin/SdcardCid

.PHONY: run_forever
run_forever: app plugin
	@while sleep 1; do echo -e "\n\n\n\n\n"; $(DIST_DIR)/bin/SdcardCid; done
