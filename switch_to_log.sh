#!/bin/zsh

# 定义数字键与键码的映射关系
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

# 获取当前桌面编号
current_space=$(yabai -m query --spaces --space | jq -r ".index")

# 等待0.1秒
sleep 0.2

if [ -n "$current_space" ]; then
    if [ "$current_space" -ne 2 ]; then
        echo "Debug: Not on space 2, saving current space and switching to space 2 (Chrome log)."
        echo $current_space > /tmp/last_space
        # 切换到桌面 2
        osascript -e "tell application \"System Events\" to key code 19 using {control down}" > /dev/null
        echo "Debug: Switched to space 2 (Chrome log)."
    elif [ "$current_space" -eq 2 ]; then
        if [ -f /tmp/last_space ]; then
            previous_space=$(cat /tmp/last_space)
            echo "Debug: Previous space recorded as $previous_space."
            if [[ -n "$previous_space" && ${keycode_map[$previous_space]} ]]; then
                key_code=${keycode_map[$previous_space]}
                echo "Debug: Switching back to space $previous_space with key code $key_code."
                osascript -e "tell application \"System Events\" to key code $key_code using {control down}" > /dev/null
                echo "Debug: Switched back to previous space."
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
