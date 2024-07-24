# -*- coding: utf-8 -*-
import os
import yara
import time

# 定义回调函数以获取匹配的文件名
def my_callback(data, file_path):
    print("匹配的文件：", data['rule'],"文件路径：", file_path)

# 定义YARA规则
rules = yara.compile("Lab09.yara") 
# 扫描的样本文件夹路径
sample_folder = "sample"

# 初始化变量
matched_files = 0
start_time = time.time()
matched_file_paths = set()  # 用集合来跟踪已匹配的文件路径

# 遍历样本文件夹中的文件
for root, dirs, files in os.walk(sample_folder):
    for file_name in files:
        file_path = os.path.join(root, file_name)
        try:
            # 如果文件路径已经匹配过，跳过
            if file_path in matched_file_paths:
                continue

            # 使用YARA规则扫描文件
            matches = rules.match(file_path)

            # 如果有匹配的规则，记录匹配的文件数量
            if matches:
                matched_files += 1
                matched_file_paths.add(file_path)
        except Exception as e:
            pass

# 计算扫描时间
end_time = time.time()
scan_time = end_time - start_time

# 输出结果
print("样本文件夹中的文件数量：{}".format(len(files)))
print("匹配的文件数量：{}".format(matched_files))
print("扫描时间：{:.2f} 秒".format(scan_time))
# 输出匹配的文件路径
print("匹配的文件路径：")
for file_path in matched_file_paths:
    print(file_path)
