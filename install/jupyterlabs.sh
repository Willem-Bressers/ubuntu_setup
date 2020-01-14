CURRENT_PATH=$(dirname "${0}")

if [ -z $SETUP_JUPYTER_LAB_DEPENDENCIES ]; then

	# ensure python is installed
	source $CURRENT_PATH/python.sh

	# ensure nodejs is installed
	source $CURRENT_PATH/nodejs.sh

	# install jupyter labs
	pip3 install jupyterlab==1.2 "ipywidgets==7.5"

	echo "export SETUP_JUPYTER_LAB_DEPENDENCIES=installed" >> $SETUP_FILE

	exit
fi

source ~/.bashrc

if [ -z $SETUP_JUPYTER_LAB_CONFIG ]; then

	# Avoid "JavaScript heap out of memory" errors during extension installation
	export NODE_OPTIONS=--max-old-space-size=4096

	# generate custom config
	jupyter notebook --generate-config
	echo -e '\n # ===== CUSTOM =====\nc.NotebookApp.ip = "0.0.0.0"\nc.NotebookApp.open_browser = False' >> $HOME/.jupyter/jupyter_notebook_config.py

	# generate a password 
	jupyter notebook password

	# Jupyter widgets manager
	jupyter labextension install @jupyter-widgets/jupyterlab-manager@1.1 --no-build

	# monokai theme
	jupyter labextension install theme-dark-monokai

	# Plotly
	# @jupyterlab/plotly-extension is being deprecated. Please use the Plotly-supported jupyterlab-plotly.
	jupyter labextension install plotlywidget@1.4.0 --no-build
	jupyter labextension install jupyterlab-plotly@1.4.0 --no-build

	# Build extensions (must be done to activate extensions since --no-build is used above)
	jupyter lab build --minimize=False

	# Unset NODE_OPTIONS environment variable
	unset NODE_OPTIONS

	echo "export SETUP_JUPYTER_LAB_CONFIG=installed" >> $SETUP_FILE
fi

