#!/bin/zsh

# 导入 keycode_map
source /Users/limo/Documents/GithubRepo/DesktopJumper/keycode_map.sh

# 右移到下一个桌面（非阻塞执行，但按顺序依次执行）
move_right() {
    osascript -e 'tell application "System Events" to key code 124 using {control down}' > /dev/null
}

# 切换到目标桌面的函数
switch_to_target_desktop() {
    local desktop=$1
    yabai -m space --focus "$desktop" > /dev/null
}

# 延迟执行的函数，按顺序延迟一段时间后再调用 move_right
delayed_move_right() {
    local delay=$1
    (sleep $delay; move_right) &
}

# 获取当前显示器的数量
num_displays=$(yabai -m query --displays | jq '. | length')

# 默认情况下的总桌面数设置为 14
total_desktops=14  

# 计算延迟时间的基础值
base_delay=0.5  # 每次右移的延迟时间（秒）

if [ "$num_displays" -eq 1 ]; then
    num_right_moves=$((total_desktops - 1))  # 需要向右移动的次数
    target_desktop=1  # 初始目标桌面为第一个

    # 切换到第一个桌面
    switch_to_target_desktop "$target_desktop"

    # 右移 num_right_moves 次
    for ((i = 1; i <= num_right_moves; i++)); do
        delayed_move_right $(echo "$i * $base_delay" | bc)  # 按顺序延迟执行
    done

elif [ "$num_displays" -eq 2 ]; then
    # 双显示器下，假设第一个显示器有10个桌面，第二个显示器有4个桌面

    # 切换到第一个显示器的第一个桌面
    target_desktop=1
    switch_to_target_desktop "$target_desktop"

    # 第一个显示器移动9次（右移到第10个桌面）
    for ((i = 1; i <= 9; i++)); do
        delayed_move_right $(echo "$i * $base_delay" | bc)
    done

    # 切换到第二个显示器的第一个桌面（假设为第11个桌面）
    target_desktop=11
    switch_to_target_desktop "$target_desktop"

    # 第二个显示器上再移动3次（到第14个桌面）
    for ((i = 1; i <= 3; i++)); do
        delayed_move_right $(echo "$i * $base_delay" | bc)
    done

elif [ "$num_displays" -eq 3 ]; then
    # 三显示器下，假设每个显示器有5个桌面

    # 切换到第一个显示器的第一个桌面
    target_desktop=1
    switch_to_target_desktop "$target_desktop"

    # 第一个显示器移动4次（到第5个桌面）
    for ((i = 1; i <= 4; i++)); do
        delayed_move_right $(echo "$i * $base_delay" | bc)
    done

    # 切换到第二个显示器的第一个桌面（第6个桌面）
    target_desktop=6
    switch_to_target_desktop "$target_desktop"

    # 第二个显示器移动4次（到第10个桌面）
    for ((i = 1; i <= 4; i++)); do
        delayed_move_right $(echo "$i * $base_delay" | bc)
    done

    # 切换到第三个显示器的第一个桌面（第11个桌面）
    target_desktop=11
    switch_to_target_desktop "$target_desktop"

    # 第三个显示器移动4次（到第14个桌面）
    for ((i = 1; i <= 4; i++)); do
        delayed_move_right $(echo "$i * $base_delay" | bc)
    done

else
    # 更多显示器的情况，默认为14个桌面
    num_right_moves=$((total_desktops - 1))
    target_desktop=1

    # 切换到第一个桌面
    switch_to_target_desktop "$target_desktop"

    # 右移 num_right_moves 次
    for ((i = 1; i <= num_right_moves; i++)); do
        delayed_move_right $(echo "$i * $base_delay" | bc)
    done
fi
