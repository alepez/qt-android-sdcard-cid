ABS_SRC_DIR := $(abspath src)
ABS_BUILD_DIR := $(abspath build)
ABS_DIST_DIR := $(abspath dist)

.PHONY: default
default: host

.PHONY: all
all: host android_armv7

################################################################################
.PHONY: preview_qml
preview_qml:
	QML_FILE="$(QML_PREVIEW_FILE)" WATCH_DIR="test src" ./scripts/preview_qml

.PHONY: host/run_forever
host/run_forever:
	$(MAKE) -C targets/host BUILD_DIR=$(ABS_BUILD_DIR)/host DIST_DIR=$(ABS_DIST_DIR)/host SRC_DIR=$(ABS_SRC_DIR) run_forever

.PHONY: host/run
host/run:
	$(MAKE) -C targets/host BUILD_DIR=$(ABS_BUILD_DIR)/host DIST_DIR=$(ABS_DIST_DIR)/host SRC_DIR=$(ABS_SRC_DIR) run

.PHONY: host
host:
	$(MAKE) -C targets/host BUILD_DIR=$(ABS_BUILD_DIR)/host DIST_DIR=$(ABS_DIST_DIR)/host SRC_DIR=$(ABS_SRC_DIR)

################################################################################

.PHONY: android_armv7
android_armv7:
	$(MAKE) -C targets/android_armv7 BUILD_DIR=$(ABS_BUILD_DIR)/android_armv7 DIST_DIR=$(ABS_DIST_DIR)/android_armv7 SRC_DIR=$(ABS_SRC_DIR) APP_ABI=armeabi-v7a QT_ANDROID_ABI=android_armv7

.PHONY: android_x86
android_x86:
	$(MAKE) -C targets/android_x86 BUILD_DIR=$(ABS_BUILD_DIR)/android_x86 DIST_DIR=$(ABS_DIST_DIR)/android_x86 SRC_DIR=$(ABS_SRC_DIR) APP_ABI=x86 QT_ANDROID_ABI=android_x86

.PHONY: clean
clean:
	@rm -fr $(ABS_BUILD_DIR) $(ABS_DIST_DIR)

.PHONY: cache_clean
cache_clean:
	@find -name '*.qmlc' -exec rm -f {} \;
	@find -name '*.qmlc.*' -exec rm -f {} \;
