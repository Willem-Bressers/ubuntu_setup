if [ -z $SETUP_JUPYTERLABS ]; then

	pip3 install jupyterlab==1.2 "ipywidgets==7.5"
	
	# Avoid "JavaScript heap out of memory" errors during extension installation
	# (OS X/Linux)
	export NODE_OPTIONS=--max-old-space-size=4096

	# Jupyter widgets manager
	jupyter labextension install @jupyter-widgets/jupyterlab-manager@1.1 --no-build

	# Plotly
	# @jupyterlab/plotly-extension is being deprecated. Please use the Plotly-supported jupyterlab-plotly.
	jupyter labextension install plotlywidget@1.4.0 --no-build
	jupyter labextension install jupyterlab-plotly@1.4.0 --no-build

	# Build extensions (must be done to activate extensions since --no-build is used above)
	jupyter lab build --minimize=False

	# Unset NODE_OPTIONS environment variable
	unset NODE_OPTIONS

	echo "export SETUP_JUPYTERLABS=installed" >> $SETUP_FILE
fi

