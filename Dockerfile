FROM kong/kong:latest

# Ensure any patching steps are executed as root user
USER root

RUN apt-get update

RUN apt-get install -y git curl

# Add custom plugin to the image
RUN mkdir -p /usr/local/kong/plugins

COPY kong-plugin-add-header /usr/local/kong/plugins/kong-plugin-add-header

ENV KONG_LUA_PACKAGE_PATH=/usr/local/kong/plugins/kong-plugin-add-header/?.lua;;

ENV KONG_PLUGINS=bundled,add-header

RUN apt install build-essential -y

RUN apt-get -y install cmake

RUN curl https://github.com/EmmyLua/EmmyLuaDebugger/archive/refs/tags/1.0.16.tar.gz \
         -L -o EmmyLuaDebugger-1.0.16.tar.gz && \
    tar -xzvf EmmyLuaDebugger-1.0.16.tar.gz && \
    cd EmmyLuaDebugger-1.0.16 && \
        mkdir -p build && \
        cd build && \
            cmake -DCMAKE_BUILD_TYPE=Release ../ && \
            make install && \
            mkdir -p /usr/local/emmy && \
            cp install/bin/emmy_core.so /usr/local/emmy/ && \
        cd .. && \
    cd .. && \
    rm -rf EmmyLuaDebugger-1.0.16 EmmyLuaDebugger-1.0.16.tar.gz





