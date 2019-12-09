if [ -z $SETUP_JUPYTERLABS ]; then

	pip install jupyterlab "ipywidgets>=7.5"
	# pip install jupyterlab==1.2 "ipywidgets>=7.5"

	# Avoid "JavaScript heap out of memory" errors during extension installation
	export NODE_OPTIONS=--max-old-space-size=4096

	# Jupyter widgets extension
	jupyter labextension install @jupyter-widgets/jupyterlab-manager@1.1 --no-build

	# jupyterlab renderer support
	jupyter labextension install jupyterlab-plotly@1.3.0 --no-build

	# FigureWidget support
	jupyter labextension install plotlywidget@1.3.0 --no-build

	# Build extensions (must be done to activate extensions since --no-build is used above)
	jupyter lab build

	# Unset NODE_OPTIONS environment variable
	unset NODE_OPTIONS

	echo "export SETUP_JUPYTERLABS=installed" >> $SETUP_FILE
fi

