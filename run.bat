SET CTF_FOLDER=%1
SET CURRENTDIR=%cd%
SET IMAGE_NAME=ssrtw/bmu

docker run -itd ^
	--rm ^
	-h %CTF_FOLDER% ^
	--name %CTF_FOLDER% ^
	-v %CURRENTDIR%/%CTF_FOLDER%:/ctf/work ^
	-p 23946:23946 ^
	--cap-add=SYS_PTRACE ^
	%IMAGE_NAME%

docker attach %CTF_FOLDER%