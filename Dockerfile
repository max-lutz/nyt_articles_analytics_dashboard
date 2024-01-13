FROM mageai/mageai:latest

# Note: this overwrites the requirements.txt file in your new project on first run. 
# You can delete this line for the second run :) 
COPY requirements.txt requirements.txt 

RUN pip3 install -r requirements.txt
