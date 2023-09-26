srun -N1 -n1 --gres=gpu:4 --time=24:00:00 --partition=normal --account=s83 --pty zsh
mamba env create -f environment.yml
mamba activate graphcast
pip install --upgrade "jax[cuda11_pip]" -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html
python test_cuda.py
exit

#------------Jupyter Server------------------#
srun -N1 -n1 --gres=gpu:4 --time=24:00:00 --partition=normal --account=s83 --pty zsh -c "export VSCODE_IPC_HOOK_CLI=/tmp/vscode-ipc-$(id -u)-$(uuidgen | cut -d - -f 1).sock && jupyter lab --port=8888 --ip=0.0.0.0 --no-browser"

#------------Test Data Import in Python--------------#
import xarray as xr
xr.load_dataset("data/data_train.zarr")
