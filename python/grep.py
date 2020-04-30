import argparse

def main():
	parser=argparse.ArgumentParser()
	parser.add_argument("Pattern",type=str)
	parser.add_argument("Files",type=str,nargs='+')
	parser.add_argument('-w',action='store_true')
	parser.add_argument('-v',action='store_true',dest='invert')
	parser.add_argument('-i',action='store_true')
	parser.add_argument('--x',action="store",type=str,nargs=1,dest='filename',help='replacement of >')
	args=parser.parse_args()
	print(vars(args))
	for filename in args.Files:
		file=open(filename,'r')
		if args.filename:
			newfile=open(args.filename[0],'w')
		lines=file.readlines()
		print('\n'+filename)
		for line in lines:
			line=line.replace('\n','')
			if args.w:
				words= line.split(' ')
				if args.Pattern in words:
					try:
						newfile.write(line)
					except:
						print (line)
			elif args.invert:
				if args.Pattern not in line:
					try:
						newfile.write(line)
					except:
						print (line)
			elif args.i:
				if args.Pattern.lower() in line.lower():
					try:
						newfile.write(line)
					except:
						print (line)
			else:
				if args.Pattern in line :
					try:
						newfile.write(line)
					except:
						print (line)

if __name__ == '__main__':
	main()