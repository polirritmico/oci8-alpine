# Oracle Instantclient builder

## Execution

Build the image and run the container with a target volume (`./build` in the
example):

```bash
docker build -t oracle-instantclient-builder .
docker run --rm -it -v "$PWD/build":/home/ci/builds oracle-instantclient-builder
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
> Instantclient <= v19 requires `libnsl.so.1`. As a workarround, instead of
> manually creating a symbolic link to the **so** file provided by the `libnsl`
> alpine package, a copy of `libnsl.so.3.0.0` renamed to `libnsl.so.1` is
> included into the generated package.
