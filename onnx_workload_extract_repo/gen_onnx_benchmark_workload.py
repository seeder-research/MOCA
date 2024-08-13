# -*- coding: utf-8 -*-
"""
Created on Thu Mar 30 21:53:19 2023

@author: willi
"""

import os
import sys
from onnx_lib import *

MAIN_PATH=os.path.dirname(__file__)
sys.path.append(os.path.join(MAIN_PATH, '../'))

# Please proceed to https://github.com/onnx/models to download the specified onnx models before running this script
list_model_name = ['alexnet', 'vgg16', 'vgg19', 'resnet18', 'resnet34', 'resnet50', 'resnet101', 'resnet152']
list_model_path = ['bvlcalexnet-12-int8.onnx', 'vgg16-12-int8.onnx', 'vgg19-7.onnx', 'resnet18-v1-7.onnx', 'resnet34-v1-7.onnx', 'resnet50-v1-12-int8.onnx', 'resnet101-v1-7.onnx', 'resnet152-v1-7.onnx']

dataset = 'ImageNet'
is_save_weight = 0
is_save_node = 0
is_save_size = 0
is_save_pads_strides = 1
is_get_input_size = 1

for i in range(1, len(list_model_name)):
    model_name = list_model_name[i]
    working_path = model_name
    os.chdir(working_path)
    model_path = list_model_path[i]
    model = onnx.load(model_path)
    session = ort.InferenceSession(model.SerializeToString())
    
    if is_save_weight==1:
        save_onnx_weight(model, model_name)
    
    if is_save_size==1:
        save_onnx_size(model, model_name)
                    
    if is_save_node==1:
        save_onnx_node(model, model_name)
    
    if is_save_pads_strides == 1:
        save_onnx_pads_strides(model, model_name)
    
    if is_get_input_size == 1:
        get_input_size(dataset, model_name)
