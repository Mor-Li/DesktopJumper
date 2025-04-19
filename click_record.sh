#!/bin/zsh

# 获取当前显示器的数量
num_displays=$(yabai -m query --displays | jq '. | length')

# 根据显示器数量定义点击坐标
if [ "$num_displays" -eq 1 ]; then
    # 单显示器模式，检测显示器名称
    display_info=$(system_profiler SPDisplaysDataType)
    display_name=$(echo "$display_info" | grep -A 1 "Displays:" | tail -n 1 | awk -F: '{print $1}' | xargs)
    
    if [[ "$display_name" == "U27N3R" ]]; then
        # 4K显示器 (3840 x 2160)
        /Users/limo/miniconda3/envs/pytorch/bin/python /Users/limo/Documents/GithubRepo/YabaiSKHD-MultiDisplay/click/click_position.py 1473 1040
    elif [[ "$display_name" == "Built-in Retina Display" ]]; then
        # MacBook内置显示器
        /Users/limo/miniconda3/envs/pytorch/bin/python /Users/limo/Documents/GithubRepo/YabaiSKHD-MultiDisplay/click/click_position.py 1277 944
    else
        # 其他单显示器
        /Users/limo/miniconda3/envs/pytorch/bin/python /Users/limo/Documents/GithubRepo/YabaiSKHD-MultiDisplay/click/click_position.py 1277 944
    fi
elif [ "$num_displays" -eq 2 ]; then
    # 双显示器实际上和单显示器是一样的
    /Users/limo/miniconda3/envs/pytorch/bin/python /Users/limo/Documents/GithubRepo/YabaiSKHD-MultiDisplay/click/click_position.py 1277 944
elif [ "$num_displays" -eq 3 ]; then
    /Users/limo/miniconda3/envs/pytorch/bin/python /Users/limo/Documents/GithubRepo/YabaiSKHD-MultiDisplay/click/click_position.py 415 -40
else
    /Users/limo/miniconda3/envs/pytorch/bin/python /Users/limo/Documents/GithubRepo/YabaiSKHD-MultiDisplay/click/click_position.py 1277 944
fi
