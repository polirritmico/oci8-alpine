# Oracle Instantclient builder

## Build and Execution

To avoid permission issues when exporting the generated packages to the host,
the `HOST_UID` build argument must be set when building the image. Additionally,
the target volume where the packages are exported into the host must be
specified:

```bash
docker build --build-arg HOST_UID=$(id -u) -t oracle-instantclient-builder .
docker run --rm -it -v "$PWD/build":/home/ci/builds oracle-instantclient-builder
```

Afterward, check the `build` directory to get the generated Alpine apk packages.

## Usage

Copy the `apk` files into the image/container and install them using **apk**.
For example, to install `oci`:

```Dockerfile
COPY path/to/oci/package/* .
RUN apk add --allow-untrusted oracle-instantclient-oci-<version>.apk
```

> [!NOTE]
>
> Instantclient <= v19 require `libnsl.so.1`. As a workaround, instead of
> manually creating a symbolic link to the **so** file provided by the `libnsl`
> Alpine package, a copy of `libnsl.so.3.0.0` renamed to `libnsl.so.1` is
> included in the generated package.
