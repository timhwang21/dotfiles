from powerline_shell.themes.default import DefaultColor

blue = 4
clear = 8
dark_blue = 0
gray = 14
orange = 3
red = 1
white = 15

class Color(DefaultColor):
    TIME_FG = gray
    TIME_BG = dark_blue

    USERNAME_FG = gray
    USERNAME_BG = dark_blue
    USERNAME_ROOT_BG = red

    HOSTNAME_FG = white
    HOSTNAME_BG = 10

    HOME_SPECIAL_DISPLAY = False
    PATH_FG = gray
    PATH_BG = clear
    CWD_FG = gray
    SEPARATOR_FG = gray

    READONLY_BG = red
    READONLY_FG = 7

    REPO_CLEAN_FG = gray
    REPO_CLEAN_BG = dark_blue
    REPO_DIRTY_FG = orange
    REPO_DIRTY_BG = dark_blue

    JOBS_FG = blue
    JOBS_BG = clear

    CMD_PASSED_FG = gray
    CMD_PASSED_BG = dark_blue
    CMD_FAILED_FG = white
    CMD_FAILED_BG = red

    VIRTUAL_ENV_BG = white
    VIRTUAL_ENV_FG = 2
