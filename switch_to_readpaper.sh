#!/bin/zsh

# 导入 keycode_map
source /Users/limo/Documents/GithubRepo/DesktopJumper/keycode_map.sh

# 获取当前显示器的数量
num_displays=$(yabai -m query --displays | jq '. | length')

# 根据显示器数量定义目标桌面编号
if [ "$num_displays" -eq 1 ]; then
    target_desktop=10  # 针对单显示器的设定，Music窗口
elif [ "$num_displays" -eq 2 ]; then
    target_desktop=11  # 针对双显示器的设定
elif [ "$num_displays" -eq 3 ]; then
    target_desktop=7  # 针对三显示器的设定
else
    target_desktop=7  # 针对更多显示器的设定
fi

# 调用提取的函数来处理桌面切换逻辑
switch_to_target_desktop "$target_desktop"  # sleep_duration默认为0.2秒