# To regenerate TerminalVim.app, paste this into Automator as 'Run AppleScript'
on run {input, parameters}
	set filename to POSIX path of input
	set cmd to "clear;cd `dirname " & filename & "`;vim " & filename
	tell application "iTerm"
		tell the current window
			create tab with default profile
			tell the current session
				write text cmd
			end tell
		end tell
	end tell
end run
