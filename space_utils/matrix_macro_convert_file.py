#!/opt/miniconda3/bin/python

import sys
import re

lines_to_write = []

print('Converting ' + sys.argv[1])

with open(sys.argv[1]) as f:
    lines = f.readlines()
    i = 0
    while i < len(lines):
        line_to_write = lines[i]

        data_match = \
            re.match('(\s*)double ([\w_]+)_data\[([\w*+-]+)\]\[([\w*+-]+)\];\s*$',
                     lines[i])
        if data_match:
            tabs = data_match.group(1)
            name = data_match.group(2)
            n_rows = data_match.group(3)
            n_cols = data_match.group(4)

            matrix_match = \
                re.match(tabs + 'Matrix ' + name + \
                         '\(' + name + '_data\);\s*$',
                         lines[i+1])
            if matrix_match:
                line_to_write = \
                    tabs + \
                    'NewStackMatrixMacro(' + name + \
                    ', ' + n_rows + ', ' + n_cols + ');\n'
                # Skip the next line as we replace both lines
                # with lines_to_write
                i = i+1
        i = i+1
        lines_to_write.append(line_to_write)

with open(sys.argv[1], 'w') as f:
    for line in lines_to_write:
        f.write(line)
