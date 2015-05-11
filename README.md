#Automating your EC2 Builds

-	a Presentation for the [AWS User Group Birmingham 2015-05-12](http://www.meetup.com/AWS-User-Group-West-Midlands/events/221857820/)

Docker build (optional)
-----------------------

`docker build -t test_server ./ && docker run -t -e NODE_PORT=8080 -p 8080:8080 test_server`
