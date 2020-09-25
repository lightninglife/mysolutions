Mac based solutions

Task 1 - Print the total number of non-blank lines

vim task1
chmod u+x task1
——————————
#!/bin/bash
# Remove blank lines
sed '/^$/d' loomings.txt > loomingsnew.txt
# Count line numbers
wc -l loomingsnew.txt | awk '{ print $1 }'

Task 2 - Create a file with a unique name containing each non-blank line of text read from the file.

vim task2
chmod u+x task2
——————————
#!/bin/bash
# Remove blank lines
sed '/^$/d' loomings.txt > loomingsnew.txt
# Create files from each line of the file
counter=0; cat loomingsnew.txt | while read LINE; do ((counter++)); echo $LINE > "file-$counter.txt"; done

Task 3 - Create a companion file for each file. Each companion file will be a hash digest of the content of the file

vim task3
chmod u+x task2
chmod u+x task3
——————————
#!/bin/bash
./task2
x=$(ls -lq file-* | wc -l)
for ((i=1; i<=x; i++));
do
   echo "file-$i.txt" > "file-$i.hash"
done

Task 4 - List the files sorted based on the size of the file, in order, from smallest to largest based on the size (total bytes) of the content within the file. Print the name and size of each file on each line of the output

vim task4
chmod u+x task4
——————————
#!/bin/bash
# Remove blank lines
sed '/^$/d' loomings.txt > loomingsnew.txt
# Create files from each line of the file
counter=0; cat loomingsnew.txt | while read LINE; do ((counter++)); echo $LINE > "file-$counter.txt"; done
# Small to big size files
ls -laShr file-*

Task 5 - Print the name of the two files that have identical content. Print the original text line which is duplicated in loomings.txt

vim task5
chmod u+x task5
——————————
#!/bin/bash
# Install md5sum to check same contents from files - indicating file-8 and file-15 have exactly same content
brew install  md5sha1sum
awk '{
          md5=$1
          a[md5]=md5 in a ? a[md5] RS $2 : $2
          b[md5]++ }
          END{for(x in b)
                if(b[x]>1)
                  printf "Duplicate Files (MD5:%s):\n%s\n",x,a[x] }' <(find ./file-*.txt -type f -exec md5sum {} +)
# Print out the original text line which is duplicated in loomings.txt
sort loomings.txt | uniq -d


Task 6 - Remove the duplicate (second occurance) line from loomings.txt and create a new version of the file and call it loomings-clean.txt. Perform diff loomings*txt and produce output
Note: I believe there will be much better solutions than the one I provided for diff, I’ll keep looking for them. As soon as I come up with one, I’d like to share

vim task6 
chmod u+x task6 
——————————

#!/bin/bash
# Remove the duplicate (second occurance) line from loomings.txt to create a new version of the file and call it loomings-clean.txt
sort loomings.txt | uniq > loomings-clean.txt
# Perform diff loomings*txt and produce output
diff3 loomings*txt >> diff3.txt
diff <(cat loomings.txt) <(cat loomingsnew.txt) >> diff2.txt
diff loomings.txt loomings-clean.txt >> diff2.txt
diff loomingsnew.txt loomings-clean.txt >> diff2.txt
