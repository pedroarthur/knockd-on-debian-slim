Debian-based knockd container
=============================

This image starts `knockd` in debug and verbose mode using the configuration file under `/etc/knockd.conf` (Debian's default settings). To disable knockd's debug and verbose output, set `KNOCKD_VERBOSE` to `false`.

*Important*: this image requires access to the host's network. Besides that, it needs `NET_ADMIN` and `NET_RAW` capabilities so it can change firewall rules. So, whenever it reads

    docker run ...

One must read as

    docker run --net=host --cap-add NET_ADMIN --cap-add NET_RAW ...

Let's stop this `--privileged` madness!

Knock interface
---------------

This image uses `detect-interface.sh` to choose the interface it will listen to knocks. By default, this interface will be the one associated with the default route (_i.e._, 0.0.0.0). To change this behavior, one can pass a different script using `KNOCKD_DETECT_INTERFACE`, hard-wire to a given interface using `KNOCKD_INTERFACE`, or set it in the CLI:

    docker run -e KNOCKD_DETECT_INTERFACE=my-detect-script.sh pedroarthur/knockd
    # The following two ways are equivalent
    docker run -e KNOCKD_INTERFACE=br-101 pedroarthur/knockd
    docker run pedroarthur/knockd -i br-101

*Important*: if you set `KNOCKD_INTERFACE`, the script _will not_ run `detect-interface.sh`.

Overriding `/etc/knockd.conf`
-----------------------------

To override the knockd's default configuration, one has two options:

    docker run -v "$(pwd)/knockd.conf:/etc/knockd.conf" pedroarthur/knockd

Or

    docker run -v "$(pwd)/knockd.conf:/cte/knockd.conf" pedroarthur/knockd -c /anywhere/knockd.conf

In summary, one may choose between binding a file to `/etc/knockd.conf` and binding a configuration file somewhere else in the container. A third option is to create a new docker image.

Cookbook
--------

*I want a shell!*

    docker run pedroarthur/knockd bash

*I want to test my configuration!*

    docker run pedroarthur/knockd -i lo
    docker run pedroarthur/knockd knock localhost 7000 8000 9000

