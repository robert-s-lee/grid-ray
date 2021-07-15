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

There are couple of ways to setup the execution environment.  The easiest way is to let Grid.ai use requirements.txt to setup the environment.  Click Grid Run Badge [![Single Run](https://img.shields.io/badge/rid_AI-run-78FF96.svg?labelColor=black&logo=data:image/svg%2bxml;base64,PHN2ZyB3aWR0aD0iNDgiIGhlaWdodD0iNDgiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PHBhdGggZD0iTTEgMTR2MjBhMTQgMTQgMCAwMDE0IDE0aDlWMzYuOEgxMi42VjExaDIyLjV2N2gxMS4yVjE0QTE0IDE0IDAgMDAzMi40IDBIMTVBMTQgMTQgMCAwMDEgMTR6IiBmaWxsPSIjZmZmIi8+PHBhdGggZD0iTTM1LjIgNDhoMTEuMlYyNS41SDIzLjl2MTEuM2gxMS4zVjQ4eiIgZmlsbD0iI2ZmZiIvPjwvc3ZnPg==)](
https://platform.grid.ai/#/runs?script=https://github.com/robert-s-lee/grid-ray/blob/b6fc1cca49e343174d6da805732d1cf82133ca0f/ray-tune-quickstart.py&cloud=grid&instance=t2.medium&accelerators=1&disk_size=200&framework=lightning&script_args=ray-tune-quickstart.py
)
or use the CLI below:

```
grid run ray-tune-quickstart.py
```

Another approach is to specify the Dockerfile that has everything using [--dockerfile simple1.dockerfile](simple1.dockerfile).  Grid.ai will build using this specification.

```
grid run --dockerfile simple1.dockerfile --localdir ray-tune-quickstart.py
```