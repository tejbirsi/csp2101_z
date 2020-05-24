#Tejbir Singh
#10482218
#!/bin/bash
#if the file rectangle.txt does not exist then 
if ! [ -f rectangle.txt ]; then 
# print the folllowing message to the screen(Ctrl+D is just used to exit the cat command)
    echo "rectangle.txt created. please add the rectangle dimensions. Press Ctrl + D twice to continue."
# this line creates the file rectangle.txt 
    cat >rectangle.txt
fi
     
# if the file rectangle.txt exists then
if [ -f rectangle.txt ]; then
#sed command is mostly used to replace text where needed. s stands for substitute; / acts as a delimiter
#here e is used to add several expressions together
#"1d" deletes the first line in the file that is used(here rectangle.txt)
#(Line 22)looks for all the lines starting with 'Rec' and then replaces that 'Rec' with 'Name:Rec'
#(Line 23 to 26)looks for all the lines starting with 'Name' and then replaces ',' with the following words (Height,Width,Area,Colour) in the respective lines
#the'/t' means tab and is used to provide uniform spacing between columns
    sed -e '1d'\
        -e '/^Rec/ s/Rec/Name:Rec/'\
        -e '/^Name/ s/,/\tHeight:/'\
        -e '/^Name/ s/,/\tWidth:/'\
        -e '/^Name/ s/,/\tArea:/'\
        -e '/^Name/ s/,/ \tColour:/' rectangle.txt > rectangle_f.txt #this rectangle.txt > rectangle_f.txt tells the command to output the result into a new file(which it creates) that being rectangle_f.txt from the original rectangle.txt
        exit 0 
fi  

