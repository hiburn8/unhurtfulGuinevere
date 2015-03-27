#!/usr/bin/python
#Daniel Reece (@hbrn8)

import re, random

class bg:
    OK = '\033[92m'
    DBG = '\033[93m'
    FAIL = '\033[91m'
    END = '\033[0m'

headerfile = raw_input("enter a class-header filename (.h): ")

with open("uppercase") as f:
    uppercontent = f.readlines()
with open("lowercase") as f:
    lowercontent = f.readlines()
with open(headerfile, "r") as f:
	headerfileData = f.read()
	f.close

methodsarray = re.findall(r"((?:\-|\+)\s*\([\w\s]+(?:\s*\*)?\)(\w+)(?::\([\w\s]+(?:\s*\*)?\)\w+\s?)?(?:\w+:\([\w\s]+(?:\s*\*)?\)\w+\s?)*)", headerfileData)

fuzzwords = []
fuzzymethods = []
fullmethods =[]
halfmethods = []

i = 0
while i < len(methodsarray[0]):

	fullmethods.append(methodsarray[i][0])
	halfmethods.append(methodsarray[i][1])
	fuzzwords.append(random.choice(lowercontent).strip('\n') + random.choice(uppercontent).strip('\n'))
	fuzzymethods.append(re.sub(halfmethods[i], fuzzwords[i], fullmethods[i]))
	i+=1
'''
print bg.DBG + "DEBUG:"
print fuzzwords
print fuzzymethods
print fullmethods
print halfmethods 
print bg.END
'''

#customRegex = "(?:\-|\+)\s*\([\w\s]+(?:\s*\*)?\)" + halfmethods[i] + "(?::\([\w\s]+(?:\s*\*)?\)\w+\s?)?(?:\w+:\([\w\s]+(?:\s*\*)?\)\w+\s?)*";

i = 0
while i < len(fuzzwords):
	print bg.OK + halfmethods[i] + " -> " + fuzzwords[i] + bg.END
	headerfileData = headerfileData.replace(fullmethods[i],fuzzymethods[i])
	i+=1

with open(headerfile + '.txt', 'w+') as newfile:
				newfile.write(headerfileData)
				newfile.close

i = 0
while 1:
    choice=raw_input("(q to quit) addmember-> ")
    if choice in ["Q","q"]: 
    	break
    else:
    	with open(choice) as f:
			filecontent = f.read()
			
			while i < len(fuzzwords):
				
				filecontent =  filecontent.replace(fullmethods[i],fuzzymethods[i])
				i +=1

			with open(choice + '.txt', 'w+') as newfile:
				newfile.write(filecontent)
				newfile.close
