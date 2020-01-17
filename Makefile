VERSION = $(shell cat VERSION)
COMMIT = $(shell git rev-parse HEAD)
UNIVERSAL_DIR = universal
BUILD_DIR = buildr
RELEASE_DIR = releases

# xcodebuild flags
XCB_REL_IPOS_FLAGS = -target "KnobControlmnz" -configuration Release -sdk iphoneos ONLY_ACTIVE_ARCH=NO
XCB_REL_IPSIM_FLAGS = -target "KnobControlmnz" -configuration Release -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO


# Release builds for devqa, staging and production
production: banner clean set-plist-release archive-release

set-plist-release:
	plutil -replace build -string "production-release" KnobControlmnz/Info.plist
	plutil -replace githash -string $(COMMIT) KnobControlmnz/Info.plist
	plutil -replace CFBundleVersion -string $(VERSION) KnobControlmnz/Info.plist

build-release: init
	# Step 1. Build Device and Simulator versions
	xcodebuild $(XCB_REL_IPOS_FLAGS)  BUILD_DIR=$(BUILD_DIR) clean build
	xcodebuild $(XCB_REL_IPSIM_FLAGS) BUILD_DIR=$(BUILD_DIR) clean build

build-universal-release: build-release
	cp -R $(BUILD_DIR)/Release-iphoneos/KnobControlmnz.framework $(UNIVERSAL_DIR)/
	cp -R $(BUILD_DIR)/Release-iphonesimulator/KnobControlmnz.framework/Modules/KnobControlmnz.swiftmodule/. $(UNIVERSAL_DIR)/KnobControlmnz.framework/Modules/KnobControlmnz.swiftmodule
	lipo -create -output $(UNIVERSAL_DIR)/KnobControlmnz.framework/KnobControlmnz $(BUILD_DIR)/Release-iphonesimulator/KnobControlmnz.framework/KnobControlmnz $(BUILD_DIR)/Release-iphoneos/KnobControlmnz.framework/KnobControlmnz

archive-release: build-universal-release
	tar -cvzf $(RELEASE_DIR)/KnobControlmnz-iOS-$(SWIFT_VER)-$(VERSION).tar.gz -C $(UNIVERSAL_DIR) KnobControlmnz.framework

init:
	mkdir -p $(UNIVERSAL_DIR) || true
	mkdir -p $(BUILD_DIR) || true
	mkdir -p $(RELEASE_DIR) || true

banner:
	@echo
	@echo "==================================================================================================================================="
	@echo "Building KnobControlmnz iOS SDK $(MAKECMDGOALS)-release : $(VERSION) [$(COMMIT)]"
	@echo "-----------------------------------------------------------------------------------------------------------------------------------"
	@echo

clean:
	rm -rf $(UNIVERSAL_DIR) || true
	rm -rf $(BUILD_DIR) || true
	rm -rf $(RELEASE_DIR) || true
	rm -rf build || true
