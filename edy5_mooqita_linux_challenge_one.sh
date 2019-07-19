#create line of 15 random characters
#save line to file
#repeat untill file size reaches 1 Mib
for i in {1..65535}
do
  strings /dev/urandom | tr -dc A-Za-z0-9 | head -c15 >> edy_mooqita_linux_challenge_one
  echo "" >> edy_mooqita_linux_challenge_one
done
strings /dev/urandom | tr -dc A-Za-z0-9 | head -c15 >> edy_mooqita_linux_challenge_one

## strings /dev/urandom generates string of random characters
#### /dev/urandom was used because its faster than /dev/random and generates all characters instead of only numbers like $RANDOM
## tr -dc A-Za-z0-9 deletes all nonalphanumeric characters
## head -c15 >> file_name saves 15 characters to file
## echo "" >> fine_name move to next line before saving next string

## each line is 16 bytes (15 characters + 1 line break)
## 1 Mib file (1048576 bytes) fits 65536 lines (1048576/16 = 65536)
## for loop repeats to generate 65536 lines, 16 bytes each to generate 1 Mib file
### last line does not need a line break because there are no subsequent lines being added

#check file size
ls -sh edy_mooqita_linux_challenge_one
ls -lh edy_mooqita_linux_challenge_one

#sort
sort -o edy_mooqita_linux_challenge_one edy_mooqita_linux_challenge_one
## sort with default options is the most common sorting technique
###if you do not use -o option it outputs the file sorted but does not save it
## this sorts numbers first then leters alphabeticlly
## I chose to sort this way because the code I use for the next step does not require sorting  

#remove lines starting with the letter a
#save to new file
for i in {1..65536}
do
  letter=`awk '$1' edy_mooqita_linux_challenge_one | head -n$i | tail -n1 | head -c1` 
  case $letter in
  "a" | "A")  ;;
  *) awk '$1' edy_mooqita_linux_challenge_one | head -n$i | tail -n1 >> edy_mooqita_linux_challenge_one_new
  esac
done

## awk '$1' file_name | head -n$i | tail -n1 prints line i of file
## letter= `... | head -c1` saves first character of line i 
## case checks that the saved variable is not "a" or "A" then copies the line i to new file

#count lines removed
new_line_count=`wc -l edy_mooqita_linux_challenge_one_new | tr -dc 0-9`
echo $((65536-$new_line_count))

## wc -l file_name counts lines in new file
## variable=`... | tr -dc 0-9` stores number as variable
## echo $((65536-$new_line_count)) subtracts line count of orignal file from line count of new file i.e. lines removed
exit 0
