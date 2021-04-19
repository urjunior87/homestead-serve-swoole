# homestead-serve-swoole
When **"vagrant reload --provision"**, this shell script will generate nginx config for you.

After download the shell script, move into Homestead/scripts folder, give it a name as serve-swoole.sh


```
sites:
    - map: yourdomain.test
      to: <project_dir>/public:<port_number>
      type: "swoole"
```


Make sure fill:
**<project_dir>** **<port_number>**
