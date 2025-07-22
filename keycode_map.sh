# keycode_map.sh
declare -A keycode_map=(
    [1]=18
    [2]=19
    [3]=20
    [4]=21
    [5]=23
    [6]=22
    [7]=26
    [8]=28
    [9]=25
    [0]=29
)

switch_to_target_desktop() {
    # 每次跳桌面前，先检测当前是否在vscode，用来记录在最后的vscode的桌面的位置
    source /Users/moonshot/Documents/DesktopJumper/record_vscode.sh

    local target_desktop="$1"
    local sleep_duration="${2:-0.2}"  # 默认睡眠时间为0.2秒
    local current_space=$(yabai -m query --spaces --space | jq -r ".index")
    # 等待指定时间
    sleep "$sleep_duration"

    if [ -n "$current_space" ]; then
        if [ "$current_space" -ne "$target_desktop" ]; then
            echo "Debug: Not on target space $target_desktop, saving current space and switching to space $target_desktop."
            echo $current_space > /tmp/last_space

            # 切换到目标桌面
            if [ "$target_desktop" -ge 1 ] && [ "$target_desktop" -le 9 ]; then
                # Command + 数字
                osascript -e "tell application \"System Events\" to key code ${keycode_map[$target_desktop]} using {command down}" > /dev/null
            elif [ "$target_desktop" -eq 10 ]; then
                # Command + 0
                osascript -e "tell application \"System Events\" to key code ${keycode_map[0]} using {command down}" > /dev/null
            elif [ "$target_desktop" -ge 11 ] && [ "$target_desktop" -le 19 ]; then
                # Command + Option + (1-9)
                local option_desktop=$((target_desktop - 10))  # 转换为 1-9 范围
                osascript -e "tell application \"System Events\" to key code ${keycode_map[$option_desktop]} using {command down, option down}" > /dev/null
            fi

            echo "Debug: Switched to space $target_desktop."
        else
            if [ -f /tmp/last_space ]; then
                previous_space=$(cat /tmp/last_space)
                echo "Debug: Previous space recorded as $previous_space."
                if [ "$previous_space" -ge 1 ] && [ "$previous_space" -le 9 ]; then
                    # 切换回 1-9 桌面
                    key_code=${keycode_map[$previous_space]}
                    echo "Debug: Switching back to space $previous_space with key code $key_code."
                    osascript -e "tell application \"System Events\" to key code $key_code using {command down}" > /dev/null
                elif [ "$previous_space" -eq 10 ]; then
                    # 切换回 10 桌面
                    key_code=${keycode_map[0]}
                    echo "Debug: Switching back to space $previous_space with key code $key_code."
                    osascript -e "tell application \"System Events\" to key code $key_code using {command down}" > /dev/null
                elif [ "$previous_space" -ge 11 ] && [ "$previous_space" -le 19 ]; then
                    # 切换回 11-19 桌面
                    local option_desktop=$((previous_space - 10))  # 转换为 1-9 范围
                    key_code=${keycode_map[$option_desktop]}
                    echo "Debug: Switching back to space $previous_space with Command + Option + key code $key_code."
                    osascript -e "tell application \"System Events\" to key code $key_code using {command down, option down}" > /dev/null
                else
                    echo "Debug: Invalid previous space or keycode not found."
                fi
            else
                echo "Debug: No previous space recorded."
            fi
        fi
    else
        echo "Debug: Failed to get current space."
    fi
}

     