# 

# Building 

in the humhub directory

`docker build -t bishoy/humhub .`

change bishoy to whatever image name.

# Running

```
docker run --rm -ti -p 80:80 -e MYSQL_ROOT_PASSWORD=rootpass -e MYSQL_DATABASE=humhub -e MYSQL_USER=humhub -e MYSQL_PASSWORD=humpass  bishoy/humhub /bin/bash
```



## missing

- ssh 