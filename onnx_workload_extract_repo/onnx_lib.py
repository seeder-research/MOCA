# -*- coding: utf-8 -*-
"""
Created on Mon Apr  3 12:19:51 2023

@author: willi
"""

import onnx
from onnx import numpy_helper
import numpy as np
from PIL import Image
import matplotlib.pyplot as plt
from google.protobuf.json_format import MessageToDict
# import onnxruntime as ort
# import cv2


def file_len(filename):
    with open(filename) as f:
        for i, _ in enumerate(f):
            pass
    return i + 1


def save_onnx_weight(model, model_name):
    INTIALIZERS = model.graph.initializer
    with open(model_name+'-weight.txt', 'w') as file:
        for initializer in INTIALIZERS:
            W = numpy_helper.to_array(initializer)
            W = np.ndarray. tolist(W)
            if type(W) == list:
                for i in W:
                    file.write(str(i)+' \n')
            file.write('\n\n\n next layer \n\n\n')
    return


def save_onnx_size(model, model_name):
    INTIALIZERS = model.graph.initializer
    with open(model_name+'-size.txt', 'w') as file:
        for initializer in INTIALIZERS:
            dims = []
            W= numpy_helper.to_array(initializer)
            W = np.ndarray. tolist(W)
            if type(W) == list:
                is_list = 1
                W = W.copy()
                while(is_list):
                    if type(W) == list:
                        length = len(W)
                        dims.append(length)
                        W = W[0]
                    else:
                        is_list = 0
                if len(dims)>1:
                    for i in dims:
                        file.write(str(i)+' ')
                    file.write('\n')
    return


def save_onnx_node(model, model_name):
    with open(model_name+'-node.txt', 'w') as file:
        # model is an onnx model
        graph = model.graph
        # graph inputs
        for input_name in graph.input:
            print(input_name)
        # graph parameters
        # for init in graph.init:
        #     print(init.name)
        # graph outputs
        for output_name in graph.output:
            print(output_name)
        # iterate over nodes
        for node in graph.node:
            # node inputs
            for idx, node_input_name in enumerate(node.input):
                print(idx, node_input_name)
                file.write(str(idx)+' '+str(node_input_name)+' \n')
            # node outputs
            for idx, node_output_name in enumerate(node.output):
                print(idx, node_output_name)
                file.write(str(idx)+' '+str(node_output_name)+' \n')
    return


def save_onnx_pads_strides(model, model_name):
    graph = model.graph
    with open(model_name+'-pads.txt', 'w') as file_pads:
        with open(model_name+'-strides.txt', 'w') as file_strides:
            for node in graph.node:
                if node.op_type == "QLinearConv" or node.op_type == 'Conv':
                    for i in node.attribute:
                        i = MessageToDict(i)
                        if i['name']=='pads':
                            # print("The pads are ", i['ints'])
                            for j in i['ints']:
                                file_pads.write(str(j)+' ')
                            file_pads.write('\n')
                        if i['name']=='strides':
                            # print("The strides are ", i['ints'])
                            for j in i['ints']:
                                file_strides.write(str(j)+' ')
                            file_strides.write('\n')
    
    with open(model_name+'-pool.txt', 'w') as file_pool:
        idx = 0
        for node in graph.node:
            line = []
            if node.op_type == "QLinearConv" or node.op_type == 'Conv':
                idx += 1
            if node.op_type == "MaxPool":
                line.append(idx)
                for i in node.attribute:
                    i = MessageToDict(i)
                    if i['name']=='kernel_shape':
                        line.append(i['ints'][0])
                    if i['name']=='pads':
                        line.append(i['ints'][0])
                    if i['name']=='strides':
                        line.append(i['ints'][0])
                
                for element in line:
                    file_pool.write(str(element)+' ')
                file_pool.write('\n')
    return
    
    
def get_input_size(dataset, model_name):
    if dataset == 'ImageNet':
        img_size = 224
    if dataset == 'MNIST':
        img_size = 28
        
    num_layer = file_len(model_name+'-size.txt')    
    num_conv = file_len(model_name+'-pads.txt')
    num_pool = file_len(model_name+'-pool.txt')
    
    list_kernel_size = []
    list_ifm_num = []
    list_ofm_num = []
    list_pads = []
    list_strides = []
    list_input_size = []
    list_pool_id = []
    list_pool_shape = []
    
    with open(model_name+'-pool.txt', 'r') as file:
        for i in range(num_pool):
            line = file.readline().strip('\n ').split(' ')
            line = [int(element) for element in line]
            list_pool_id.append(line[0])
            list_pool_shape.append(line[1])
            
    with open(model_name+'-size.txt', 'r') as file:
        for i in range(num_layer):
            line = file.readline().strip('\n ').split(' ')
            line = [int(element) for element in line]
            if len(line)==4:
                list_kernel_size.append(line[2])
                list_ifm_num.append(line[1])
                list_ofm_num.append(line[0])
            elif len(line)==2:
                list_ifm_num.append(line[0])
                list_ofm_num.append(line[1])
            else:
                print("Error on layer size")
                exit()
                
    with open(model_name+'-pads.txt', 'r') as file_pads:
        with open(model_name+'-strides.txt', 'r') as file_strides:
            for i in range(num_conv):
                line = file_pads.readline().strip('\n ').split(' ')
                line = [int(element) for element in line]
                list_pads.append(line[0])
                
                line = file_strides.readline().strip('\n ').split(' ')
                line = [int(element) for element in line]
                list_strides.append(line[0])
    
    '''
    print(list_kernel_size)
    print(list_ifm_num)
    print(list_ofm_num)
    print(list_pads)
    print(list_strides)
    '''
    
    idx_pool = 0
    pool_id = list_pool_id[0]
    pool_shape = list_pool_shape[0]
    for i in range(num_conv):
        if i==0:
            list_input_size.append(img_size)
        else:
            if i==pool_id:
                input_size = int((list_input_size[i-1]+list_pads[i]*2-(list_kernel_size[i]-1))/list_strides[i]/pool_shape)
                list_input_size.append(input_size)
                idx_pool += 1
                if idx_pool<num_pool:
                    pool_id = list_pool_id[idx_pool]
                    pool_shape = list_pool_shape[idx_pool]
            else:
                input_size = int((list_input_size[i-1]+list_pads[i]*2-(list_kernel_size[i]-1))/list_strides[i])
                list_input_size.append(input_size)
                
    with open(model_name+'-input.txt', 'w') as file:
        for i in list_input_size:
            file.write(str(i)+'\n')
            
    with open(model_name+'-mnlkps.txt', 'w') as file:
        for i in range(num_conv):
            line = []
            line.append(list_ifm_num[i])
            line.append(list_ofm_num[i])
            line.append(list_input_size[i])
            line.append(list_kernel_size[i])
            line.append(list_pads[i])
            line.append(list_strides[i])
            for element in line:
                file.write(str(element)+' ')
            file.write('\n')
    return


def get_image(path, show=False):
    with Image.open(path) as img:
        img = np.array(img.convert('RGB'))
    if show:
        plt.imshow(img)
        plt.axis('off')
    return img


def preprocess(img):
    img = img / 255.
    img = cv2.resize(img, (256, 256))
    h, w = img.shape[0], img.shape[1]
    y0 = (h - 224) // 2
    x0 = (w - 224) // 2
    img = img[y0 : y0+224, x0 : x0+224, :]
    img = (img - [0.485, 0.456, 0.406]) / [0.229, 0.224, 0.225]
    img = np.transpose(img, axes=[2, 0, 1])
    img = img.astype(np.float32)
    img = np.expand_dims(img, axis=0)
    return img


def predict(path, labels, session):
    img = get_image(path, show=False)
    img = preprocess(img)
    ort_inputs = {session.get_inputs()[0].name: img}
    preds = session.run(None, ort_inputs)[0]
    preds = np.squeeze(preds)
    a = np.argsort(preds)[::-1]
    print('class=%s ; probability=%f' %(labels[a[0]],preds[a[0]]))