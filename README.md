# ROOMOTION
## Introduction

## Requirements
- **The software has been tested using Python 3.8.12**
- **It is recommended to create a Python virtual environment**
### Python Packages
#### SER
- **tensorflow**
- **librosa**
- **numpy**
- **pandas**
- **soundfile**
- **wave**
- **sklearn**
- **tqdm**
- **matplotlib**
- **pyaudio**
#### EMOPIA
- **torch==1.7.0**
- **pytorch-fast-transformers**
- **scikit-learn==0.24.1**
- **seaborn==0.11.1**
- **numpy==1.19.5**
- **miditoolkit==0.1.14**
- **pandas==1.1.5**
- **ipdb**
- **tqdm**
- **matplotlib**
- **scipy**
- **pickle**
- **pygame**
- **pythonosc**
## Custom Changes
Inside EMOPIA/workspace/transformer/SER/Main.py:
- line 3: os.environ["XDG_RUNTIME_DIR"]="/run/user/1000" is only necessary on Linux systems that use PulseAudio.
- line 152: Change the /bin directory with the location of your Python virtual environment
- line 163/164: Change the hard-coded IP addresses with the addresses of your OSC servers
## How to use it

## Animations

Run the animations on Processing. The animations receive OSC messages, therefore if you changed some parameter in python script, check the parameters of the OSC Server. We suggest to use the animations on different displays becuase they run in fullscreen.
