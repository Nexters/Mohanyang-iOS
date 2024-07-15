### Tuist ###

.PHONY: install
install:
	carthage update --platform iOS --use-xcframeworks --use-netrc --cache-builds --verbose --project-directory "XCFramework/"
	tuist install

.PHONY: generate
generate:
	TUIST_ROOT_DIR=${PWD} TUIST_BUILD_CONFIG=${config} tuist generate ${target}

.PHONY: cache
cache:
	TUIST_ROOT_DIR=${PWD} tuist cache ${target} --external-only
	
.PHONY: module
module:
	tuist scaffold Framework --layer ${layer} --name ${name}

.PHONY: cleanj
clean:
	tuist clean
	rm -rf XCFramework/Carthage
	rm -rf *.xcworkspace
	find Projects -name "*.xcodeproj" -exec rm -rf {} \;


### SUGAR ###

.PHONY: pomonyang
pomonyang:
	make generate config=${config} target="PomoNyang"

### Script ###

.PHONY: graph
graph:
	sh DependencyGraph/graphMaker.sh

.PHONY: template
template:
	sh file_template/install_template.sh