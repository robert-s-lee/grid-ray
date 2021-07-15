
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