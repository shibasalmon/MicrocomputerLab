# MicrocomputerLab

NTUST-EE-Homework

## Install the Virtual-DOS-Machine (Need Docker)

`docker build -t v-dos .`

`docker run -dt --name dos -v ${PWD}:/root/.dosemu/drive_c v-dos`

## Execute the Virtual-DOS-Machine

`docker exec -it dos dosemu`

## Build the Assembly File and Link In Virtual-DOS-Machine

`masm5\masm [FILE]`

`masm5\link [FILE]`

## Exit the Virtual-DOS-Machine

`exitemu`