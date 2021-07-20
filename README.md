A example [Grid.ai](https://grid.ai) running [Ray](https://docs.ray.io/en/master/) in the model.  The examples will show how to:

- [Get started with Development Setup](#get-started-with-development-setup)
- [Unit test by running experiment locally](#unit-test-by-running-experiment-locally)
- [Run on Grid.ai Cloud with zero code modification](#run-on-gridai-cloud-with-zero-code-modification)
- [Advanced Dockerfile usage on Grid.ai](#advanced-dockerfile-usage-on-gridai)
- [Use Grid.ai when the model is not on GitHub](#use-gridai-when-the-model-is-not-on-github)
- [Troubleshooting Tips](#troubleshooting-tips)

# Get started with Development Setup

- Setup development environment

```bash
# Grid.ai minimum is python=3.8
conda create --name ray python=3.8
conda activate ray
# Python modules required
cat >requirements.txt <<EOF
ray
ray[tune]
ray[default]
pandas
tabulate
tensorboardX
EOF
# Install Python modules for the experiment
pip install --ignore-requires-python -v -r requirements.txt
# Install Python modules for the Grid
pip install lightning-grid --upgrade
```

# Unit test by running experiment locally

```bash
python ray-tune-quickstart.py
```

# Run on Grid.ai Cloud with zero code modification

- Login into Grid.ai

```bash
grid login
```

- Run using default Grid.ai container.  Use CLI below or click on Grid.ai Run Badge [![Single Run](https://img.shields.io/badge/rid_AI-run-78FF96.svg?labelColor=black&logo=data:image/svg%2bxml;base64,PHN2ZyB3aWR0aD0iNDgiIGhlaWdodD0iNDgiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PHBhdGggZD0iTTEgMTR2MjBhMTQgMTQgMCAwMDE0IDE0aDlWMzYuOEgxMi42VjExaDIyLjV2N2gxMS4yVjE0QTE0IDE0IDAgMDAzMi40IDBIMTVBMTQgMTQgMCAwMDEgMTR6IiBmaWxsPSIjZmZmIi8+PHBhdGggZD0iTTM1LjIgNDhoMTEuMlYyNS41SDIzLjl2MTEuM2gxMS4zVjQ4eiIgZmlsbD0iI2ZmZiIvPjwvc3ZnPg==)](
https://platform.grid.ai/#/runs?script=https://github.com/robert-s-lee/grid-ray/blob/725ea1bbb9fcb661bd850d6e7270efce4c554719/ray-tune-quickstart.py&cloud=grid&instance=t2.medium&accelerators=1&disk_size=200&framework=lightning&script_args=ray-tune-quickstart.py
)


```bash
grid run ray-tune-quickstart.py
```

# Advanced Dockerfile usage on Grid.ai

Use Grid.ai with GitHub and Dockerfile examples by using customized container with [--dockerfile gridray.dockerfile](gridray.dockerfile) flag.

- Run using manually specifying the Dockerfile.  Use CLI below.



```bash
grid run --dockerfile gridray.dockerfile --name ray-dk-$(date '+%m%d-%H%M%S') ray-tune-quickstart.py
```

- Use spot instance and override Run name with `ray-MMDD-HHMMSS` for easier search later.  Use CLI below.

```bash
grid run --dockerfile gridray.dockerfile --use_spot --name ray-sp-dk-$(date '+%m%d-%H%M%S') ray-tune-quickstart.py
```
# Use Grid.ai when the model is not on GitHub

Using `--localdir` does not allow the Grid.ai cloning feature. 

- Let Grid.ai build the container
```bash
grid run --name ray-local-$(date '+%m%d-%H%M%S') --localdir ray-tune-quickstart.py
```

- Use the container specification 

```bash
grid run --dockerfile gridray.dockerfile --use_spot --name ray-sp-dk-lc-$(date '+%m%d-%H%M%S') --localdir ray-tune-quickstart.py

```

# Troubleshooting Tips

- Review `grid history`

```bash
grid history | grep -e Run -e ray -e $(date '+%Y-%m-%d')
```

```
┃ Run                              ┃               Created At ┃ Experiments ┃ Failed ┃ Stopped ┃ Completed ┃
│ ray-sp-dk-lc-0720-105956         │ 2021-07-20 15:00:09+0000 │           1 │      0 │       0 │         1 │
│ ray-local-0720-105916            │ 2021-07-20 14:59:30+0000 │           1 │      0 │       0 │         1 │
│ ray-sp-dk-0720-105713            │ 2021-07-20 14:57:25+0000 │           1 │      0 │       0 │         1 │
│ ray-dk-0720-105640               │ 2021-07-20 14:56:53+0000 │           1 │      0 │       0 │         1 │
│ fervent-tamarin-146              │ 2021-07-20 14:55:39+0000 │           1 │      0 │       0 │         1 │
```

- Review `grid status`

```bash
for run in $(grid history | grep -e Run -e ray -e $(date '+%Y-%m-%d') | awk -F'│' '{print $2}'); do
  echo $run
  grid status $run
done
```

```text
ray-sp-dk-lc-0720-105956
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━┳━━━━━━━━━━━━━┓
┃ Experiment                    ┃                 Command ┃    Status ┃    Duration ┃
┡━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━╇━━━━━━━━━━━━━┩
│ ray-sp-dk-lc-0720-105956-exp0 │ ray-tune-quickstart.py] │ succeeded │ 0d-00:01:28 │
└───────────────────────────────┴─────────────────────────┴───────────┴─────────────┘
```