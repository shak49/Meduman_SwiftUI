#!/bin/sh

#  CuckooScrip.sh
#  Meduman_SwiftUI
#
#  Created by Shak Feizi on 4/5/23.
#  


# Define output file. Change "${PROJECT_DIR}/${PROJECT_NAME}Tests" to your test's root source folder, if it's not the default name.
OUTPUT_FILE="${/Users/shakfeizi/Documents/Meduman_SwiftUI/Meduman_SwiftUI}/${Meduman_SwiftUI}Tests/GeneratedMocks.swift"
echo "Generated Mocks File = ${GeneratedMocks}"
# Define input directory. Change "${PROJECT_DIR}/${PROJECT_NAME}" to your project's root source folder, if it's not the default name.
INPUT_DIR="${/Users/shakfeizi/Documents/Meduman_SwiftUI/Meduman_SwiftUI}/${Meduman_SwiftUI}"
echo "Mocks Input Directory = ${/Users/shakfeizi/Documents/Meduman_SwiftUI/Meduman_SwiftUI}"
# Generate mock files, include as many input files as you'd like to create mocks for.
"${/Users/shakfeizi/Documents/Meduman_SwiftUI/Meduman_SwiftUI}/run" --download generate --testable "${Meduman_SwiftUI}" \
--output "${GeneratedMocks}" \
"${/Users/shakfeizi/Documents/Meduman_SwiftUI/Meduman_SwiftUI/Meduman_SwiftUI/Data/Health/ArticleRepository.swift}/{path of file name that need to be mock}.swift" \
