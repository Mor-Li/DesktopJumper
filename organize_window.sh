#!/bin/zsh

# 导入 keycode_map
source /Users/moonshot/Documents/DesktopJumper/keycode_map.sh

# 右移到下一个桌面
move_right() {
    osascript -e 'tell application "System Events" to key code 124 using {control down}' > /dev/null
}

# 切换到目标桌面的函数
switch_to_target_desktop() {
    local desktop=$1
    yabai -m space --focus "$desktop" > /dev/null
# 注意：在脚本中使用 sleep 等待时，Yabai 在 sleep 的这段时间内不会主动完成窗口的重新布局或响应。
# 这意味着，在 sleep 期间，桌面和窗口的状态可能没有按预期更新。
# 因此，使用 sleep 来等待桌面切换完成是不可靠的，会导致窗口位置未能正确调整。
# 解决方案是通过检测桌面状态变化，确保 Yabai 已完成窗口的重新布局和响应。
# 这就是为什么要写wait_for_desktop_switch函数的原因。而不是直接使用sleep。

}

# 检查当前桌面是否已经切换完成
wait_for_desktop_switch() {
    local target=$1
    while :; do
        # 使用 yabai 查询当前活动桌面
        current_desktop=$(yabai -m query --spaces --space | jq '.index')
        if [ "$current_desktop" -eq "$target" ]; then
            break
        fi
        # 等待一小段时间再进行检查
        sleep 0.1
    done
}

# 获取当前显示器的数量
num_displays=$(yabai -m query --displays | jq '. | length')

# 默认情况下的总桌面数设置为 14
total_desktops=14  

if [ "$num_displays" -eq 1 ]; then
    num_right_moves=$((total_desktops - 1))  # 需要向右移动的次数
    target_desktop=1  # 初始目标桌面为第一个

    # 切换到第一个桌面
    switch_to_target_desktop "$target_desktop"

    # 右移 num_right_moves 次
    for ((i = 1; i <= num_right_moves; i++)); do
        # 执行右移操作
        move_right
        # 等待桌面切换完成
        wait_for_desktop_switch $((target_desktop + i))
    done

elif [ "$num_displays" -eq 2 ]; then
    # 双显示器下，假设第一个显示器有10个桌面，第二个显示器有4个桌面

    # 切换到第一个显示器的第一个桌面
    target_desktop=1
    switch_to_target_desktop "$target_desktop"

    # 第一个显示器移动9次（右移到第10个桌面）
    for ((i = 1; i <= 9; i++)); do
        move_right
        wait_for_desktop_switch $((target_desktop + i))
    done

    # 切换到第二个显示器的第一个桌面（假设为第11个桌面）
    target_desktop=11
    switch_to_target_desktop "$target_desktop"

    # 第二个显示器上再移动3次（到第14个桌面）
    for ((i = 1; i <= 3; i++)); do
        move_right
        wait_for_desktop_switch $((target_desktop + i))
    done

elif [ "$num_displays" -eq 3 ]; then
    # 三显示器下，假设每个显示器有5个桌面

    # 切换到第一个显示器的第一个桌面
    target_desktop=1
    switch_to_target_desktop "$target_desktop"

    # 第一个显示器移动9次（到第10个桌面）
    for ((i = 1; i <= 9; i++)); do
        move_right
        wait_for_desktop_switch $((target_desktop + i))
    done

    # 切换到第二个显示器的第一个桌面（第11个桌面）
    target_desktop=11
    switch_to_target_desktop "$target_desktop"

    # 第二个显示器移动1次（到第12个桌面）
    for ((i = 1; i <= 1; i++)); do
        move_right
        wait_for_desktop_switch $((target_desktop + i))
    done

    # 切换到第三个显示器的第一个桌面（第13个桌面）
    target_desktop=13
    switch_to_target_desktop "$target_desktop"

    # 第三个显示器移动3次（到第16个桌面）
    for ((i = 1; i <= 3; i++)); do
        move_right
        wait_for_desktop_switch $((target_desktop + i))
    done

else
    # 更多显示器的情况，默认为14个桌面
    num_right_moves=$((total_desktops - 1))
    target_desktop=1

    # 切换到第一个桌面
    switch_to_target_desktop "$target_desktop"

    # 右移 num_right_moves 次
    for ((i = 1; i <= num_right_moves; i++)); do
        move_right
        wait_for_desktop_switch $((target_desktop + i))
    done
fi
