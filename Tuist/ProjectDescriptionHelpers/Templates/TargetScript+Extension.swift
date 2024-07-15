//
//  TargetScript+Extension.swift
//  ProjectDescriptionHelpers
//
//  Created by MinseokKang on 2024/07/15.
//

import Foundation
import ProjectDescription
import UtilityPlugin

public extension TargetScript {
  // MARK: - Swiftlint 스크립트 (로컬 빌드에서는 사용하지 않고 있음)
  
  static let swiftLint: TargetScript = .pre(
    script: """
    ROOT_DIR=\(rootDirectory)
    ${ROOT_DIR}/SwiftLint/swiftlint --config ${ROOT_DIR}/SwiftLint/swiftlint.yml
    """,
    name: "SwiftLint",
    basedOnDependencyAnalysis: false
  )
  
  // MARK: - Reveal 스크립트
  
  // configuration을 커스텀 했기에 REVEAL_LOAD_FOR_CONFIGURATION 환경변수를 override 해야함
  static func reveal(target: BuildConfiguration) -> TargetScript {
    return .pre(
      script: """
      REVEAL_LOAD_FOR_CONFIGURATION=\(target.name)
      export REVEAL_LOAD_FOR_CONFIGURATION
      
      REVEAL_APP_PATH=$(mdfind kMDItemCFBundleIdentifier="com.ittybittyapps.Reveal2" | head -n 1)
      BUILD_SCRIPT_PATH="${REVEAL_APP_PATH}/Contents/SharedSupport/Scripts/reveal_server_build_phase.sh"
      if [ "${REVEAL_APP_PATH}" -a -e "${BUILD_SCRIPT_PATH}" ]; then
        "${BUILD_SCRIPT_PATH}"
      else
        echo "Reveal Server not loaded: Cannot find a compatible Reveal app."
      fi
      """,
      name: "Reveal",
      basedOnDependencyAnalysis: false
    )
  }
  
  // MARK: - FirebaseCrashlytics 스크립트
  
  static let firebaseCrashlytics: TargetScript = .post(
    script: """
    ROOT_DIR=\(rootDirectory)
    ${ROOT_DIR}/XCFramework/FirebaseScripts/run
    """,
    name: "FirebaseCrashlytics",
    inputPaths: [
      "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}",
      "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Resources/DWARF/${TARGET_NAME}",
      "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Info.plist",
      "$(TARGET_BUILD_DIR)/$(UNLOCALIZED_RESOURCES_FOLDER_PATH)/GoogleService-Info.plist",
      "$(TARGET_BUILD_DIR)/$(EXECUTABLE_PATH)"
    ],
    basedOnDependencyAnalysis: false
  )
}
