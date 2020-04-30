import argparse
def main():
	parser=argparse.ArgumentParser()
	parser.add_argument("Files",type=str,nargs='+')
	parser.add_argument('--x',action="store",type=str,nargs=1,dest='filename',help='replacement of >')
	args=parser.parse_args()
	print(vars(args))
	if args.filename:
		newfile=open(args.filename[0],'w')
	for filename in args.Files:
		file=open(filename,'r')
		if args.filename:
			newfile.write(file.read())
		else:
			print(file.read())
if __name__ == '__main__':
	main()