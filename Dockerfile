FROM quay.io/redhat-github-actions/runner:latest as runner
LABEL org.opencontainers.image.source https://github.com/vemonet/github-actions-conda-runner

USER root
RUN chown -R $UID:$GID /opt

RUN sed -i "s/\.\/uid\.sh/#.\/uid.sh/g" /home/${USERNAME}/entrypoint.sh

# USER $UID

# Install conda
ENV CONDA_DIR=/opt/conda \
    SHELL=/bin/bash \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8
ENV PATH="${CONDA_DIR}/bin:${PATH}" \
    CONDA_VERSION="${conda_version}"

RUN export download_url=$(curl -s https://api.github.com/repos/conda-forge/miniforge/releases/latest | grep browser_download_url | grep -P "Mambaforge-\d+((\.|-)\d+)*-Linux-x86_64.sh" | grep -v sha256 | cut -d '"' -f 4) && \
    echo "Downloading latest miniforge from $download_url" && \
    curl -Lf -o miniforge.sh $download_url && \
    # curl -Lf "https://github.com/conda-forge/miniforge/releases/download/${miniforge_version}/${miniforge_installer}" -o miniforge.sh && \
    /bin/bash "miniforge.sh" -f -b -p "${CONDA_DIR}" && \
    rm "miniforge.sh" && \
    conda config --system --set auto_update_conda false && \
    conda config --system --set show_channel_urls true

RUN conda install --quiet -y \
    conda \
    pip \
    wget \
    nodejs \
    yarn \
    openjdk \
    maven
RUN conda update --all --quiet -y && \
    conda clean --all -f -y 
