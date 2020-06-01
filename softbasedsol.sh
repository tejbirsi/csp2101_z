#!/bin/bash

#Name: Tejbir Singh
#Student ID:10482218
#if the folder "codeFolder" does not exist then it downloads the folder from the link provided.
#wget is used for non-interactive download of a file or folder
if ! [ -f codeFolder ]; then
    wget -O codeFolder "https://www.ecu.edu.au/service-centres/MACSC/gallery/gallery.php?folder=152"
    echo -e "folder downloaded\n"
else
    echo -e "File already exists\n"
fi

# here I have used a bunch of echo statements to provide user with a menu of the functions he can perform
echo "Choose one of the following functions that you want to perform: " 
echo " 1. Download a specific thumbnail: "
echo " 2. Download all thumbnails: "
echo " 3. Download Images in a range (by the last 4 digits of the file name): "
echo -e " 4. Download a specified number of images:\n"
#I have used a for loop where user is asked to choose one of the abovementioned fucntions that can be performed.

for ((;;))
    do
        read -p "Your Selection:" selection
        if [[ $selection -eq 1 ]]; then #if user inputs 1 then do the following 
        for ((;;))
            do 
                read -p "Enter the last four digits of the image you want to download DSC0 (1533-2042):" S1 #user is asked to enter the last four digits of the file to be downloaded
                    if [[ $S1 -gt 2042 ]]  || [[ $S1 -lt 1533 ]]; then #if  the entered number is out of the range 1533 and 2042 then
                        echo "Invalid input. Enter the last four numbers of the desired image." #display this message and user is reprompted to enter a valid number 
                        
                    else 
#wget downloads the image according to the number provided and puts it into "Selection" folder with the appropriate name
                        wget -P ./Selection https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC0$S1.jpg
                        file_name=./Selection/DSC0$S1.jpg
                        file_size=$( stat -c%s "$file_name" ) # stat gets the size of the downloaded file and thatbis stored in variable"file_size"
                        if ! [[ $file_size -eq 0 ]]; then #if file_size is not 0 then show the following message with appropriate values
                            echo "Downloading DSC0$S1, with the full file name  $file_name, with a file size of $file_size...File Download Complete. "
                            echo -e "Program Finished\n" 
                            break 
                        else #else if no image is associated with the provided number display the follwoing message and user is asked to input another number 
                            echo "No Image present with this number. "
                        fi
                    fi
        done
        elif [[ $selection -eq 2 ]]; then #if user inputs 2 then do the following 
            if ! [ -d Everything ];  then # if "Everything" does not exist then do the following
            # sed command is used for substitution. here I have used to remove the starting bit of the lines that have the links to the images.
                 #here it removes the ending bit of all the lines from "codeFolder"
                sed -i  -e 's/<img src="//g' \
                        -e 's/" alt="DSC0.*$//g' codeFolder 
                grep "https://secure.ecu.edu.au/service-centres" codeFolder > urls.txt # grep is used to grab something from one file. Here I have asked it to grab the links to all the images from 'codeFolder"() and puts it in "urls.txt"
                wget -i urls.txt -P Everything/ #wget downloads all the images from the links in "urls.txt" and puts those images in "Everything"
                echo "Program Finished"
            
            else #if "Everything" already exits then display the following message
                echo -e "all the images already exist in 'Everything'.\n"
            fi

        elif [[ $selection -eq 3 ]]; then # if user inputs 3 then do the following
        for((;;))
            do
                read -p "Enter the last four digits of the starting range :" start #user is asked to enter the starting range
                    if [[ $start -gt 2042 ]]  || [[ $start -lt 1533 ]]; then #if  the entered number is out of the range 1533 and 2042 then
                        echo -e "Invalid input. Enter a number between 1533 & 2042\n" #display this message and user is reprompted to enter a valid number 
                    else
                        read -p "Enter the last four digits of the ending range :" end #user is asked to enter the ending range
                    
                        if [[ $end -gt 2042 ]]  || [[ $end -lt 1533 ]]; then 
                        echo -e "Invalid input. Enter a number between 1533 & 2042\n"
                        
                        elif [[ $start -gt $end ]]; then # if the ending range is smaller than the starting range then the user is prompted with the following mesage and is asked to re-enter the values
                            echo -e "the ending range cannot be smaller than the starting range.\n "

                        else            
                            for i in $(seq $start $end) # for every element from the starting range to ending range
                            do
                                grep  "https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC0$i.jpg" urls.txt > f3.txt #grab the appropriate link from "urls.txt" and put those in "f3.txt"
                                wget -o /dev/null -i f3.txt -P range/ #wget downloads all the images from the links in "f3.txt" and puts them in "Range" folder
                            done
                        
                                echo -e "Program Finished\n"
                                break
                        fi
                    fi   
                done
                

             
            
        elif [[ $selection -eq 4 ]]; then # if user inputs 4 then do the following
            read -p "input a random number for the amount of images you want to download: " random #user prompted to enter a random number
            aa=$(shuf -i 1533-2042 -n $random) #shuf command is used to get random numbers from a given range. Here it gets a random number from the user and then generates that amount of numbers and assigns them to variable $aa
            for i in "${aa[@]}" 
                do    
                    grep  "https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC0$aa.jpg" urls.txt > f4.txt #grabs the appropriate links from the "urls.txt" and puts then in "f4.txt"
                    wget -i f4.txt -P random/ #wget downloads all the images from the links in f4.txt and puts them in "Random" folder
                done
    
        else #else user's choice being anything except 1,2,3,4 display the following message and reprompt them to enter a valid input.
            echo -e  "Invalid Input. Please choose 1 or 2 or 3 or 4. \n"
            continue 
        fi 
done
