# Oracle Instantclient builder

## Docker:

```bash
docker build -t oracle-instantclient-builder .
docker run --rm -it -v $PWD/build:/home/ci/packages oracle-instantclient-builder
```

## Inside the container:

```sh
cd user/oracle-instantclient
abuild checksum
abuild unpack
abuild-keygen -a -n
abuild -r

cd ~/packages/user/x86_64
```
