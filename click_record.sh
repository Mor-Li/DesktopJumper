
#!/bin/zsh

# 获取当前显示器的数量
num_displays=$(yabai -m query --displays | jq '. | length')

# 根据显示器数量定义目标桌面编号
if [ "$num_displays" -eq 1 ]; then
    /Users/limo/miniconda3/envs/pytorch/bin/python /Users/limo/Documents/GithubRepo/YabaiSKHD-MultiDisplay/click/click_position.py 1277 944
elif [ "$num_displays" -eq 2 ]; then
    target_desktop=6  # 示例，针对双显示器的设定
elif [ "$num_displays" -eq 3 ]; then
    /Users/limo/miniconda3/envs/pytorch/bin/python /Users/limo/Documents/GithubRepo/YabaiSKHD-MultiDisplay/click/click_position.py 415 -40
else
    target_desktop=9  # 示例，针对更多显示器的设定
fi
