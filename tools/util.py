#!/usr/bin/python3

import re
import argparse

parser = argparse.ArgumentParser(description="Fix common problems on latex files.")

parser.add_argument("file", help="File to process")
parser.add_argument("--doublebackslashes", help="Fix double backslashes breaklines", action="store_true")
parser.add_argument("--title", help="Convert the first line on the title", action="store_true")
parser.add_argument("--baselineskip", help="Remove baselineskip", action="store_true")
parser.add_argument("--cleanhtml", help="Remove HTML tags (keep <p>...</p>)", action="store_true")

args = parser.parse_args()

input_file = open(args.file, 'r')
data = input_file.read()

if args.doublebackslashes:
    regex = r"\\{2}\n"
    subst = "}\\n\\n{"
    data = re.sub(regex, subst, data, 0)

if args.title:
    regex = r"^{(.*)}"
    subst = "\\\\chapter*{\\1}\\n\\\\addcontentsline{toc}{chapter}{\\1}"
    data = re.sub(regex, subst, data, 0)

if args.baselineskip:
    regex = r"\\\\\[2\\baselineskip]"
    subst = "}\\n\\n{"
    data = re.sub(regex, subst, data, 0)

if args.cleanhtml:
    for _ in range(0, 10):
        data = re.sub(r"<[^>]*[^p]>", "", data, 0)
        data = re.sub(r"<p>[\s*0-9]<\/p>", "", data, re.UNICODE)
        data = re.sub(r"^\s*$", "", data, 0, re.MULTILINE)

output_file = open(args.file, 'w')
output_file.write(data)
