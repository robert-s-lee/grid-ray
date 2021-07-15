A example of [Ray](https://docs.ray.io/en/master/) running inside [Grid.ai][https://grid.ai]

## Setup

Setup local environment
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

## Run on local environment

```
python ray-tune-quickstart.py
```

## Run on Grid unmodified

There are couple of ways to setup the execution environment.  The easiest way is to let Grid.ai use requirements.txt to setup the environment.

```
grid run ray-tune-quickstart.py
```

Another approach is to specify the Dockerfile that has everything using [--dockerfile simple1.dockerfile](simple1.dockerfile).  Grid.ai will build using this specification.

```
grid run --dockerfile simple1.dockerfile --localdir ray-tune-quickstart.py
```