#!/usr/bin/env python3

'''
Author: your name
Date: 2022-04-20 14:34:59
LastEditTime: 2022-04-20 15:24:11
LastEditors: Please set LastEditors
Description: 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
FilePath: /opentitan/util/modify_gcc_version.py
'''

DESC = """modify_gcc_version, generate register info from Hjson source"""

USAGE = '''
  modify_gcc_version [options]
'''

import fcntl  
import os
import sys
import argparse

def main():
    parser = argparse.ArgumentParser(
        description='Use fcntl to change gcc version')
    parser.add_argument('--gcc_version',
                        '-g',
                        default="4.8",
                        type=str,
                        help='string to need change gcc version: 4.8/7')
    args = parser.parse_args()

    verbose = 0
    # 打开一个文件  
    # 当前目录下test文件要先存在，如果不存在会报错。或者以写的方式打开  
    file_path = os.path.join(os.path.dirname(__file__) + '/lowrisc_misc-linters.lock.hjson')
    f = open(file_path, 'r')  
    # 对该文件加锁：  
    fcntl.flock(f, fcntl.LOCK_EX)  
    # 这样就对文件test加锁了，如果有其他进程对test文件加锁，则不能成功，会被阻塞，但不会退出程序。  
    # 修改gcc版本
    if(args.gcc_version == '7'):
        val = os.system(''' update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 70;
                            update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 70;
                            update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-4.8 70;
                            update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 120; 
                            update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 120;
                            update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-7 120;''')
        print("modify_gcc_version to gcc-7")
    elif(args.gcc_version == '4.8'):
        val = os.system(''' update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 70;
                            update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 70;
                            update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-7 70;
                            update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 120; 
                            update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 120;
                            update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-4.8 120;''')
        print("modify_gcc_version to gcc-4.8")
    else:
        print("do not modify_gcc_version")
    # 解锁,使用flock或者fclose即可解锁
    # fcntl.flock(f,fcntl.LOCK_UN)
    f.close()



if __name__ == '__main__':
    sys.exit(main())
