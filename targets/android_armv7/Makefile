PROJECT_NAME = SdcardCid

# QT_ROOT must contain bin include jar lib mkspecs plugins qml src translations
# Normally it is located in /opt/Qt/5.8/android_armv7

QT_ROOT ?= /opt/Qt/5.8/android_armv7

# Source this .pro file
APP_PRO_FILE ?= $(abspath $(SRC_DIR)/SdcardCid.pro)
PLUGIN_PRO_FILE ?= $(abspath $(SRC_DIR)/SdcardCidPlugin.pro)

# This is named by Project
DEPLOYMENT_SETTINGS_JSON = ${APP_BUILD_DIR}/android-lib$(PROJECT_NAME).so-deployment-settings.json

# ANDROID_HOME Must contain
# add-ons build-tools docs extras platforms platform-tools ... and other files
ANDROID_HOME ?= /opt/android/sdk

APP_BUILD_DIR := $(BUILD_DIR)/app
PLUGIN_BUILD_DIR := $(BUILD_DIR)/plugin

# Note: no one knows, but installing plugins in sdk qml directory seems to
# be the only way.
PLUGIN_DIST_DIR := $(QT_ROOT)/qml/net/pezzato/sdcardcid

export ANDROID_HOME
export ANDROID_SDK_ROOT = $(ANDROID_HOME)

# ANDROID_NDK_ROOT Must contain
# platform ndk-depends ... and other files
export ANDROID_NDK_ROOT=/opt/android-ndk/android-ndk-r10e

export ANDROID_NDK_HOST=linux-x86_64
export ANDROID_NDK_PLATFORM=android-17
export ANDROID_NDK_TOOLCHAIN_PREFIX=arm-linux-androideabi
export ANDROID_NDK_VERSION=4.9
export ANDROID_NDK_TOOLS_PREFIX=arm-linux-androideabi

# qmake and androiddeployqt are normally found under QT_ROOT
QMAKE = $(QT_ROOT)/bin/qmake
ANDROIDDEPLOYQT = $(QT_ROOT)/bin/androiddeployqt

.PHONY: default
default: all

.PHONY: clean
clean:
	@rm -rf $(APP_BUILD_DIR) $(DIST_DIR)

.PHONY: all
all: apk

.PHONY: release-apk
release-apk: $(DIST_DIR)/build/outputs/apk/android_armv7-release.apk

.PHONY: debug-apk
debug-apk: $(DIST_DIR)/build/outputs/apk/android_armv7-debug.apk

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

$(DIST_DIR)/build/outputs/apk/android_armv7-release.apk: plugin
	@mkdir -p $(APP_BUILD_DIR) $(DIST_DIR)
	cd $(APP_BUILD_DIR) && \
		$(QMAKE) $(APP_PRO_FILE) -spec android-g++ && \
		$(MAKE) qmake_all && \
		$(MAKE) && \
		$(MAKE) INSTALL_ROOT=$(DIST_DIR) install && \
		$(ANDROIDDEPLOYQT) --input $(DEPLOYMENT_SETTINGS_JSON) \
		--output $(DIST_DIR) --verbose --deployment bundled \
		--gradle --release
# FIXME sign

$(DIST_DIR)/build/outputs/apk/android_armv7-debug.apk: plugin
	@mkdir -p $(APP_BUILD_DIR) $(DIST_DIR)
	cd $(APP_BUILD_DIR) && \
		$(QMAKE) $(APP_PRO_FILE) -spec android-g++ && \
		$(MAKE) qmake_all && \
		$(MAKE) && \
		$(MAKE) INSTALL_ROOT=$(DIST_DIR) install && \
		$(ANDROIDDEPLOYQT) --input $(DEPLOYMENT_SETTINGS_JSON) \
		--output $(DIST_DIR) --verbose --deployment bundled \
		--gradle

.PHONY: run
run: debug-install
	adb shell am start -a android.intent.action.MAIN -n net.pezzato.sdcardcid/net.pezzato.sdcardcid.SdcardCid

.PHONY: release-install
install: release-apk
	adb install -r $(DIST_DIR)/build/outputs/apk/android_armv7-release.apk

.PHONY: debug-install
debug-install: debug-apk
	adb install -r $(DIST_DIR)/build/outputs/apk/android_armv7-debug.apk
