# Base image with CUDA 12.9 and cuDNN support
FROM nvidia/cuda:13.0.1-cudnn-devel-ubuntu24.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Set HOME for portability
ENV HOME=/root

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-dev python3-venv \
    git curl wget unzip nano \
    && rm -rf /var/lib/apt/lists/*

# Make python3 the default
RUN ln -s /usr/bin/python3 /usr/bin/python

# Create a virtual environment
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Upgrade pip
RUN pip install --upgrade pip

# Install latest nightly PyTorch build with CUDA 
RUN pip install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu130

# Install JupyterLab and vim extension
RUN pip install jupyterlab jupyterlab_vim

# Copy your requirements.txt and install other packages if needed
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Expose Jupyter Notebook port
EXPOSE 8888

# Set working directory
WORKDIR /workspace

# Default command (can be overridden in docker-compose)
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]

