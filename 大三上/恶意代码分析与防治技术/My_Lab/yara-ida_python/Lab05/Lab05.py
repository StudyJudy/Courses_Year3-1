import os
import yara
import time

# 定义YARA规则
rules = yara.compile("Lab05.yara") 
# 扫描的样本文件夹路径
sample_folder = "sample"

# 初始化变量
matched_files = 0
start_time = time.time()

# 遍历样本文件夹中的文件
for root, dirs, files in os.walk(sample_folder):
    for file_name in files:
        file_path = os.path.join(root, file_name)
        try:
            # 使用YARA规则扫描文件
            matches = rules.match(file_path)
            # 如果有匹配的规则，记录匹配的文件数量
            if matches:
               matched_files += 1
        except Exception as e:
            # 处理可能的异常
            pass  # 这里可以加入处理异常的代码

# 计算扫描时间
end_time = time.time()
scan_time = end_time - start_time

# 输出结果
print("样本文件夹中的文件数量：{}".format(len(files)))
print("匹配的文件数量：{}".format(matched_files))
print("扫描时间：{:.2f} 秒".format(scan_time))
