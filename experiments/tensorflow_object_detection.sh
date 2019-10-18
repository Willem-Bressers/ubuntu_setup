
# =============================================================================
# SETUP | tensorflow object detection API
# =============================================================================
if [ -d tensorflow/models ]; then
	CWD=$(pwd)

	git clone https://github.com/tensorflow/models.git $CWD/tensorflow/models

	# Dependencies
	conda install tensorflow Cython contextlib2 pillow lxml jupyter matplotlib

	# COCO API installation
	git clone https://github.com/cocodataset/cocoapi.git $CWD/cocoapi
	make --directory=$CWD/cocoapi/PythonAPI
	cp -r $CWD/cocoapi/PythonAPI/pycocotools $CWD/tensorflow/models/research/
	rm -rf $CWD/cocoapi

	# Protobuf Compilation
	cd $CWD/tensorflow/models/research/
	protoc object_detection/protos/*.proto --python_out=.
	cd $CWD

	# Add Libraries to PYTHONPATH
	export PYTHONPATH=$PYTHONPATH:$CWD/tensorflow/models/research/:$CWD/tensorflow/models/research/slim

	# Testing the Installation
	python $CWD/tensorflow/models/research/object_detection/builders/model_builder_test.py
fi


# =============================================================================
# TRAIN | tensorflow object detection API | pet detector
# =============================================================================
if [ -d data ]; then
	CWD=$(pwd)

	mkdir -p $CWD/{downloads,data,model_dir}

	# Add Libraries to PYTHONPATH
	export PYTHONPATH=$PYTHONPATH:$CWD/tensorflow/models/research/:$CWD/tensorflow/models/research/slim

	# get the data
	wget http://www.robots.ox.ac.uk/~vgg/data/pets/data/images.tar.gz -O $CWD/downloads/images.tar.gz
	wget http://www.robots.ox.ac.uk/~vgg/data/pets/data/annotations.tar.gz -O $CWD/downloads/annotations.tar.gz

	# extract the data
	tar -xf $CWD/downloads/images.tar.gz -C $CWD/downloads/
	tar -xf $CWD/downloads/annotations.tar.gz -C $CWD/downloads/

	# create tf-records
	python $CWD/tensorflow/models/research/object_detection/dataset_tools/create_pet_tf_record.py --label_map_path=$CWD/tensorflow/models/research/object_detection/data/pet_label_map.pbtxt --data_dir=$CWD/downloads --output_dir=$CWD/data
	cp $CWD/tensorflow/models/research/object_detection/data/pet_label_map.pbtxt $CWD/data/pet_label_map.pbtxt

	# Downloading a COCO-pretrained Model for Transfer Learning
	wget http://storage.googleapis.com/download.tensorflow.org/models/object_detection/faster_rcnn_resnet101_coco_11_06_2017.tar.gz  -O $CWD/downloads/faster_rcnn_resnet101_coco_11_06_2017.tar.gz
	tar -xf $CWD/downloads/faster_rcnn_resnet101_coco_11_06_2017.tar.gz -C $CWD/downloads/
	cp $CWD/downloads/faster_rcnn_resnet101_coco_11_06_2017/*.* $CWD/data/

	# Configuring the Object Detection Pipeline
	cp $CWD/tensorflow/models/research/object_detection/samples/configs/faster_rcnn_resnet101_pets.config $CWD/data/faster_rcnn_resnet101_pets.config
	sed -i "s|PATH_TO_BE_CONFIGURED|"$CWD"/data|g" $CWD/data/faster_rcnn_resnet101_pets.config

	# Starting Training and Evaluation
	python $CWD/tensorflow/models/research/object_detection/model_main.py --pipeline_config_path=$CWD/data/faster_rcnn_resnet101_pets.config --model_dir=$CWD/model_dir --num_train_steps=50000 --sample_1_of_n_eval_examples=1 --alsologtostderr &

	# Monitoring Progress with Tensorboard (visit http://$HOSTNAME:6006/ e.a. http://lubuntu:6006/)
	tensorboard --logdir=$CWD/model_dir &
fi