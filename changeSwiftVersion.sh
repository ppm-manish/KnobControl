sed -i '' 's/SWIFT_VERSION[[:space:]]=[[:space:]][0-9].[0-9]/SWIFT_VERSION = '"$1"'/g' KnobControl.xcodeproj/project.pbxproj