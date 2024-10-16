#!/bin/zsh

# 导入 keycode_map
source /Users/limo/Documents/GithubRepo/DesktopJumper/keycode_map.sh

# 获取当前显示器的数量
num_displays=$(yabai -m query --displays | jq '. | length')

# 根据显示器数量设置总桌面数量
if [ "$num_displays" -eq 1 ]; then
    total_desktops=14  # 单显示器下有14个桌面
elif [ "$num_displays" -eq 2 ]; then
    total_desktops=14  # 双显示器下每个显示器有7个桌面
elif [ "$num_displays" -eq 3 ]; then
    total_desktops=14  # 三显示器下每个显示器有5个桌面
else
    total_desktops=14  # 更多显示器的默认桌面数量
fi

# 计算需要向右移动的次数（总桌面数减去1）
num_right_moves=$((total_desktops - 1))

# 切换到第一个桌面（按 Ctrl + 1）
osascript -e "tell application \"System Events\" to key code ${keycode_map[1]} using {control down}" > /dev/null

# 按指定次数的右箭头
for ((i = 1; i <= num_right_moves; i++)); do
    osascript -e 'tell application "System Events" to key code 124 using {control down}' > /dev/null
    sleep 0.5  # 每次移动后等待0.5秒
done