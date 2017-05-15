#!/bin/sh

menu() {
	clear
	echo -----------------------------------------------------------------------
	echo -------------------------\| xcode Cleaner \|-----------------------------
	echo -----------------------------------------------------------------------
	echo \| DerivedData and simulator reset, all at once. Because I\'m too lazy. \|
	echo \| Warning: This will quit Xcode and all simulators before proceding...\|
	echo -----------------------------------------------------------------------
}

deleteDerivedData() {
	echo "Quitting Xcode..."
	osascript -e 'tell application "xcode" to quit'
	echo "Deleting DerivedData..."
	rm -rf ~/Library/Developer/Xcode/DerivedData/*
}

resetAllSimulators() {
	echo "Quitting all simulators..."
	osascript -e 'tell application "iOS Simulator" to quit'
	osascript -e 'tell application "Simulator" to quit'
	echo "Resetting all simulators...(this may take a moment)"
	xcrun simctl erase all
}

menu;
options=("Delete DerivedData" "Reset all simulators" "Clean all" "EXIT");

select result in "${options[@]}"
do
	case $result in
		"Delete DerivedData")
			deleteDerivedData;
			break
		;;
		"Reset all simulators")
			resetAllSimulators;
			break
		;;
		"Clean all")
			deleteDerivedData;
			resetAllSimulators;
			break
		;;
		"EXIT")
			break
		;;
		*)
			echo "Please select a valid option!"
		;;
	esac
done
echo "Done!\n"
