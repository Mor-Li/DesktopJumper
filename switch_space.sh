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

if [ -n "$current_space" ]; then
    if [ "$current_space" -ne 3 ]; then
        echo $current_space > /tmp/last_space
        # 切换到桌面3
        osascript -e "tell application \"System Events\" to key code 20 using {control down}" > /dev/null
    elif [ "$current_space" -eq 3 ]; then
        if [ -f /tmp/last_space  ]; then
            previous_space=$(cat /tmp/last_space)
            if [[ -n "$previous_space" && ${keycode_map[$previous_space]} ]]; then
                key_code=${keycode_map[$previous_space]}
                osascript -e "tell application \"System Events\" to key code $key_code using {control down}" > /dev/null
            else
                echo "Invalid previous space or keycode not found."
            fi
        else
            echo "No previous space recorded."
        fi
    fi
else
    echo "Failed to get current space."
fi

# insert the following line to your skhdrc file
# alt - space : zsh "~/GithubRepo/DesktopJumper/switch_space.sh"
