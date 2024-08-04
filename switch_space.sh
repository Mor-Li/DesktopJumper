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
    if [ "$current_space" -ne 3 ]; then
        echo "Debug: Not on space 3, saving current space and switching to space 3."
        echo $current_space > /tmp/last_space
        # 切换到桌面3
        osascript -e "tell application \"System Events\" to key code 20 using {control down}" > /dev/null
        echo "Debug: Switched to space 3."
    elif [ "$current_space" -eq 3 ]; then
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

# insert the following line to your skhdrc file
# alt - space : zsh "~/GithubRepo/DesktopJumper/switch_space.sh"


# ------------下面是一些开发时候的经验总结，不是必须看的----------------
# 默认的话skhd是homebrew启动的，但是这样你看不到日志，所以建议直接在终端启动skhd
# 建议同时粘贴下面两行命令到终端
# pkill skhd 
# skhd &
# 这样你就可以看到日志了，方便debug
# 此外，可以结合https://en.key-test.ru/
# 进行键码的测试，方便你自定义快捷键，以及到底按快捷键的时候背后发生了什么
# Debug后的结论： skhd是个好东西，他是很准确的。很适合做快捷键
# 只是切换桌面这件事apple script有点慢，所以有时候会有点卡顿，或者有时候会失效。 

# 2024-08-04日更新，我终于知道了这个bug为什么产生
# 当你按下alt+space的时候，skhd会调用zsh脚本，然后zsh脚本会调用osascript
# 但是osascript这行命令执行时候，如果此时刚才按的快捷键的option没有松开，那么osascript会执行失败
# 其实也不是失败，在我的案例中，似乎他是直接吐出 要跳转到的desktop的编号 的值
# 所以执行osascript的时候，他会直接在输入框中输入一个数字，导致跳转桌面失败
# 通过在sh脚本中加入一个sleep 0.2秒的延迟，解决了这个问题
# 这也警惕我，以后再使用自定义快捷键操作的时候，为了防止类似情况发生
# 要在实际执行的操作（比如运行一个脚本）之前加入一个延迟，以确保操作的准确性