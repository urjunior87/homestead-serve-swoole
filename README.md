# homestead-serve-swoole
When **"vagrant reload --provision"**, this shell script will generate nginx config for you.

After download the shell script, move file into Homestead/scripts folder, give it a file name as serve-swoole.sh



**Your Homestead.yaml must look like this**
```
sites:
    - map: yourdomain.test
      to: <project_dir>/public:<port_number>
      type: "swoole"
```


Make sure fill in:
**<project_dir>** **<port_number>**


After that ssh into your project directory, and start your swoole http server.
