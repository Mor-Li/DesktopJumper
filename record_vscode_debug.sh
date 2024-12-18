#!/bin/zsh

# 定义记录文件的位置
last_vscode_desktop_file="/tmp/last_vscode_desktop"
log_file="/Users/limo/Documents/GithubRepo/DesktopJumper/record_vscode_debug.log"

# 清空日志文件（可选，根据需求决定是否追加还是覆盖）
> "$log_file"

# 输出调试信息的函数
log_debug() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - DEBUG: $1" >> "$log_file"
}

log_debug "脚本开始执行"

# 获取当前活动窗口的信息
current_window=$(yabai -m query --windows --window 2>>"$log_file")
if [ $? -ne 0 ]; then
    log_debug "获取当前活动窗口信息失败"
    exit 1
else
    log_debug "当前活动窗口信息：$current_window"
fi

# 获取当前活动窗口的应用程序名称
current_app=$(echo "$current_window" | jq -r '.app' 2>>"$log_file")
if [ $? -ne 0 ]; then
    log_debug "解析应用程序名称失败"
    exit 1
else
    log_debug "当前应用程序名称：$current_app"
fi

# 获取当前活动窗口所在的桌面编号
current_desktop=$(echo "$current_window" | jq '.space' 2>>"$log_file")
if [ $? -ne 0 ]; then
    log_debug "解析桌面编号失败"
    exit 1
else
    log_debug "当前桌面编号：$current_desktop"
fi

# 判断当前窗口是否为 VS Code
if [ "$current_app" = "Code" ]; then
    echo "$current_desktop" > "$last_vscode_desktop_file"
    log_debug "当前应用是 VS Code，已记录最后使用的桌面编号：$current_desktop"
else
    log_debug "当前应用不是 VS Code，无需记录桌面编号"
fi

log_debug "脚本执行结束"