#!/bin/zsh

# 获取当前显示器的数量
num_displays=$(yabai -m query --displays | jq '. | length')

# 根据显示器数量定义点击坐标
if [ "$num_displays" -eq 1 ]; then
    # 单显示器模式，检测显示器分辨率
    display_info=$(system_profiler SPDisplaysDataType)
    resolution=$(echo "$display_info" | grep "UI Looks like:" | awk '{print $4 "x" $6}')
    
    if [[ "$resolution" == "2304x1296" ]]; then
        # 2304 x 1296 分辨率
        /Users/limo/miniconda3/envs/pytorch/bin/python /Users/limo/Documents/GithubRepo/YabaiSKHD-MultiDisplay/click/click_position.py 1733 1254
    else
        # 其他分辨率，检测显示器名称
        display_name=$(echo "$display_info" | grep -A 1 "Displays:" | tail -n 1 | awk -F: '{print $1}' | xargs)
        
        if [[ "$display_name" == "U27N3R" ]]; then
            # 4K显示器 (3840 x 2160)
            /Users/limo/miniconda3/envs/pytorch/bin/python /Users/limo/Documents/GithubRepo/YabaiSKHD-MultiDisplay/click/click_position.py 1518 1036
        elif [[ "$display_name" == "Built-in Retina Display" ]]; then
            # MacBook内置显示器
            /Users/limo/miniconda3/envs/pytorch/bin/python /Users/limo/Documents/GithubRepo/YabaiSKHD-MultiDisplay/click/click_position.py 1319 943
        else
            # 其他单显示器
            /Users/limo/miniconda3/envs/pytorch/bin/python /Users/limo/Documents/GithubRepo/YabaiSKHD-MultiDisplay/click/click_position.py 1319 943
        fi
    fi
elif [ "$num_displays" -eq 2 ]; then
    # 双显示器实际上和单显示器是一样的
    /Users/limo/miniconda3/envs/pytorch/bin/python /Users/limo/Documents/GithubRepo/YabaiSKHD-MultiDisplay/click/click_position.py 1319 943
elif [ "$num_displays" -eq 3 ]; then
    /Users/limo/miniconda3/envs/pytorch/bin/python /Users/limo/Documents/GithubRepo/YabaiSKHD-MultiDisplay/click/click_position.py 457 -44
else
    /Users/limo/miniconda3/envs/pytorch/bin/python /Users/limo/Documents/GithubRepo/YabaiSKHD-MultiDisplay/click/click_position.py 1319 943
fi

