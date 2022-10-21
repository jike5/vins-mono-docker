# VINS-Mono Docker

## 1. Pull image from docker hub

```
docker image pull jike5/vins-mono:cpu
```

> Maybe you need login first
>
> ```bash
> docker login -u [UserName]
> ```

## 2. Build image

You can modify the Dockerfile and build your own image:

```bash
docker image build -t jike5/vins-mono:cpu .
```

> For proxy:
>
> ```bash
> docker image build -t jike5/vins-mono:cpu . --build-arg HTTP_PROXY=http://127.0.0.1:58591 --build-arg HTTPS_PROXY=http://127.0.0.1:58591 --build-arg ALL_PROXY=socks5://127.0.0.1:51837 --network host
> ```

## 3. Run docker container

If it is the first time, you should run below to download and build vins-mono:

```bash
sudo ./build_container_cpu.sh
```

For the next time, just run below:

```bash
```

> In vins_ws was modified by container user, you may need to change permission：
>
> ```bash
> sudo chmod 777 -R ./*
> ```
>
> 
