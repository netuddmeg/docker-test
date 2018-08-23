Goal #1.
********
Deploy a webserver  with docker listening on the port 80 and display the "Hello world" message.
System should include health check monitoring. The required DevOps tools should be installed in a Docker image.

Goal #2.
********
Goal #1 PLUS:
- automatically scale up and down according to the load
- send an email to email address if it is not working


Install & run  from the scratch:
********************************

Usage: bash <(curl -s https://raw.githubusercontent.com/netuddmeg/docker-test/master/start2.sh)

Using DigitalOcean droplet you need:
************************************

- Linux (ubuntu 16)
- minimal droplet (VPS)
- token to connect provider
- sudo access
- curl, git, docker-ce, docker-compose, docker-machine (Installed by the script!)

Steps:
******
1. start the script
2. type your token at prompt
3. test the deploy: curl http://`docker-machine ip $DOCKERMACHINE`:80
