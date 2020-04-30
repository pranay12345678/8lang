import argparse
import copy as c
def main():
	parser=argparse.ArgumentParser()
	parser.add_argument("Files",type=str,nargs=1)
	parser.add_argument('-c','--count',action='store_true')
	parser.add_argument('-d','--repeated',action='store_true')
	parser.add_argument('-i','--ignore-case',action='store_true')
	parser.add_argument('--x',action="store",type=str,nargs=1,dest='filename',help='replacement of >')
	args=parser.parse_args()
	print(vars(args))
	filename=args.Files
	file=open(filename[0],'r')
	lines=file.readlines()
	copy= c.deepcopy(lines)
	print('\n'+filename[0]+'\n')
	if args.ignore_case:
		for i in range(len(lines)):
			lines[i]=lines[i].lower()
	if args.count:
		uni_lines=set(lines)
		uni_lines=list(uni_lines)
		for line in uni_lines:
			count=0
			for i in range(len(lines)):
				if lines[i]==line:
					count+=1
			count=str(count)
			if args.filename:
				newfile=open(args.filename[0],'a')
				newfile.write(count+'. '+copy[lines.index(line)])
			else:
				print(count+'. '+copy[lines.index(line)],end='')
	elif args.repeated:
		uni_lines=set(lines)
		uni_lines=list(uni_lines)
		for line in uni_lines:
			count=0
			for i in range(len(lines)):
				if lines[i]==line:
					count+=1
			if count>1:
				if args.filename:
					newfile=open(args.filename[0],'a')
					newfile.write(copy[lines.index(line)])
				else:
					print(copy[lines.index(line)],end='')
	else:
		uni_lines=set(lines)
		uni_lines=list(uni_lines)
		for line in uni_lines:
			if args.filename:
				newfile=open(args.filename[0],'a')
				newfile.write(copy[lines.index(line)])
			else:
				print(copy[lines.index(line)],end='')

if __name__ == '__main__':
	main()
	