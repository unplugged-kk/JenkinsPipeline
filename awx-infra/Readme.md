
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

How to find the url ?

 kubectl get svc |grep awx-service 
 
 awx-service            NodePort    10.96.66.178     <none>        80:30605/TCP        17m
  
 here port no is 30605 , replace the port no in the below url.

http://localhost:30605/#/login




