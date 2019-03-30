- Add ip and identifier to host-list file.
    e.g : 123.32.43.541 slave01
- run `chmod +x setup.sh`
On Master Rum `./setup.sh master IP-ADDRESS`
- Copy the content of .ssh/id_rsa.pub (of master) to .ssh/authorized_keys (of all the slaves as well as master).
- To Check the connection
    - ssh slave01
