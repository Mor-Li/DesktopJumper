#!/bin/zsh

# 导入 keycode_map
source /Users/limo/Documents/GithubRepo/DesktopJumper/keycode_map.sh

# 获取当前显示器的数量
num_displays=$(yabai -m query --displays | jq '. | length')

# 根据显示器数量定义目标桌面编号
if [ "$num_displays" -eq 1 ]; then
    target_desktop=2  # 针对单显示器的设定，Chrome log窗口
elif [ "$num_displays" -eq 2 ]; then
    target_desktop=2  # 针对双显示器的设定
elif [ "$num_displays" -eq 3 ]; then
    target_desktop=2  # 针对三显示器的设定
else
    target_desktop=2 # 针对更多显示器的设定
fi

# 获取当前桌面编号
current_space=$(yabai -m query --spaces --space | jq -r ".index")

# 等待0.2秒
sleep 0.2

if [ -n "$current_space" ]; then
    if [ "$current_space" -ne "$target_desktop" ]; then
        echo "Debug: Not on target space $target_desktop, saving current space and switching to space $target_desktop (Chrome log)."
        echo $current_space > /tmp/last_space
        # 切换到目标桌面
        osascript -e "tell application \"System Events\" to key code ${keycode_map[$target_desktop]} using {control down}" > /dev/null
        echo "Debug: Switched to space $target_desktop (Chrome log)."
    elif [ "$current_space" -eq "$target_desktop" ]; then
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
