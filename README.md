# Parallel-DistributedComputing

1.   Постановка задачи
Необходимо вывести 32 степени 2 (20, 21, 22, …).

2.   Аппаратное обеспечение и ПО
Лабораторная работа №1 была выполнена в среде разработки Jupyter Notebook в Google Colaboratory.
Для запуска CUDA C/C++ необходимо перейти по ссылке https://colab.research.google.com в браузере и нажать «Новый блокнот». 
Далее надо переключить среду выполнения с CPU на GPU и полностью удалить все предыдущие версии CUDA для обновления облачного экземпляра CUDA.

!apt - get --purge remove cuda nvidia * libnvidia - *
!dpkg - l | grep cuda - | awk '{print $2}' | xargs - n1 dpkg --purge
!apt - get remove cuda - *
!apt autoremove
!apt - get update

Далее необходимо установить CUDA версии 9.2.

!wget https ://developer.nvidia.com/compute/cuda/9.2/Prod/local_installers/cuda-repo-ubuntu1604-9-2-local_9.2.88-1_amd64 -O cuda-repo-ubuntu1604-9-2-local_9.2.88-1_amd64.deb
!dpkg - i cuda - repo - ubuntu1604 - 9 - 2 - local_9.2.88 - 1_amd64.deb
!apt - key add / var / cuda - repo - 9 - 2 - local / 7fa2af80.pub
!apt - get update
!apt - get install cuda - 9.2
!apt --fix - broken install
!sudo dpkg - i --force - overwrite / var / cuda - repo - 9 - 2 - local / . / nvidia - 396_396.26 - 0ubuntu1_amd64.deb
!sudo apt - get - o Dpkg::Options:: = "--force-overwrite" install cuda

Для проверки установки CUDA можно выполнить следующую команду:

!nvcc --version

На последнем шаге необходимо запустить установку расширения для запуска nvcc из Notebook и загрузить расширение.

!pip install git + https://github.com/andreinechaev/nvcc4jupyter.git
% load_ext nvcc_plugin
