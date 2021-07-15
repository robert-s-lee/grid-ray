
## Setup
```
conda create --name ray python=3.7
conda activate ray
pip install -U ray
pip install 'ray[tune]'
pip install 'ray[default]'
pip install lightning-grid --upgrade
pip install pandas
pip install tabulate
pip install tensorboardX

pip freeze > requirements.txt
```

## test Dockerfile works locally
```
docker build .
docker images
docker tag b575d540ff67 robert/gridray:version1.0
docker images
REPOSITORY                            TAG          IMAGE ID       CREATED          SIZE
robert/gridray                        version1.0   b575d540ff67   20 minutes ago   4.35GB
```

## Run on Grid

Let Grid.ai setup the container 
```
grid run ray-tune-quickstart.py
```

Manually create the container 
```
grid run --dockerfile Dockerfile --localdir ray-tune-quickstart.py
```