#!/bin/zsh

# 导入 keycode_map
source /Users/moonshot/Documents/DesktopJumper/keycode_map.sh

# 获取当前显示器的数量
num_displays=$(yabai -m query --displays | jq '. | length')

# 根据显示器数量定义目标桌面编号 - VS Code设置在第6个桌面
if [ "$num_displays" -eq 1 ]; then
    target_desktop=6  # 针对单显示器的设定，VS Code在第6个桌面
elif [ "$num_displays" -eq 2 ]; then
    target_desktop=6  # 针对双显示器的设定，VS Code在第6个桌面
elif [ "$num_displays" -eq 3 ]; then
    target_desktop=6  # 针对三显示器的设定，VS Code在第6个桌面
else
    target_desktop=6  # 针对更多显示器的设定，VS Code在第6个桌面
fi

# 调用提取的函数来处理桌面切换逻辑
switch_to_target_desktop "$target_desktop"  # sleep_duration默认为0.2秒
