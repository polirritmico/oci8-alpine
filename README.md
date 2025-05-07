# Oracle Instantclient builder

## Execution

Build the image and run the container with a target volume (`./build` in the
example):

```bash
docker build -t oracle-instantclient-builder .
docker run --rm -it -v $PWD/build:/home/ci/packages oracle-instantclient-builder
```

After, check the `build` directory to get the generated Alpine apk packages.

## Usage

Copy the `apk` files into the image/container and install them through **apk**.
For example, to install `oci`:

```Dockerfile
COPY path/to/oci/package/* .
RUN apk add --allow-untrusted oracle-instantclient-oci-<version>.apk
```

> [!NOTE]
>
> Instantclient <= v19 requires `libnsl.so.1`. A workaround is to add a symbolic
> link to the version provided by the `libnsl` alpine package:
>
> ```Dockerfile
> RUN apk add --no-cache -y libnsl
> RUN ln -sn /usr/lib/libnsl.so.3 /usr/lib/libnsl.so.1
> ```
