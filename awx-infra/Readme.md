
#Docker Desktop Download (Download it for MAC,Windows,PC) and install it. Make sure you have Virtualization / INTEL-VT is enabled on your machine .

https://www.docker.com/products/docker-desktop 

Go to Docker Desktop --> Preferences

Docker desktop  settings :

* General section :

Make sure below are checked :

Start Docker Desktop when you log in

Open Docker Desktop dashboard at startup

* Resources (Advanced)

Minimum Configuration should be (CPU=3,Memory=4,Swap=3,Disk=16GB)

#Deploy AWX on Docker-Desktop

#Prerequisite ( configure docker-desktop & k8s with minimum 3 cpu and 4 gb RAM)

In other section don't tick to enable experimental features. 

* Kubernetes: 

Enable both options in this section

After executing script use below url to access your ansible awx :

username : admin
password : it will be prompted after successful execution of the script 

note : ignore trailing % inthe password 

http://localhost:31402/#/login



# Ingress docs

https://kubernetes.github.io/ingress-nginx/

# AWX github

https://github.com/ansible/awx


