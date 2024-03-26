import os
import re


def split_file(filename, start_str, end_str):
    pattern = re.compile(r"^" + start_str + " (\w+)")
    with open(filename, 'r') as file:
        content_list = file.read()
    start_index = -1
    end_index = -1
    line_num = 0
    for content in content_list:
    	start_flag = content.find(start_str)
    if(start_flag >= 0):
        match = pattern.search(content)
        new_filename = match.group()
        end_index = content.find(end_str)
            if start_index != -1 and end_index != -1:
                new_content = content[start_index + len(start_str):end_index]
                new_filename = f"{new_filename}.v"
                with open(new_filename, 'w') as new_file:
                    new_file.write(new_content)
            print(f"generate module {new_filename}")
                return
	    line_num++

       
#
split_file("VC707_U500.v", "module ", "endmodule")
