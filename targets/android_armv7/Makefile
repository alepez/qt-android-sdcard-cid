PROJECT_NAME = SdcardCid

APP_ABI ?= x86
export APP_ABI

# QT_ROOT must contain bin include jar lib mkspecs plugins qml src translations
# Normally it is located in /opt/Qt/5.8/android_$(APP_ABI)

QT_ROOT ?= /opt/Qt/5.8/$(QT_ANDROID_ABI)

# Source this .pro file
APP_PRO_FILE ?= $(abspath $(SRC_DIR)/SdcardCid.pro)
PLUGIN_PRO_FILE ?= $(abspath $(SRC_DIR)/SdcardCidPlugin.pro)

# This is named by Project
DEPLOYMENT_SETTINGS_JSON = ${APP_BUILD_DIR}/android-lib$(PROJECT_NAME).so-deployment-settings.json

APP_BUILD_DIR := $(BUILD_DIR)/app
PLUGIN_BUILD_DIR := $(BUILD_DIR)/plugin

# Note: no one knows, but installing plugins in sdk qml directory seems to
# be the only way.
PLUGIN_DIST_DIR := $(QT_ROOT)/qml/net/pezzato/sdcardcid

export ANDROID_SDK_ROOT = /opt/android/sdk

# ANDROID_NDK_ROOT Must contain
# platform ndk-depends ... and other files
export ANDROID_NDK_ROOT=/opt/crystax

export ANDROID_NDK_HOST=linux-x86_64
export ANDROID_NDK_PLATFORM=android-17
# export ANDROID_NDK_TOOLCHAIN_PREFIX=arm-linux-androideabi
export ANDROID_NDK_VERSION=4.9
# export ANDROID_NDK_TOOLS_PREFIX=arm-linux-androideabi

# qmake and androiddeployqt are normally found under QT_ROOT
QMAKE = $(QT_ROOT)/bin/qmake
ANDROIDDEPLOYQT = $(QT_ROOT)/bin/androiddeployqt

.PHONY: default
default: apk

.PHONY: clean
clean:
	@rm -rf $(APP_BUILD_DIR) $(DIST_DIR)

.PHONY: apk
apk: $(DIST_DIR)/build/outputs/apk/SdcardCid.apk

.PHONY: plugin
plugin: $(PLUGIN_DIST_DIR)/qmldir $(PLUGIN_DIST_DIR)/libSdcardCidPlugin.so

$(PLUGIN_DIST_DIR)/libSdcardCidPlugin.so: $(PLUGIN_BUILD_DIR)/libSdcardCidPlugin.so
	@cp $< $@

$(PLUGIN_BUILD_DIR)/libSdcardCidPlugin.so: $(shell find $(SRC_DIR))
	@mkdir -p $(PLUGIN_DIST_DIR)
	@mkdir -p $(PLUGIN_BUILD_DIR)
	cd $(PLUGIN_BUILD_DIR) && \
		$(QMAKE) $(PLUGIN_PRO_FILE) -spec android-g++ && \
		$(MAKE) qmake_all && \
		$(MAKE) && \
		cp $(PLUGIN_BUILD_DIR)/libSdcardCidPlugin.so $(PLUGIN_DIST_DIR)/libSdcardCidPlugin.so

$(PLUGIN_DIST_DIR)/qmldir:
	@mkdir -p $(shell dirname $@)
	@echo -ne 'module net.pezzato.sdcardcid\nplugin SdcardCidPlugin' > $@

$(DIST_DIR)/build/outputs/apk/SdcardCid.apk: plugin
	@mkdir -p $(APP_BUILD_DIR) $(DIST_DIR)
	cd $(APP_BUILD_DIR) && \
		$(QMAKE) $(APP_PRO_FILE) -spec android-g++ && \
		$(MAKE) qmake_all && \
		$(MAKE) && \
		$(MAKE) INSTALL_ROOT=$(DIST_DIR) install && \
		$(ANDROIDDEPLOYQT) --input $(DEPLOYMENT_SETTINGS_JSON) \
		--output $(DIST_DIR) --verbose --deployment bundled \
		--gradle
