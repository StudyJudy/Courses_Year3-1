import os
import time
import yara

# 载入Yara规则
rules = yara.compile('lab3.yara')

# 指定要扫描的目录
target_directory = 'C:\\'

start_time = time.time()

matches = []

# 遍历目录中的所有文件
for root, dirs, files in os.walk(target_directory):
    for file in files:
        file_path = os.path.join(root, file)
        try:
            # 执行扫描
            file_matches = rules.match(file_path)
            if file_matches:
                for match in file_matches:
                    matches.append(match)
        except Exception as e:
            pass

end_time = time.time()

# 输出匹配结果
if matches:
    for match in matches:
        print(f"匹配到规则: {match.rule}")
else:
    print("未发现匹配的规则")

# 计算并输出扫描时间
scan_time = end_time - start_time
print(f"扫描完成，用时: {scan_time} 秒")
